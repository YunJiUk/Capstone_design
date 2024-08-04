module top(
    input clk_100mhz,
    input reset_poweron,
    input uart_rxd, 
    output [3:0] red,
    output [3:0] green,
    output [3:0] blue,
    output vsync,       
    output hsync,
    //output [11:0] rgb, 
    
    // tx
    //input uart_tx_en,
    //input [7:0] uart_tx_data, 
    //output tx_busy, 
    output uart_txd
    
    //테스트벤치
    //, output wire [10:0] x, y, i, j
    // output reg [19:0] count
    //, input wire locked
    );   
parameter   RED = 4'd0,
            GREEN = 4'd1,
            BLUE = 4'd2;

wire clk, rst;
wire locked;  
wire [10:0] x, y, i, j;
wire video_on, finish,color_trig; 
wire [7:0] uart_rx_data;

wire uart_tx_en;
reg [7:0] yeild_uart_tx_data;   

reg [19:0] count;

reg [23:0] yeild;
reg [15:0] fail_cnt;
reg [15:0] pass_cnt;

wire [3:0] color;

wire [3:0] state;

reg [11:0] din;

wire [11:0] dout;

wire csn, wen;

wire [15:0] addr_write, addr_read;
/////////////////////////////////////////////////////////////////
clk_wiz_0 clk_inst (clk, reset_poweron, locked, clk_100mhz); 
assign rst = reset_poweron | (~locked);

assign red = (video_on==1)? {dout[11:8]} : 0;
assign green= (video_on==1)? {dout[7:4]} : 0;
assign blue = (video_on==1)? {dout[3:0]} : 0;
/*
assign red =   (video_on==1)? {r3[x/16][y/16], r2[x/16][y/16], r1[x/16][y/16], r0[x/16][y/16]} : 0;
assign green = (video_on==1)? {g3[x/16][y/16], g2[x/16][y/16], g1[x/16][y/16], g0[x/16][y/16]} : 0;
assign blue =  (video_on==1)? {b3[x/16][y/16], b2[x/16][y/16], b1[x/16][y/16], b0[x/16][y/16]} : 0;
*/
    always @(posedge clk_100mhz or posedge rst) begin /*  @(posedge clk_100mhz or posedge rst) */
        if(rst) begin
        end            
        else if(color_trig) begin
            case(color)
              RED   : begin din[11:8] <= uart_rx_data[7:4]; end
              GREEN : begin din[7:4] <= uart_rx_data[7:4]; end
              BLUE  : begin din[3:0] <= uart_rx_data[7:4]; end
            endcase
        end
    end
     
    assign csn = 0;
    // assign wen = 0;
    assign addr_write = count;
    assign addr_read = (x/4 + (y/4)*160);
    //(finish)? 20000 :
    always @(posedge clk_100mhz or posedge rst) begin // @(posedge clk_100mhz or posedge rst) */
            if (rst) count <= 0;
            else begin
                if (count > 19199) count <=0;  // count > 1199 && color_trig  // => count를 1200보다 큰 경우로 하면?
                else if(finish) count <= count + 1; // finish
            end
     end    
    
    // ----------------- yeild ----------------- //
    // 근데 clk을 이런식으로 쓰는게 맞는지 모르겠음
    // black: background , white: wafer, crack: red, scr: green.
    always @(posedge clk_100mhz or posedge rst) begin 
             if (rst) fail_cnt <= 0;
             else if(finish && ( (din[11]&&~din[7]&&~din[3]) || (~din[11]&&din[7]&&~din[3]) )) fail_cnt <= fail_cnt + 1;  // 
             else if (state == 4'd10) fail_cnt <= 0; // stop state일 떄 
    end
   
    always @(posedge clk_100mhz or posedge rst) begin 
             if (rst) pass_cnt <= 0;
             else if(finish && (din[11] && din[7] && din[3])) pass_cnt <= pass_cnt + 1; 
             else if (state == 4'd10) pass_cnt <= 0;
    end   
    
    always @(posedge clk_100mhz or posedge rst) begin 
            if(rst) yeild <= 0; 
            else if(count == 19196) yeild <= 100 * pass_cnt / (pass_cnt + fail_cnt);  // > 1199 
            else if (state == 4'd10) yeild <= 0;
    end
    
    always @ ( posedge clk_100mhz or posedge rst ) begin 
        if(rst) yeild_uart_tx_data <= 0;
        else if(count == 19197) yeild_uart_tx_data <= yeild[7:0];   // => 이게 1199여도 한 clk 뒤에 값이 들어오니까 cont      
    end
        
    assign uart_tx_en = (count==19198)? 1:0;  //>1199 =.> 이런 타이밍으로 하면 안될 것 같아서 수정함  => 만약안되면 count ==0 일때도 추가!! 

    //assign yeild_uart_tx_data = (count==1199)? yeild[7:0] : 0;    
    /*
     always @ ( posedge clk_100mhz or posedge rst ) begin 
        if(rst); 
        else {r3[39][0],r2[39][0],r1[39][0],r0[39][0]} <= pass_cnt;
     end   */    
 
// uart_rx       
uart_rx urx (.clk(clk_100mhz), .rst(rst), .uart_rxd(uart_rxd), .rx_busy(), .uart_rx_data(uart_rx_data), .color(color), .color_trig(color_trig) ,.finish(finish), .wen(wen)); 
// uart_tx
uart_tx utx (.clk(clk_100mhz), .rst(rst), .uart_tx_en(uart_tx_en), .uart_tx_data(yeild_uart_tx_data), .tx_busy(), .uart_txd(uart_txd), .state(state)); 
// sync module
sync_mod sync_inst (rst, clk, x, y, video_on, vsync, hsync); 
// memory(BRAM)
ram_65536x12 ram_inst (.clk(clk_100mhz), .clk_25m(clk), .csn(csn), .wen(wen), .addr_write(addr_write), .addr_read(addr_read), .din(din), .dout(dout));
///////////////////////////////////////////////////////////////////////////// 

endmodule