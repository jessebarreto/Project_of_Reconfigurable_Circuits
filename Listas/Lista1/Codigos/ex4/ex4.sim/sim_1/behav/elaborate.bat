@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xelab  -wto 049aeb83cf77458aa3718700a89d00ce -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot tb_ex4_behav xil_defaultlib.tb_ex4 -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
