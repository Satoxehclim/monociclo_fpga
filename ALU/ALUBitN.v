module ALUBitN (
	input 	a_i,
	input 	b_i,
	input 	c_i,
	input 	invert_i,
	input 	less_i,
	input 	lessunsigned_i,
	input 	[2:0] operacion_i,
	output 	reg salida_o,
	output 	c_o,
	output 	set_o,
	output 	setunsigned_o
);

//Seccion de definicion de señales
	wire 		ab1_w;
	wire 		ab2_w;
	wire		ab3_w;
	wire		salidasum_w;   // Salida del sumador completo
	wire 		nob_w;
	wire 		selb_w;

	//AND Gate
	assign 	ab1_w = a_i & selb_w;
	//OR Gate
	assign 	ab2_w = a_i | selb_w;
	//XOR gate
	assign 	ab3_w = a_i ^ selb_w;
	
	//Sumador - Restador
	assign 	nob_w = ~b_i;
	assign 	selb_w = (invert_i) ? nob_w : b_i;
	
	//Instancia del sumador
	fulladder fa1bit(
		.a_i 		(a_i),
		.b_i 		(selb_w),
		.c_i 		(c_i),
		.c_o 		(c_o),
		.s_o 		(salidasum_w)
	);
	
	assign 			set_o = salidasum_w;
	assign 			setunsigned_o = ~c_o;
	//Selector 2 - 1
	//assign salida_o = (operacion_i) ? ab2_w : ab1_w;
	//Selector 3 -1
	always @(*)
	begin 
		 case(operacion_i)
			3'b000: 	salida_o = salidasum_w;	//Suma 	(0)
			3'b001: 	salida_o = 1'b0;			// 		(1)
			3'b010: 	salida_o = less_i;	   //SLT 	(2)
			3'b011:	salida_o = 1'b0;			// 		(3)
			3'b100:	salida_o = 1'b0;			// 		(4)
			3'b101:	salida_o = ab3_w;			//XOR 	(5)
			3'b110:	salida_o = ab2_w;			//OR 		(6)
			3'b111:  salida_o = ab1_w; 		//AND 	(7)
			default: salida_o = 1'b0;
		 endcase
	end 
endmodule 

