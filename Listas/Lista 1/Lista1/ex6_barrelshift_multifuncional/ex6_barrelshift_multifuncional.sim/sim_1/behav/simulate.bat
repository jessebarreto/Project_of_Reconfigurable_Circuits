@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xsim tb_ex6_barrelshift_multifuncional_behav -key {Behavioral:sim_1:Functional:tb_ex6_barrelshift_multifuncional} -tclbatch tb_ex6_barrelshift_multifuncional.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
