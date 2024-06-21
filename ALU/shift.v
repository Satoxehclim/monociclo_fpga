/*
	Grupo:			5CV3
	Proyecto:   	monociclo_FPGA
	Archivo:			shift.v
	Equipo:			Equipo 3
	Integrantes:	Abraham Roman Ramírez
						Andrade Jiménez Jonathan 
						Brenda Vergara Martínez
						Kaleb Yael De La Rosa Gutiérrez
						Osmar Alejandro Garcia Jiménez
	Descripcion: 	Este archivo implementa las opercaiones shift
						
*/
module shift #(parameter N = 16)(
    input [N-1:0] a_i,       		// Entrada A de N bits
    input [N-1:0] b_i,       		// Entrada B de N bits (cantidad de desplazamiento)
    input [1:0] operacion_i,     // Código de operación de 2 bits para el tipo de desplazamiento
    output reg [N-1:0] salida_o 	// Resultado del desplazamiento
);

    always @(*) begin
        case (operacion_i)
            2'b00: salida_o = a_i << b_i;  				// Desplazamiento lógico a la izquierda (SLL)
            2'b01: salida_o = a_i >> b_i;  				// Desplazamiento lógico a la derecha (SRL)
            2'b10: salida_o = $signed(a_i) >>> b_i;   // Desplazamiento aritmético a la derecha (SRA)
            default: salida_o = {N{1'b0}};
        endcase
    end

endmodule