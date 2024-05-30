/*
	Grupo:			5CV3
	Proyecto:   	monociclo_FPGA
	Archivo:			flagDetector.v
	Equipo:			Equipo 3
	Integrantes:	Abraham Roman Ramírez
						Andrade Jiménez Jonathan 
						Brenda Vergara Martínez
						Kaleb Yael De La Rosa Gutiérrez
						Osmar Alejandro Garcia Jiménez
	Descripcion: 	Este modulo solo hace el desplazamiento necesario para las operaciones
						tipo branch
*/

module flagDetector(
	input					branch_i,
	input		[2:0]		func3_i,
	input 	[31:0]	salida_i,
	output	reg		branchFlag_o
);
	always @(*)
	begin
		if(branch_i)
		begin
			case(func3_i)
				3'b000:  //beq
				begin
					branchFlag_o = ~(|salida_i);
				end
				3'b001:	//bne
				begin
					branchFlag_o = |salida_i;
				end
				3'b100:	//blt
				begin
					branchFlag_o = |salida_i;
				end
				3'b101:	//bge
				begin
					branchFlag_o = ~(|salida_i);
				end
				default:
				begin
					branchFlag_o = 1'b0;
				end
			endcase
		end
	end
endmodule 