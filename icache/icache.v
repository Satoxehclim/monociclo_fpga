/*
	Grupo:5CV3
	Proyecto:    monociclo_FPGA
	Archivo:monociclo.v
	Equipo:Equipo 3
	Integrantes:Abraham Roman Ramírez
					Andrade Jiménez Jonathan 
					Brenda Vergara Martínez
					Kaleb Yael De La Rosa Gutiérrez
					Osmar Alejandro Garcia Jiménez
	Descripcion:Esta es la memoria de instrucciones almacena hasta 64 instrucciones
						
*/
module icache (
	//puerto de lectura
	input 	[5:0] 	rdaddr_i,
	output 	[31:0]	inst_o
);

	//definir la memoria
	reg [31:0]memoria[0:63];
	
	// Inicialización
	integer i;
	initial begin
		// Carga los datos desde el archivo bubble.hex
		$readmemh("burbuja.hex", memoria);
	end

	assign	inst_o = memoria[rdaddr_i];
	
endmodule 