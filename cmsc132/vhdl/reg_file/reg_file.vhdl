LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY reg_file is
   PORT( 
      read_n1: IN STD_LOGIC;
      read_n2: IN STD_LOGIC;
      write_n: IN STD_LOGIC;
      write_data: IN STD_LOGIC := '0';
      write: IN STD_LOGIC;
      clk: IN STD_LOGIC;
      read_data1: OUT STD_LOGIC;
      read_data2: OUT STD_LOGIC);
END reg_file;
ARCHITECTURE behavioral OF reg_file IS
   COMPONENT dff is
      PORT( D: IN STD_LOGIC;
         C: IN STD_LOGIC;
         Q: INOUT STD_LOGIC;
         Q_BAR: INOUT STD_LOGIC);
   END COMPONENT;
   COMPONENT mux_2to1 IS
      PORT (A, B, S: IN STD_LOGIC;
      C: OUT STD_LOGIC);
   END COMPONENT;
   COMPONENT decoder_1to2 IS
      PORT (I: IN STD_LOGIC;
      Out0, Out1: OUT STD_LOGIC);
   END COMPONENT;
   COMPONENT and_gate IS
      PORT (A, B: IN STD_LOGIC;
      C: OUT STD_LOGIC);
   END COMPONENT;
   
   SIGNAL reg0_D: STD_LOGIC;
   SIGNAL reg0_Q: STD_LOGIC;
   SIGNAL reg0_Q_BAR: STD_LOGIC;
   SIGNAL reg1_D: STD_LOGIC;
   SIGNAL reg1_Q: STD_LOGIC;
   SIGNAL reg1_Q_BAR: STD_LOGIC;
   SIGNAL and_0: STD_LOGIC;
   SIGNAL and_1: STD_LOGIC;
   SIGNAL decoder_out0: STD_LOGIC;
   SIGNAL decoder_out1: STD_LOGIC;
BEGIN
   decoder: decoder_1to2 PORT MAP (write_n, decoder_Out0, decoder_Out1);
   and0: and_gate PORT MAP(write, decoder_Out0, and_0);
   and1: and_gate PORT MAP(write, decoder_Out1, and_1);
   reg0: dff PORT MAP (write_data, and_0, reg0_Q, reg0_Q_BAR);
   reg1: dff PORT MAP (write_data, and_1, reg1_Q, reg1_Q_BAR);
   mux1: mux_2to1 PORT MAP (reg0_Q, reg1_Q, read_n1, read_data1);
   mux2: mux_2to1 PORT MAP (reg0_Q, reg1_Q, read_n2, read_data2);
END behavioral;
