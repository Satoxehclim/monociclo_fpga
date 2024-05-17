/*
	Grupo:5CV3
	Proyecto:    monociclo_FPGA
	Archivo:divFreq.v
	Equipo:Equipo 3
	Integrantes:Abraham Roman Ramírez
					Andrade Jiménez Jonathan 
					Brenda Vergara Martínez
					Kaleb Yael De La Rosa Gutiérrez
					Osmar Alejandro Garcia Jiménez
	Descripcion:Esta es el divisor de frecuenca para que el PC tenga un reloj de entrada de 1 segundo
						
*/
module divFreq (

	input				divF_clk_i,
	input				divF_rst_i,
	output	reg	divF_clk_o

);

//definicion de señales
//	wire 				rst_ni;]
	reg 				[31:0] divF_cuenta;
//monociclo

	always@(posedge divF_clk_i,negedge divF_rst_i)
	begin
		if(!divF_rst_i)
		begin
			divF_clk_o<= 1'b1; 	//Output encendido 
         divF_cuenta<=32'b0; //Reinicia el contador
		end 
		else
		begin
			if(divF_cuenta==32'd50_000_000)
			begin
				divF_cuenta<=32'b0;
            divF_clk_o<=~divF_clk_o; // Alternar el reloj de salida cuando el conteo llegue a 50 M
			end
			else
			begin
				divF_cuenta <= divF_cuenta+1'b1; //Incrementa
			end
		end

	end

endmodule 