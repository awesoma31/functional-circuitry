transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/gwert/_itmo/fc_lab3/lab3/fec_saylinx_project_example-master {C:/Users/gwert/_itmo/fc_lab3/lab3/fec_saylinx_project_example-master/fec_saylinx_board_top.v}
vlog -vlog01compat -work work +incdir+C:/Users/gwert/_itmo/fc_lab3/lab3/fec_saylinx_project_example-master {C:/Users/gwert/_itmo/fc_lab3/lab3/fec_saylinx_project_example-master/seg_display_ctrl.v}
vlog -vlog01compat -work work +incdir+C:/Users/gwert/_itmo/fc_lab3/lab3/fec_saylinx_project_example-master {C:/Users/gwert/_itmo/fc_lab3/lab3/fec_saylinx_project_example-master/hex_to_7seg.v}
vlog -vlog01compat -work work +incdir+C:/Users/gwert/_itmo/fc_lab3/lab3/fec_saylinx_project_example-master {C:/Users/gwert/_itmo/fc_lab3/lab3/fec_saylinx_project_example-master/mult.v}
vlog -vlog01compat -work work +incdir+C:/Users/gwert/_itmo/fc_lab3/lab3/fec_saylinx_project_example-master {C:/Users/gwert/_itmo/fc_lab3/lab3/fec_saylinx_project_example-master/func.v}

vlog -vlog01compat -work work +incdir+C:/Users/gwert/_itmo/fc_lab3/lab3/fec_saylinx_project_example-master {C:/Users/gwert/_itmo/fc_lab3/lab3/fec_saylinx_project_example-master/fec_saylinx_board_top_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  fec_saylinx_board_top_tb

do C:/Users/gwert/_itmo/fc_lab3/lab3/fec_saylinx_project_example-master/sim.do
