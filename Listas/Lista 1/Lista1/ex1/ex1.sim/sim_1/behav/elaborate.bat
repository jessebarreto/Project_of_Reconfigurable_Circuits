@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xelab  -wto e7a82133a4f245abad189515361b0b05 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot exerc1_testbench_behav xil_defaultlib.exerc1_testbench -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
