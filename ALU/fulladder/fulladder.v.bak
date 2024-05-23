/*
	ENCABEZADO
*/


module fulladder (

	input a_i,
	input b_i,
	input c_i,
	
	output c_o,
	output s_o

);

	//XOR Gate
	wire axorb_w;
	
	assign axorb_w = a_i ^ b_i;
	//AND Gates
	wire canda_w;
	wire candb_w;
	wire banda_w;
	assign canda_w = c_i & a_i;
	assign candb_w = c_i & b_i;
	assign banda_w = b_i & a_i;
	
	//Resultado de la suma
	assign s_o = c_i ^ axorb_w;
	//Acarreo de salida
	assign c_o = canda_w | candb_w | banda_w;
	
endmodule 