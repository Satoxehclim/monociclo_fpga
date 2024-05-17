/*
	Grupo:5CV3
	Proyecto:    monociclo_FPGA
	Archivo:monociclo.v
	Equipo:Equipo 3
	Integrantes:Abraham Roman Ramírez
					Andrade Jiménez Jonathan 
					Brenda Vergara Martínez
					Kaleb Yael De La Rosa Gutiérrez
					Osmar Alejandro Garcia Jiménez
	Descripcion:Este es el archivo que hace una suma de 4 cada que
					se obtiene un flanco positivo en el reloj 
						
*/

module monociclo_fpga (

	input				push_i,
	input				clk_i,
	output			[6:0] displ0_o,
	output			[6:0] displ1_o,
	output			[6:0] displ2_o,
	output			[6:0] displ3_o,
	output			[6:0] displ4_o,
	output			[6:0] displ5_o,
	output			[6:0] displ6_o,
	output			[6:0] displ7_o

);
	//definicion de señales
	wire 				[31:0] salida_o;
	wire 				clk_Div_o;
	//monociclo
	
	monociclo PC(

		.clk_i		(clk_Div_o),
		.rst_ni		(push_i),
		.salida_o	( salida_o[31:0])

	);
	
	//Instancia del divisor de frecuencia
	divFreq divisor (	
		.divF_clk_i 		(clk_i),
		.divF_rst_i			(push_i),
		.divF_clk_o 		(clk_Div_o)

	);
	
	
	
	//Displays 7 segmentos

	Disp7segs Disp0(

		.entrada_i		(salida_o[3:0]),
		.salida_o		(displ0_o)

	);
	
	Disp7segs Disp1(

		.entrada_i		(salida_o[7:4]),
		.salida_o		(displ1_o)

	);
	
	Disp7segs Disp2(

		.entrada_i		(salida_o[11:8]),
		.salida_o		(displ2_o)

	);
	
	Disp7segs Disp3(

		.entrada_i		(salida_o[15:12]),
		.salida_o		(displ3_o)

	);
	
	Disp7segs Disp4(

		.entrada_i		(salida_o[19:16]),
		.salida_o		(displ4_o)

	);
	
	Disp7segs Disp5(

		.entrada_i		(salida_o[23:20]),
		.salida_o		(displ5_o)

	);
	
	Disp7segs Disp6(

		.entrada_i		(salida_o[27:24]),
		.salida_o		(displ6_o)

	);
	
	
	Disp7segs Disp7(

		.entrada_i		(salida_o[31:28]),
		.salida_o		(displ7_o)

	);


endmodule