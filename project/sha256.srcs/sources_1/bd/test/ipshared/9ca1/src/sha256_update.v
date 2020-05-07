`timescale 1ns / 1ps

`include "sha256types.vh"

module sha256_update (
    output `WORD hash0,
    output `WORD hash1,
    output `WORD hash2,
    output `WORD hash3,
    output `WORD hash4,
    output `WORD hash5,
    output `WORD hash6,
    output `WORD hash7,
    output [3:0] block_offset, /* padded message word addr (16 words) */
    output reg [54:0] cur_block,
    output done,
    
    input clk,
    input `WORD w,
    input update,
    input en,
    input reset,
    input `LONG msg_size
    );

    // one-hot encoding
    localparam  STATE_INIT0 = 10'd128,
                STATE_INIT1 = 10'd256,
                STATE_START = 10'd64,
                STATE_PREPROC_COMP = 10'd1,
                STATE_ROUND_CALC = 10'd2,
                STATE_COMP_IMD_HASH = 10'd8,
                STATE_IDLE = 10'd16,
                STATE_DONE = 10'd32,
                STATE_OF_PAD = 10'd512;

    localparam  KVAL_ADDR_DELAY = 2,
                HASH_CONTROL_DELAY = 2,
                SCH_CONTROL_DELAY = 1,
                COMP_CONTROL_DELAY = 2,
                DONE_CONTROL_DELAY = 3;

    reg [9:0] state, next_state;

    // round counter
    reg [5:0] round_counter;
    reg en_round_counter;
    reg reset_round_counter;
    wire [5:0] kval_addr_delay;
    wire first_block;

    // current block counter
    reg en_cur_block_counter;

    // hasher wires
    reg hash_wen;
    reg init_hash;
    wire `WORD  hash0_to_comp, hash1_to_comp, hash2_to_comp, hash3_to_comp, 
                hash4_to_comp, hash5_to_comp, hash6_to_comp, hash7_to_comp;


    // scheduler wires
    wire `WORD scheduled_msg;   
    reg en_sch;
    reg load_sch;

    // compressor wires
    reg init_comp;
    reg en_comp;
    wire `WORD  k;
    wire `WORD  A_comp_to_hasher, 
                B_comp_to_hasher, 
                C_comp_to_hasher, 
                D_comp_to_hasher, 
                E_comp_to_hasher, 
                F_comp_to_hasher, 
                G_comp_to_hasher, 
                H_comp_to_hasher;

    // padder wires
    reg start_pad;
    reg en_pad;
    reg reset_pad;
    wire `WORD pad_w;
    wire pad_of;

    // control signal delay wires
    wire en_sch_delayed;
    wire load_sch_delayed;
    wire en_comp_delayed;
    wire init_comp_delayed;
    wire done_delayed;

    reg done_control;

    // assign done output bit
    assign done = done_delayed;

    
    // output hash
    assign hash0 = hash0_to_comp;
    assign hash1 = hash1_to_comp;
    assign hash2 = hash2_to_comp;
    assign hash3 = hash3_to_comp;
    assign hash4 = hash4_to_comp;
    assign hash5 = hash5_to_comp;
    assign hash6 = hash6_to_comp;
    assign hash7 = hash7_to_comp;

    // output message word address 
    assign block_offset = round_counter;

    // assign first block control signal
    assign first_block = (cur_block == 0);


    reg_delay #(
        .WIDTH(6),
        .NUM_DELAYS(KVAL_ADDR_DELAY)
        )
        kval_addr_delay_inst (
        .out(kval_addr_delay),
        .clk(clk),
        .in(round_counter)
        );

    reg_delay #(
        .WIDTH(2),
        .NUM_DELAYS(HASH_CONTROL_DELAY)
        )
        hash_control_delays (
            .out({hash_wen_delayed, init_hash_delayed}),
            .in({hash_wen, init_hash}),
            .clk(clk)
        ); 

    reg_delay #(
        .WIDTH(1),
        .NUM_DELAYS(DONE_CONTROL_DELAY)
        )
        done_control_delay (
            .out(done_delayed),
            .in(done_control),
            .clk(clk)
        );


    reg_delay #(
        .WIDTH(2),
        .NUM_DELAYS(SCH_CONTROL_DELAY)
        )
        sch_control_delays (
            .out({en_sch_delayed, load_sch_delayed}),
            .in({en_sch, load_sch}),
            .clk(clk)
        );

    reg_delay #(
        .WIDTH(2),
        .NUM_DELAYS(COMP_CONTROL_DELAY)
        )
        comp_control_delays (
            .out({en_comp_delayed, init_comp_delayed}),
            .in({en_comp, init_comp}),
            .clk(clk)
        );

    rom #(
        .WORD_WIDTH(32),
        .NUM_WORDS(64),
        .FILE("kvals.mem")
        ) 
        kvals (
        .out(k),
        .addr(kval_addr_delay)
        );


    padder pad_inst (
        .w_out(pad_w),
        .pad_of(pad_of),

        .w_in(w),
        .msg_size(msg_size),
        .offset(block_offset),
        .cur_block(cur_block),
        .en(en_pad),
        .reset(reset_pad),
        .start(start_pad),
        .clk(clk)
        );

    scheduler sch_inst (
        .sch_msg(scheduled_msg),

        .clk(clk),
        .en(en_sch_delayed),
        .load(load_sch_delayed),
        .msg(pad_w)
        );

    compressor comp_inst (
        .A(A_comp_to_hasher),
        .B(B_comp_to_hasher),
        .C(C_comp_to_hasher),
        .D(D_comp_to_hasher),
        .E(E_comp_to_hasher),
        .F(F_comp_to_hasher),
        .G(G_comp_to_hasher),
        .H(H_comp_to_hasher),

        .clk(clk),
        .hash0(hash0_to_comp),
        .hash1(hash1_to_comp),
        .hash2(hash2_to_comp),
        .hash3(hash3_to_comp),
        .hash4(hash4_to_comp),
        .hash5(hash5_to_comp),
        .hash6(hash6_to_comp),
        .hash7(hash7_to_comp),
        .w(scheduled_msg),
        .k(k),
        .en(en_comp_delayed),
        .init(init_comp_delayed)
        );

    hasher hasher_inst (
        .hash0(hash0_to_comp),
        .hash1(hash1_to_comp),
        .hash2(hash2_to_comp),
        .hash3(hash3_to_comp),
        .hash4(hash4_to_comp),
        .hash5(hash5_to_comp),
        .hash6(hash6_to_comp),
        .hash7(hash7_to_comp),

        .clk(clk),
        .A(A_comp_to_hasher),
        .B(B_comp_to_hasher),
        .C(C_comp_to_hasher),
        .D(D_comp_to_hasher),
        .E(E_comp_to_hasher),
        .F(F_comp_to_hasher),
        .G(G_comp_to_hasher),
        .H(H_comp_to_hasher),
        .wen(hash_wen_delayed),
        .init(init_hash_delayed)
    );

    // current block update logic
    always @(posedge clk) begin
        if (reset)
            cur_block <= 0;
        else begin
            if (en_cur_block_counter)
                cur_block <= cur_block + 1;
        end
    end

    // round counter logic
    always @(posedge clk) begin
        if (reset_round_counter) 
            round_counter <= 0;
        else begin
            if (en_round_counter)
                round_counter <= round_counter + 1;
        end
    end

    // state register update
    always @(posedge clk) begin
        if (reset) begin
            state <= STATE_IDLE;
        end
        else begin
            if (en)
                state <= next_state;
        end
    end

    // next state function
    always @(*) begin
        next_state = state;

        case(state)
            STATE_IDLE: begin
                if (update)
                    next_state = STATE_INIT0;
            end

            STATE_INIT0:
                next_state = STATE_INIT1;

            STATE_INIT1:
                next_state = STATE_START;

            STATE_START:
                next_state = STATE_PREPROC_COMP;

            STATE_PREPROC_COMP: begin
                // state doesnt change if <15
                if (round_counter >= 15)
                    next_state = STATE_ROUND_CALC;
            end

            STATE_ROUND_CALC: begin
                if (round_counter == 63)
                    next_state = STATE_COMP_IMD_HASH;
            end

            STATE_COMP_IMD_HASH: begin
                if (pad_of)
                    next_state = STATE_OF_PAD;
                else
                    next_state = STATE_DONE;
            end

            STATE_OF_PAD:
                next_state = STATE_INIT1;

            STATE_DONE: begin
                next_state = STATE_IDLE;
            end
        endcase
    end

    // state output function
    always @(*) begin
        en_round_counter = 0;
        reset_round_counter = 0;
        hash_wen = 0;
        init_hash = 0;
        en_sch = 0;
        load_sch = 0;
        init_comp = 0;
        en_comp = 0;
        done_control = 0;
        start_pad = 0;
        en_pad = 0;
        reset_pad = 0;
        en_cur_block_counter = 0;

        case (state)
            STATE_IDLE: begin
                reset_round_counter = 1;
                reset_pad = 1;
            end

            STATE_INIT0: begin
                // load inital hash values if the first block
                if(first_block) begin
                    hash_wen = 1;
                    init_hash = 1;
                end
            end

            STATE_INIT1: begin
                // load compressor with inital block hash values
                init_comp = 1;
                en_comp = 1;
            end

            STATE_START: begin
                en_pad = 1;
                start_pad = 1;
                en_sch = 1;
                load_sch = 1;
                en_comp = 1;
                en_round_counter = 1;
            end

            STATE_PREPROC_COMP: begin
                en_pad = 1;
                en_sch = 1;
                load_sch = 1;
                en_comp = 1;
                en_round_counter = 1;
            end

            STATE_ROUND_CALC: begin
                en_pad = 1;
                en_sch = 1;
                en_comp = 1;
                en_round_counter = 1;
            end

            STATE_OF_PAD: begin
                en_cur_block_counter = 1;
            end

            STATE_COMP_IMD_HASH: begin
                hash_wen = 1;
                //en_cur_block_counter = 1;
            end

            STATE_DONE: begin
                done_control = 1;
                en_cur_block_counter = 1;
            end
        endcase
    end

endmodule
