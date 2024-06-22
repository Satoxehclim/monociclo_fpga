/*
	Grupo:			5CV3
	Proyecto:   	monociclo_FPGA
	Archivo:			decodificador.v
	Equipo:			Equipo 3
	Integrantes:	Abraham Roman Ramírez
						Andrade Jiménez Jonathan 
						Brenda Vergara Martínez
						Kaleb Yael De La Rosa Gutiérrez
						Osmar Alejandro Garcia Jiménez
	Descripcion: 	Esta estapa decodifica el opcode de forma que controla las etapas y cuando
						tienen que escribir o leer los registros implementados
						
*/
module decodificador( //etapa de control 
  input			[6:0] opcode_i,
  output 	reg   	regwrite_o,
  output 	reg   	alusrc_o,
  output 	reg   	memwrite_o,
  output 	reg   	memread_o,
  output		reg		memtoreg_o,
  output		reg		branch_o,
  output		reg		jalFlag_o
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
					branch_o		=	1'b0;
					jalFlag_o	=	1'b0;
				end
			7'b0110011:     //tipo R
				begin 
					regwrite_o	=	1'b1;
					alusrc_o 	=  1'b0;
					memwrite_o  =  1'b0;
					memread_o   =  1'b0;
					memtoreg_o  =  1'b0;
					branch_o		=	1'b0;
					jalFlag_o	=	1'b0;
				end	
			7'b0100011:     //tipo S
				begin 
					regwrite_o	=	1'b0;
					alusrc_o 	=  1'b1;
					memwrite_o  =  1'b1;
					memread_o   =  1'b0;
					memtoreg_o  =  1'b0;
					branch_o		=	1'b0;
					jalFlag_o	=	1'b0;
				end	
			7'b0000011:     //tipo Load
				begin 
					regwrite_o	=	1'b0;
					alusrc_o 	=  1'b1;
					memwrite_o  =  1'b0;
					memread_o   =  1'b1;
					memtoreg_o  =  1'b1;
					branch_o		=	1'b0;
					jalFlag_o	=	1'b0;
				end
			7'b1100011:     //tipo branch
				begin 
					regwrite_o	=	1'b0;
					alusrc_o 	=  1'b0;
					memwrite_o  =  1'b0;
					memread_o   =  1'b0;
					memtoreg_o  =  1'b0;
					branch_o		=	1'b1;
					jalFlag_o	=	1'b0;
				end
			7'b1101111:     //tipo JAL
				begin 
					regwrite_o	=	1'b0;
					alusrc_o 	=  1'b0;
					memwrite_o  =  1'b0;
					memread_o   =  1'b0;
					memtoreg_o  =  1'b0;
					branch_o		=	1'b0;
					jalFlag_o	=	1'b1;
				end
			default:   //instruccion no soportada  
				begin 
					regwrite_o  =  1'b0;
					alusrc_o    =  1'b0;
					memwrite_o  =  1'b0;
					memread_o   =  1'b0;
				   memtoreg_o  =  1'b0;	
					branch_o		=	1'b0;
					jalFlag_o	=	1'b0;
				end
		endcase 
	end
endmodule 