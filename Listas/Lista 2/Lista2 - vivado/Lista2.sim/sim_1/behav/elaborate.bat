@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xelab  -wto 3666c340aa1d46e6a9c0d62ddbb780d4 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot tb_matrix_mult_behav xil_defaultlib.tb_matrix_mult -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
