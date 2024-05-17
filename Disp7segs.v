module Disp7segs (

	input 			[3:0] entrada_i,
	output reg 		[6:0] salida_o

);
	
	always @(*)
	begin
		case (entrada_i)
		4'b0000:
			salida_o = 7'b1000000;
		4'b0001:
			salida_o = 7'b1111001;
		4'b0010:
			salida_o = 7'b0100100;
		4'b0011:
			salida_o = 7'b0110000;
		4'b0100:
			salida_o = 7'b0011001;
		4'b0101:
			salida_o = 7'b0010010;
		4'b0110:
			salida_o = 7'b0000010;
		4'b0111:
			salida_o = 7'b1000000;
		4'b1000:
			salida_o = 7'b0000000;
		4'b1001:
			salida_o = 7'b0011000;
		4'b1010:
			salida_o = 7'b0001000;
		4'b1011:
			salida_o = 7'b0000011;
		4'b1100:
			salida_o = 7'b1000110;
		4'b1101:
			salida_o = 7'b0100001;
		4'b1110:
			salida_o = 7'b0000110;
		4'b1111:
			salida_o = 7'b0001110;
		endcase 
	end
	
endmodule 