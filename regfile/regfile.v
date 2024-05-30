/*
	Grupo:			5CV3
	Proyecto:   	monociclo_FPGA
	Archivo:			regfile.v
	Equipo:			Equipo 3
	Integrantes:	Abraham Roman Ramírez
						Andrade Jiménez Jonathan 
						Brenda Vergara Martínez
						Kaleb Yael De La Rosa Gutiérrez
						Osmar Alejandro Garcia Jiménez
	Descripcion: 	Este archivo es un banco de registros de 32 bits
						
*/
module regfile (
	input		[4:0]		rs1_i,
	input		[4:0]		rs2_i,
   input    [31:0]	datord_i,
	input		[4:0]		rd_i,
   input       		we_i,
   input       		clk_i,
	output	[31:0]	datos1_o,
	output	[31:0]	datos2_o
);

	// Definicion de memoria
	
	reg 		[31:0]registerfile[0:31];
	
	//* Lógica de lectura
	//puerto de lectura 1
    assign	datos1_o = registerfile[rs1_i];
	 //puerto de escritura 2
    assign	datos2_o = registerfile[rs2_i];

    // puerto de escritura
    always @(posedge clk_i) 
	 begin
        if (we_i) 
            registerfile[rd_i] <= datord_i;
    end

    

endmodule
