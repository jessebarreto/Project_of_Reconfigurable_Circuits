@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xelab  -wto b0d3694b26044e95966ba221c00ee9a8 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot tb_ex5_greaterthan_4bits_behav xil_defaultlib.tb_ex5_greaterthan_4bits -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
