@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xsim tb_matrix_mult_behav -key {Behavioral:sim_1:Functional:tb_matrix_mult} -tclbatch tb_matrix_mult.tcl -view C:/Xilinx/Projetos_PCR/Lista2/tb_sobel_behav_250x250.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
