/*
	Grupo:			5CV3
	Proyecto:   	monociclo_FPGA
	Archivo:			extensiondesigno.v
	Equipo:			Equipo 3
	Integrantes:	Abraham Roman Ramírez
						Andrade Jiménez Jonathan 
						Brenda Vergara Martínez
						Kaleb Yael De La Rosa Gutiérrez
						Osmar Alejandro Garcia Jiménez
	Descripcion:	Este archivo extiende el signo de mi inmediato en mi funcion obtenida
						
*/

module extensiondesigno  #(
	parameter      IMM = 20
) 
(
	input			[31:0] instruccion_i, 
	output   reg[31:0] inmediato_o


);

	wire  		[6:0]  opcode_w;
	assign		       opcode_w = instruccion_i[6:0];
	
	always @(*)
	begin
		case(opcode_w)
		7'b0010011:       //Tipo I
						inmediato_o = {{IMM{instruccion_i[31]}},instruccion_i[31:20]};
		7'b0100011:       //Tipo S
						inmediato_o = {{IMM{instruccion_i[31]}},instruccion_i[31:25],instruccion_i[11:7]};
		7'b0000011:       //Tipo Load
						inmediato_o = {{IMM{instruccion_i[31]}},instruccion_i[31:20]};
			default: 
						inmediato_o = 32'b0;              
		endcase
	end
endmodule 