@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xelab  -wto f16d74526eeb40d2ac630b18c3901673 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot tb_ex3_behav xil_defaultlib.tb_ex3 -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
