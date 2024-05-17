transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Xehcl/OneDrive/Documentos/Arquitectura\ de\ computadoras/monociclo_fpga/monociclo {C:/Users/Xehcl/OneDrive/Documentos/Arquitectura de computadoras/monociclo_fpga/monociclo/monociclo.v}
vlog -vlog01compat -work work +incdir+C:/Users/Xehcl/OneDrive/Documentos/Arquitectura\ de\ computadoras/monociclo_fpga {C:/Users/Xehcl/OneDrive/Documentos/Arquitectura de computadoras/monociclo_fpga/Disp7segs.v}
vlog -vlog01compat -work work +incdir+C:/Users/Xehcl/OneDrive/Documentos/Arquitectura\ de\ computadoras/monociclo_fpga {C:/Users/Xehcl/OneDrive/Documentos/Arquitectura de computadoras/monociclo_fpga/monociclo_fpga.v}
vlog -vlog01compat -work work +incdir+C:/Users/Xehcl/OneDrive/Documentos/Arquitectura\ de\ computadoras/monociclo_fpga {C:/Users/Xehcl/OneDrive/Documentos/Arquitectura de computadoras/monociclo_fpga/divFreq.v}
vlog -vlog01compat -work work +incdir+C:/Users/Xehcl/OneDrive/Documentos/Arquitectura\ de\ computadoras/monociclo_fpga/regfile {C:/Users/Xehcl/OneDrive/Documentos/Arquitectura de computadoras/monociclo_fpga/regfile/regfile.v}
vlog -vlog01compat -work work +incdir+C:/Users/Xehcl/OneDrive/Documentos/Arquitectura\ de\ computadoras/monociclo_fpga/icache {C:/Users/Xehcl/OneDrive/Documentos/Arquitectura de computadoras/monociclo_fpga/icache/icache.v}

vlog -vlog01compat -work work +incdir+C:/Users/Xehcl/OneDrive/Documentos/Arquitectura\ de\ computadoras/monociclo_fpga/simulation/modelsim {C:/Users/Xehcl/OneDrive/Documentos/Arquitectura de computadoras/monociclo_fpga/simulation/modelsim/monociclo_fpga.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  monociclo_Simulator

add wave *
view structure
view signals
run -all
