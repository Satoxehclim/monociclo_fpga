/*
	Grupo:			5CV3
	Proyecto:   	monociclo_FPGA
	Archivo:			sll1bit.v
	Equipo:			Equipo 3
	Integrantes:	Abraham Roman Ramírez
						Andrade Jiménez Jonathan 
						Brenda Vergara Martínez
						Kaleb Yael De La Rosa Gutiérrez
						Osmar Alejandro Garcia Jiménez
	Descripcion: 	Este modulo solo hace el desplazamiento necesario para las operaciones
						tipo branch
*/

module sll1bit(
	input		[31:0] entrada_i,
	output	[31:0] salida_o
);
	assign 	salida_o = entrada_i << 1;
endmodule 
