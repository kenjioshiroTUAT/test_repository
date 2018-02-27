//
// 2016-12-14,18 MN 4KB=2block*2KB
// auto ready  read: 1 clockdelay, write:direct
//

module B16BootROM(
    input wire		Clock,
    input wire		Reset_,
    input wire		Strobe,
    input wire [31:0]	Address,
    input wire		OEn,
    input wire [1:0]	ByteEn,
    output wire [15:0]	RdData
);
    wire [9:0] MemAddr =  Address[10:1];
    wire       CEn = Strobe;
    wire [1:0]  BlockNum = {Address[11], !Address[11]};
    wire [15:0] RdData1, RdData0;
    assign RdData[15:0] = ! OEn ? 16'b0
			  : BlockNum[1] ? RdData1
			  : RdData0;
    wire [15:0] tmp0,tmp1;

// SDP
RAMB8BWER #(
  .RAM_MODE("SDP"), // SDP or TDP
  .DATA_WIDTH_A(36), .DATA_WIDTH_B(36), // ...9,18,36
//  .DOA_REG(0), 
//  .DOB_REG(0), // Optional output
//  .EN_RSTRAM_A("TRUE"), // Enable/disable A port RST
//  .EN_RSTRAM_B("TRUE"), // Enable/disable B
//  .INIT_A(18'h00000), // Initial values on A
//  .INIT_B(18'h00000), // Initial values on B
//  .INIT_FILE("NONE"), // File name of file
//  .RST_PRIORITY_A("CE"), // CE or SR
//  .RST_PRIORITY_B("CE"), // CE or SR
//  .SIM_COLLISION_CHECK("ALL"), // Collision check
//  .SRVAL_A(18'h00000), // Set/Reset value for A port output
//  .SRVAL_B(18'h00000), // Set/Reset value for B port output
//  .WRITE_MODE_A("WRITE_FIRST"),
//  .WRITE_MODE_B("WRITE_FIRST"),
  .RSTTYPE("SYNC") // SYNC or ASYNC
) SP6ROMInit0 (
  .DOADO(RdData0), // 16-bit A port data/LSB data output
  .DOBDO(tmp0), // 16-bit B port data/MSB data output
  .DOPADOP(), // 2-bit A port parity/LSB parity output
  .DOPBDOP(), // 2-bit B port parity/MSB parity output
  .ADDRAWRADDR(), // 13-bit A port address/Write address input
  .ADDRBRDADDR({Address[9:1],4'b000}), // 13-bit B port address/Read address input
  .CLKAWRCLK(), // 1-bit A port clock/Write clock input
  .CLKBRDCLK(Clock), // 1-bit B port clock/Read clock input
  .DIADI(), // 16-bit A port data/LSB data input
  .DIBDI(), // 16-bit B port data/MSB data input
  .DIPADIP(), // 2-bit A port parity/LSB parity input
  .DIPBDIP(), // 2-bit B port parity/MSB parity input
  .ENAWREN(), // 1-bit A port enable/Write enable input
  .ENBRDEN(CEn), // 1-bit B port enable/Read enable input
  .REGCEA(1'b0), // 1-bit A port register enable input
  .REGCEBREGCE(), 
  .RSTA(!Reset_), // 1-bit A port set/reset input
  .RSTBRST(), // 1-bit B port set/reset input
  .WEAWEL(), // 2-bit A port write enable input
  .WEBWEU() // 2-bit B port write enable input
);
   
RAMB8BWER #(
  .RAM_MODE("SDP"), // SDP or TDP
  .DATA_WIDTH_A(36), .DATA_WIDTH_B(36), // ...9,18,36
//  .DOA_REG(0), 
//  .DOB_REG(0), // Optional output
//  .EN_RSTRAM_A("TRUE"), // Enable/disable A port RST
//  .EN_RSTRAM_B("TRUE"), // Enable/disable B
//  .INIT_A(18'h00000), // Initial values on A
//  .INIT_B(18'h00000), // Initial values on B
//  .INIT_FILE("NONE"), // File name of file
//  .RST_PRIORITY_A("CE"), // CE or SR
//  .RST_PRIORITY_B("CE"), // CE or SR
//  .SIM_COLLISION_CHECK("ALL"), // Collision check
//  .SRVAL_A(18'h00000), // Set/Reset value for A port output
//  .SRVAL_B(18'h00000), // Set/Reset value for B port output
//  .WRITE_MODE_A("WRITE_FIRST"),
//  .WRITE_MODE_B("WRITE_FIRST"),
  .RSTTYPE("SYNC") // SYNC or ASYNC
) SP6ROMInit1 (
  .DOADO(RdData1), // 16-bit A port data/LSB data output
  .DOBDO(tmp1), // 16-bit B port data/MSB data output
  .DOPADOP(), // 2-bit A port parity/LSB parity output
  .DOPBDOP(), // 2-bit B port parity/MSB parity output
  .ADDRAWRADDR(), // 13-bit A port address/Write address input
  .ADDRBRDADDR({Address[9:1],4'b000}), // 13-bit B port address/Read address input
  .CLKAWRCLK(), // 1-bit A port clock/Write clock input
  .CLKBRDCLK(Clock), // 1-bit B port clock/Read clock input
  .DIADI(), // 16-bit A port data/LSB data input
  .DIBDI(), // 16-bit B port data/MSB data input
  .DIPADIP(), // 2-bit A port parity/LSB parity input
  .DIPBDIP(), // 2-bit B port parity/MSB parity input
  .ENAWREN(), // 1-bit A port enable/Write enable input
  .ENBRDEN(CEn), // 1-bit B port enable/Read enable input
  .REGCEA(1'b0), // 1-bit A port register enable input
  .REGCEBREGCE(), 
  .RSTA(!Reset_), // 1-bit A port set/reset input
  .RSTBRST(), // 1-bit B port set/reset input
  .WEAWEL(), // 2-bit A port write enable input
  .WEBWEU() // 2-bit B port write enable input
);
   


endmodule
   
