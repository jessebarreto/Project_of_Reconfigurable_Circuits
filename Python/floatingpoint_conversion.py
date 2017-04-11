

# Converse Binary to Floating Point Numbers using Standard IEEE-754

# Import modules
import numpy as np

# Returns an array representing the binary representation of a number in word_size bits.
def int2bin(number, word_size = 64):
    return ''.join(str(1 & int(number) >> i) for i in range(word_size)[::-1])

def float2fixedbin(number, word_size_int=32, word_size_dec=32):
	int_part = np.abs(np.floor(number))
	dec_part = np.abs(number) - int_part
	int_bin = int2bin(int_part, word_size_int)

	dec_bin = "";
	for i in range(0, word_size_dec):
		dec_part *= 2
		if dec_part >= 1:
			dec_bin = dec_bin + str(1)
			dec_part = dec_part - 1
		else:
			dec_bin = dec_bin + str(0)

	return int_bin + dec_bin


def float2bin(number, expoent_size = 8, mantissa_size = 23):
	signal_bin = "";
	if number >= 0:
		signal_bin += str(0)
	else:
		signal_bin += str(1)

	fixed_bin = float2fixedbin(number, mantissa_size, mantissa_size)
	int_bin = ""
	begin_flag = True
	for i in range(0,mantissa_size):
		if begin_flag and fixed_bin[i] == str(1):
			begin_flag = False
		if not begin_flag:
			int_bin += fixed_bin[i]
	if len(int_bin) == 0:
		int_bin = "0"


	# Normaliza e Calcula o expoente
	bias = (2**(expoent_size - 1)) - 1
	if len(int_bin) == 1:
		if int_bin[0] == str(0):
			exp = 0
			for i in range(mantissa_size,2*mantissa_size):
				exp -= 1
				if fixed_bin[i] == str(1):
					break
				if i == 2*mantissa_size - 1:
					exp = -bias
					break

			mantissa_bin = fixed_bin[mantissa_size:]
		else:
			exp = 1
			mantissa_bin = fixed_bin[mantissa_size:]
	else:
		exp = len(int_bin) - 1
		mantissa_bin = int_bin[1:] + fixed_bin[mantissa_size:2*mantissa_size - exp]

	# Expoente Binario
	exp += bias
	expoent_bin = int2bin(exp, expoent_size)


	return signal_bin + expoent_bin + mantissa_bin #int_bin

	return dec_bin

def bin2float(number_bin, expoent_size = 8, mantissa_size = 23):
	# Signal
	if number_bin[0] == '1':
		signal = -1;
	else:
		signal = 1;

	expoent_bin = number_bin[1:expoent_size+1]
	
	# Expoent
	expoent = 0;
	for i in range(0, len(expoent_bin)):
		if expoent_bin[i] == '1':
			expoent += 2**(expoent_size-i-1)
	
	bias = (2**(expoent_size - 1)) - 1
	expoent -= bias

	#Mantissa
	mantissa_bin = number_bin[expoent_size+1:]
	mantissa = 0
	for i in range(0, len(mantissa_bin)):
		if mantissa_bin[i] == '1':
			mantissa += 2**(-1*(i+1))
	
	if mantissa == 0:
		return 0

	result = (2**expoent)
	result *= signal
	result *= (1 + mantissa)
	return result

def main():
	print(bin2float(float2bin(11.75)))

#this calls the 'main' function when this script is executed
if __name__ == '__main__':
    main()