/*
	Grupo:			5CV3
	Proyecto:   	monociclo_FPGA
	Archivo:			ALUNBits.v
	Equipo:			Equipo 3
	Integrantes:	Abraham Roman Ramírez
						Andrade Jiménez Jonathan 
						Brenda Vergara Martínez
						Kaleb Yael De La Rosa Gutiérrez
						Osmar Alejandro Garcia Jiménez
	Descripcion: 	Este archivo hace una instancia de la ALU de 10 operraciones a 32 bits
						e instancia el modulo shift comparando tambien el bit 3 para saber si es un shift
						o es la salida de la ALU
						
*/
module ALUNBits #(
	parameter 			N = 4
)
(
	input				[N-1:0]		a_i,
	input 			[N-1:0]		b_i,
	input 							c_i,
	input 							invert_i,
	input 			[3:0] 		operacion_i,

	
	output		   reg[N-1:0] 	salida_o,
	output							c_o
	

);
	wire 				[N:0] 	carries_w;
	wire				[N-1:0] 	salida_shift;
	wire				[N-1:0] 	salida_alu;
	
	wire							set_o;
	wire							setunsigned_o;
	
	
	assign 				carries_w[0] = c_i;
	
	//variable para utilizar en el bucle
	genvar i;
	generate
	
		for(i = 0; i < N; i = i + 1)
			begin: alubucle
				//Instancia de la ALU de 1 Bit
				case (i)
				0:
					ALU ALUBit0(
					.a_i				(a_i[i]),
					.b_i				(b_i[i]),
					.c_i				(carries_w[i]),
					.invert_i		(invert_i),
					.less_i			(set_o),
					.lessunsigned_i(setunsigned_o),
					.operacion_i	(operacion_i[2:0]),
					.salida_o		(salida_alu[i]),
					.c_o				(carries_w[i+1])
					);
				N-1:
					ALUBitN ALUBitN_1(
					.a_i				(a_i[i]),
					.b_i				(b_i[i]),
					.c_i				(carries_w[i]),
					.invert_i		(invert_i),
					.less_i			(),
					.lessunsigned_i(),
					.operacion_i	(operacion_i[2:0]),
					.salida_o		(salida_alu[i]),
					.c_o				(carries_w[i+1]),
					.set_o			(set_o),
					.setunsigned_o (setunsigned_o)
					);
				default:
					ALU ALUBitX(
					.a_i				(a_i[i]),
					.b_i				(b_i[i]),
					.c_i				(carries_w[i]),
					.invert_i		(invert_i),
					.less_i			(1'b0),
					.lessunsigned_i(1'b0),
					.operacion_i	(operacion_i[2:0]),
					.salida_o		(salida_alu[i]),
					.c_o				(carries_w[i+1])
					);
				endcase
			end
	
	endgenerate
	
	
	assign 				c_o = carries_w[N];
	

	// Instancia del módulo shift
	shift #(
		.N				(N)
		) 
		shift_u
		(
		 .a_i(a_i),
		 .b_i(b_i),
		 .operacion_i(operacion_i[1:0]),
		 .salida_o(salida_shift)
	);
	
	// Selección entre operaciones de desplazamiento y ALU normal
    always @(*) begin
		 if (operacion_i[3] == 1'b1) begin
			  salida_o  <= salida_shift;  // Resultado del módulo shift
		 end 
		 else begin
           salida_o  <= salida_alu;  // Resultado de la alu
		 end
    end
	
endmodule