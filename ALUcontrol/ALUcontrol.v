/*
	Grupo:			5CV3
	Proyecto:   	monociclo_FPGA
	Archivo:			ALUcontrol.v
	Equipo:			Equipo 3
	Integrantes:	Abraham Roman Ramírez
						Andrade Jiménez Jonathan 
						Brenda Vergara Martínez
						Kaleb Yael De La Rosa Gutiérrez
						Osmar Alejandro Garcia Jiménez
	Descripcion: 	Este archivo sirve como control de la alu obteniendo opcode, func3 
						y el quinto bit de func7 para obtener el codigo de operacion que debe
						hacer la ALU
						
*/
module ALUcontrol (
	input			[6:0] opcode_i,
	input			[2:0] func3_i,
	input				   func7_i,
	output		reg[3:0] ALUoperation_o
);
	always @(*)
	begin
		case(opcode_i)
			7'b0010011:     //tipo I
				begin 
					case(func3_i)
					3'b000:					//addi
						   begin
								ALUoperation_o = 4'b0000;
							end
					3'b010:					//slti
						   begin
								ALUoperation_o = 4'b0101;
							end
					3'b011:					//sltiu
						   begin
								ALUoperation_o = 4'b0110;
							end
					3'b100:					//xori
						   begin
								ALUoperation_o = 4'b0011;
							end
					3'b110:					//ori
						   begin
								ALUoperation_o = 4'b0010;
							end
					3'b111:					//andi
						   begin
								ALUoperation_o = 4'b0001;
							end
					3'b001:					//slli
						   begin
								ALUoperation_o = 4'b1000;
							end
					3'b101:					//shift right
						   begin
								case(func7_i)
									1'b0:		//logical i
										begin
											ALUoperation_o = 4'b1001;
										end
									1'b1:		//arithmetic i
										begin
											ALUoperation_o = 4'b1010;
										end
									default:
										begin
											ALUoperation_o = 4'b0000;
										end
								endcase
							end
					default:
							begin
								ALUoperation_o = 4'b0000;
							end
					endcase
				end	
			7'b0110011:     //tipo R
				begin 
					case({func7_i,func3_i})
					4'b0000:					//add
						   begin
								ALUoperation_o = 4'b0000;
							end
					4'b1000:					//sub
						   begin
								ALUoperation_o = 4'b1000;
							end
					4'b0001:					//sll
						   begin
								ALUoperation_o = 4'b1000;
							end
					4'b0010:					//slt
						   begin
								ALUoperation_o = 4'b0101;
							end
					4'b0011:					//sltu
						   begin
								ALUoperation_o = 4'b0110;
							end
					4'b0100:					//xor
						   begin
								ALUoperation_o = 4'b0011;
							end
					4'b0101:					//srl
						   begin
								ALUoperation_o = 4'b1001;
							end
					4'b1101:					//sra
						   begin
								ALUoperation_o = 4'b1010;
							end
					4'b0110:					//or
						   begin
								ALUoperation_o = 4'b0010;
							end
					4'b0111:					//and
						   begin
								ALUoperation_o = 4'b0001;
							end
					default:
							begin
								ALUoperation_o = 4'b0000;
							end
					endcase
				end	
			7'b0100011:     //tipo S
				begin 
					ALUoperation_o = 4'b0000;
				end	
			7'b0000011:     //tipo Load
				begin 
					ALUoperation_o = 4'b0000;
				end
			default:   //instruccion no soportada  
				begin 
					ALUoperation_o = 4'b0000;
				end
		endcase 
	end
endmodule 