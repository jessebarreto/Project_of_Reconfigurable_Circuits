@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xelab  -wto 6df2bee3aa854df08e2fd39c7ea67c9a -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot tb_ex7_somador_2_behav xil_defaultlib.tb_ex7_somador_2 -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
