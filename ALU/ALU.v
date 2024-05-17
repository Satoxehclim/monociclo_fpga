module ALU (
	input 	a_i, 						//Entrada A
	input 	b_i, 						//Entrada B
	input 	c_i, 						//Acarreo de entrada
	input 	invert_i, 				//Inversor de B
	input 	less_i, 					//Entrada set if less than
	input 	lessunsigned_i, 		//Entrada set if less than unsigned 
	input 	[2:0] operacion_i, 	//Codigo de operacion
	output 	reg salida_o, 			//Resulado de la operación
	output 	c_o 						//Acarreo de salida
);

	// **Seccion de definicion de señales**
	// Señales para operaciones lógicas básicas
	wire 		ab1_w; 			// AND de A y B
	wire 		ab2_w; 			// OR de A y B
	wire		ab3_w; 			// XOR de A y B
	wire		salidasum_w;   // Salida del sumador completo
	wire 		nob_w; 			//NOT B
	wire 		selb_w; 			// Selector entre B y NOT B
	
	//Sumador - Restador
	assign 	nob_w = ~b_i; //NOT B
	assign 	selb_w = (invert_i) ? nob_w : b_i; //if(invert_i = 1) {NOT B} else {B}  
	
	//Instancia del sumador
	fulladder fa1bit(
		.a_i 		(a_i),
		.b_i 		(selb_w),
		.c_i 		(c_i),
		.c_o 		(c_o),
		.s_o 		(salidasum_w)
	);
	
	//Compuerta AND
	assign 	ab1_w = a_i & selb_w;
	//Compuerta OR
	assign 	ab2_w = a_i | selb_w;
	//Compuerta XOR
	assign 	ab3_w = a_i ^ selb_w;
	
	
	
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