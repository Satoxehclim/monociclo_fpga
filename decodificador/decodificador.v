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
	Descripcion:Esta estapa decodifica el opcode pasa ver si se debe escribir en el banco de registros
						
*/
module decodificador( //etapa de control 
  input			[6:0] opcode_i,
  output 	reg   	regwrite_o,
  output 	reg   	alusrc_o,
  output 	reg   	memwrite_o,
  output 	reg   	memread_o,
  output		reg		memtoreg_o
);

	//wire  [6:0]  opcode_w;
	//assign       opcode_w = instruccion_i[6:0];

	always @(*)
	begin
		case(opcode_i)
			7'b0010011:     //tipo I
				begin 
					regwrite_o	=	1'b1;
					alusrc_o 	=  1'b1;
					memwrite_o  =  1'b0;
					memread_o   =  1'b0;
					memtoreg_o  =  1'b0;
				end
			7'b0110011:     //tipo R
				begin 
					regwrite_o	=	1'b1;
					alusrc_o 	=  1'b0;
					memwrite_o  =  1'b0;
					memread_o   =  1'b0;
					memtoreg_o  =  1'b0;
				end	
			7'b0100011:     //tipo S
				begin 
					regwrite_o	=	1'b0;
					alusrc_o 	=  1'b1;
					memwrite_o  =  1'b1;
					memread_o   =  1'b0;
					memtoreg_o  =  1'b0;
				end	
			7'b0000011:     //tipo Load
				begin 
					regwrite_o	=	1'b0;
					alusrc_o 	=  1'b1;
					memwrite_o  =  1'b0;
					memread_o   =  1'b1;
					memtoreg_o  =  1'b1;
				end
			default:   //instruccion no soportada  
				begin 
					regwrite_o  =  1'b0;
					alusrc_o    =  1'b0;
					memwrite_o  =  1'b0;
					memread_o   =  1'b0;
				   memtoreg_o  =  1'b0;	
				end
		endcase 
	end
endmodule 