/*
	Grupo:5CV3
	Proyecto:    monociclo_FPGA
	Archivo:extensiondesigno.v
	Equipo:Equipo 3
	Integrantes:Abraham Roman Ramírez
					Andrade Jiménez Jonathan 
					Brenda Vergara Martínez
					Kaleb Yael De La Rosa Gutiérrez
					Osmar Alejandro Garcia Jiménez
	Descripcion: Este archivo implementa una salida para los codigos para los display
					 para que aparezca la salida en hexadecimal
						
*/
module Disp7segs (

	input 			[3:0] entrada_i,
	output reg 		[6:0] salida_o

);
	
	always @(*)
	begin
		case (entrada_i)
		4'b0000:
			salida_o = 7'b1000000;//0
		4'b0001:
			salida_o = 7'b1111001;//1
		4'b0010:
			salida_o = 7'b0100100;//2
		4'b0011:
			salida_o = 7'b0110000;//3
		4'b0100:
			salida_o = 7'b0011001;//4
		4'b0101:
			salida_o = 7'b0010010;//5
		4'b0110:
			salida_o = 7'b0000010;//6
		4'b0111:
			salida_o = 7'b0111000;//7
		4'b1000:
			salida_o = 7'b0000000;//8
		4'b1001:
			salida_o = 7'b0011000;//9
		4'b1010:
			salida_o = 7'b0001000;//A
		4'b1011:
			salida_o = 7'b0000011;//B
		4'b1100:
			salida_o = 7'b1000110;//C
		4'b1101:
			salida_o = 7'b0100001;//D
		4'b1110:
			salida_o = 7'b0000110;//E
		4'b1111:
			salida_o = 7'b0001110;//F
		endcase 
	end
	
endmodule 