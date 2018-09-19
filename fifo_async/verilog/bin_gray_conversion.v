
module oh_bin2bin #(parameter DW = 32 // width of data inputs
		     ) 
   (
    input [DW-1:0]  in, 
    output [DW-1:0] out 
    );

   wire [DW-1:0]    interm;
   
   oh_bin2gray #(.DW(DW))
   rd_b2g (.out   (interm),
	   .in	  (in));
   
   oh_gray2bin #(.DW(DW))
   rd_g2b (.out (out),
	   .in (interm));   
   
endmodule

module oh_gray2gray #(parameter DW = 32 // width of data inputs
		     ) 
   (
    input [DW-1:0]  in, 
    output [DW-1:0] out 
    );

   wire [DW-1:0]    interm;
   
   oh_gray2bin #(.DW(DW))
   rd_g2b (.out (interm),
	   .in (in));

   oh_bin2gray #(.DW(DW))
   rd_b2g (.out   (out),
	   .in	  (interm));   
   
endmodule

//#############################################################################
//# Function: Binary to gray encoder                                          #
//#############################################################################
//# Author:   Andreas Olofsson                                                #
//# License:  MIT (see LICENSE file in OH! repository)                        # 
//#############################################################################

module oh_bin2gray #(parameter DW = 32 // width of data inputs
		     ) 
   (
    input [DW-1:0]  in, //binary encoded input
    output [DW-1:0] out //gray encoded output
    );
   
   reg [DW-1:0]    gray; 
   wire [DW-1:0]   bin;

   integer 	   i;   

   assign bin[DW-1:0]  = in[DW-1:0];
   assign out[DW-1:0]  = gray[DW-1:0];
  
   always @*
     begin
	gray[DW-1] = bin[DW-1];   
	for (i=0; i<(DW-1); i=i+1)
	  gray[i] = bin[i] ^ bin[i+1];
     end
   
endmodule // oh_bin2gray


//#############################################################################
//# Function: Gray to binary encoder                                          #
//#############################################################################
//# Author:   Andreas Olofsson                                                #
//# License:  MIT (see LICENSE file in OH! repository)                        # 
//#############################################################################

module oh_gray2bin #(parameter DW = 32) // width of data inputs
   (
    input [DW-1:0]  in,  //gray encoded input
    output [DW-1:0] out  //binary encoded output
    );
   
   reg [DW-1:0]     bin;
   wire [DW-1:0]    gray;
   
   integer 	   i,j;

   assign gray[DW-1:0] = in[DW-1:0];
   assign out[DW-1:0]  = bin[DW-1:0];

   always @*
     begin
	bin[DW-1] = gray[DW-1];   
	for (i=0; i<(DW-1); i=i+1)
	  begin
	     bin[i] = 1'b0;	
	     for (j=i; j<DW; j=j+1)
	       bin[i] = bin[i] ^ gray [j];
	  end
     end

endmodule // oh_gray2bin
