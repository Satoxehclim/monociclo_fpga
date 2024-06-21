/*
	Grupo:			5CV3
	Proyecto:   	monociclo_FPGA
	Archivo:			monociclo.v
	Equipo:			Equipo 3
	Integrantes:	Abraham Roman Ramírez
						Andrade Jiménez Jonathan 
						Brenda Vergara Martínez
						Kaleb Yael De La Rosa Gutiérrez
						Osmar Alejandro Garcia Jiménez

	Descripcion:Este archivo es la instancia de un procesador monociclo
						
*/

module monociclo(

    input           clk_i,
    input           rst_ni,
    output   [31:0] salida_o

);
	//Seccion de declaracion de señales
    reg  [31:0] pc_r;
    wire [31:0] pcnext_w;
	 wire [31:0] if_inst_o;
	 wire [31:0] rf_dators1_o;
	 wire [31:0] rf_dators2_o;
	 wire [31:0] ex_resultado_o;
	 wire 		 c_o;
	 wire [31:0] es_dato_o;
	 wire [31:0] muxalu_dato_o;
	 wire 		 id_memwrite_o;
	 wire			 id_memread_o;
	 wire [31:0] mem_dato_o;
	 wire [31:0] wb_resultado_o;
	 wire 		 id_memtoreg_o;
	 wire [3:0]  aluc_operacion_o;
	 wire [31:0] sll_dato_o;
	 wire [31:0] branch_pc_w;
	 wire 		 pcsrc_w;
	 wire [31:0] pcBranchNext_w;
	 wire 		 ex_zeroflag_o;
	 wire			 c_i_ALUControl;
	 wire			 invert_i_ALUControl;
	 
	 
    //Seccion de asignacion de señales
	 
	 //asignacion de salida desde el PC
	 //assign salida_o = pc_r;
	 
	 //asignacion de salida desde la salida de la alu
	 //assign salida_o = ex_resultado_o;
	 
	 //asignacion de salida desde el write back
	 assign salida_o = wb_resultado_o;
	 
	 
	 //////////////
	 //**FETCH**///
	 //////////////
	 
    //Calculo de PC
    always @(posedge clk_i, negedge rst_ni)
    begin
    
        if (!rst_ni)
            pc_r <= 32'b0;
        else
            pc_r <= pcBranchNext_w;
    
    end
    
    assign pcnext_w = pc_r + 32'h4;
	 
    //instancia de la memoria de Instrucciones
	 
	icache icache_u0(
		.rdaddr_i	(pc_r[7:2]),
		.inst_o		(if_inst_o)
	);

	//////////////////////////////////
	//**DECODE/REGISTER FILE READ**///
	//////////////////////////////////
	
	//instancia del decodificador
	decodificador decode_u0(
		.opcode_i		(if_inst_o[6:0]),
		.regwrite_o		(id_regwrite_o),
		.alusrc_o		(id_alusrc_o),
		.memwrite_o  	(id_memwrite_o),
		.memread_o   	(id_memread_o),
		.memtoreg_o		(id_memtoreg_o),
		.branch_o		(id_branch_o)
	);
	
	//Instancia del banco de registros
	
	regfile registerFile_u0(
	.rs1_i		(if_inst_o[19:15]),
	.rs2_i		(if_inst_o[24:20]),
   .datord_i	(wb_resultado_o),
	.rd_i			(if_inst_o[11:7]),
   .we_i			(id_regwrite_o),
   .clk_i		(clk_i),
	.datos1_o	(rf_dators1_o),
	.datos2_o	(rf_dators2_o)
);

	///////////////////////////////////
	//**EXECUTE/ADDRESS CALCULATION**//
	///////////////////////////////////
	
	//instancia de Extension de signo
	extensiondesigno extend_u3(
		.instruccion_i (if_inst_o),
		.inmediato_o (es_dato_o)
	);
	
	ALUcontrol ALUcontrol_u(
		.opcode_i			(if_inst_o[6:0]),
		.func3_i				(if_inst_o[14:12]),
		.func7_i				(if_inst_o[30]),
		.ALUoperation_o	(aluc_operacion_o),
		.c_o					(c_i_ALUControl),
		.invert_o			(invert_i_ALUControl)
	);
	
	///multiplexor para el segundo operando de la ALU 
	assign muxalu_dato_o  = (id_alusrc_o) ? es_dato_o : rf_dators2_o;
	
	//sll de 1 bit
	sll1bit sll_u1(
		.entrada_i	(es_dato_o),
		.salida_o	(sll_dato_o)
);
	
	//instancia de ALU de 32 bits
	ALUNBits #(
		.N 	(32)
	)
	(
		.a_i					(rf_dators1_o),
		.b_i					(muxalu_dato_o),
		.c_i					(c_i_ALUControl),//if_inst_o funct 7
		.invert_i			(invert_i_ALUControl),
		.less_i				(),
		.lessunsigned_i	(),
		.operacion_i		(aluc_operacion_o),
		.salida_o			(ex_resultado_o),//salida de execute
		.c_o					(c_o),
		.set_o				(),
		.setunsigned_o		()
	
	);
	
	//detector de tipo de branch
	flagDetector(
		.branch_i		(id_branch_o),
		.func3_i			(if_inst_o[14:12]),
		.salida_i		(ex_resultado_o),
		.branchFlag_o	(ex_zeroflag_o)
	);
	
	//sumador para calcular el pc de salto
	assign branch_pc_w = sll_dato_o + pc_r;
	assign pcsrc_w = id_branch_o & ex_zeroflag_o;
	assign pcBranchNext_w = (pcsrc_w) ? branch_pc_w : pcnext_w;
	
	/////////////////////
	//**MEMORY ACCESS**//
	/////////////////////
	
	//instancia de memoria
	dcache memoria_mem(
		.clk_i			(clk_i),
		.addr_i			(ex_resultado_o[7:2]),
		.dato_i			(rf_dators2_o),
		.memwrite_i		(id_memwrite_o),
		.memread_i		(id_memread_o),
		.dato_o			(mem_dato_o)
	);
	
	//////////////////
	//**WRITE BACK**//
	//////////////////
	
	///multiplexor para seleccion de datos de la ALU o de memoria
	assign wb_resultado_o  = (id_memtoreg_o) ? mem_dato_o : ex_resultado_o;

endmodule

