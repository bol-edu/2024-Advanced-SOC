
--------> /home/raid7_4/raid1_1/linux/mentor/Catapult/2023.2/Mgc_home/pkgs/siflibs/ccs_in_wait_v1.vhd 
--------------------------------------------------------------------------------
-- Catapult Synthesis - Sample I/O Port Library
--
-- Copyright (c) 2003-2017 Mentor Graphics Corp.
--       All Rights Reserved
--
-- This document may be used and distributed without restriction provided that
-- this copyright statement is not removed from the file and that any derivative
-- work contains this copyright notice.
--
-- The design information contained in this file is intended to be an example
-- of the functionality which the end user may study in preparation for creating
-- their own custom interfaces. This design does not necessarily present a 
-- complete implementation of the named protocol or standard.
--
--------------------------------------------------------------------------------

LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

PACKAGE ccs_in_wait_pkg_v1 IS

COMPONENT ccs_in_wait_v1
  GENERIC (
    rscid    : INTEGER;
    width    : INTEGER
  );
  PORT (
    idat   : OUT std_logic_vector(width-1 DOWNTO 0);
    rdy    : OUT std_logic;
    ivld   : OUT std_logic;
    dat    : IN  std_logic_vector(width-1 DOWNTO 0);
    irdy   : IN  std_logic;
    vld    : IN  std_logic
   );
END COMPONENT;

END ccs_in_wait_pkg_v1;

LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all; -- Prevent STARC 2.1.1.2 violation

ENTITY ccs_in_wait_v1 IS
  GENERIC (
    rscid : INTEGER;
    width : INTEGER
  );
  PORT (
    idat  : OUT std_logic_vector(width-1 DOWNTO 0);
    rdy   : OUT std_logic;
    ivld  : OUT std_logic;
    dat   : IN  std_logic_vector(width-1 DOWNTO 0);
    irdy  : IN  std_logic;
    vld   : IN  std_logic
  );
END ccs_in_wait_v1;

ARCHITECTURE beh OF ccs_in_wait_v1 IS
  constant stall_const : std_logic := '0';
  SIGNAL stall_ctrl : std_logic;
BEGIN
  stall_ctrl <= stall_const;

  idat <= dat;
  rdy  <= irdy and not stall_ctrl;
  ivld <= vld and not stall_ctrl;

END beh;


--------> /home/raid7_4/raid1_1/linux/mentor/Catapult/2023.2/Mgc_home/pkgs/siflibs/ccs_out_wait_v1.vhd 
--------------------------------------------------------------------------------
-- Catapult Synthesis - Sample I/O Port Library
--
-- Copyright (c) 2003-2017 Mentor Graphics Corp.
--       All Rights Reserved
--
-- This document may be used and distributed without restriction provided that
-- this copyright statement is not removed from the file and that any derivative
-- work contains this copyright notice.
--
-- The design information contained in this file is intended to be an example
-- of the functionality which the end user may study in preparation for creating
-- their own custom interfaces. This design does not necessarily present a 
-- complete implementation of the named protocol or standard.
--
--------------------------------------------------------------------------------

LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

PACKAGE ccs_out_wait_pkg_v1 IS

COMPONENT ccs_out_wait_v1
  GENERIC (
    rscid    : INTEGER;
    width    : INTEGER
  );
  PORT (
    dat    : OUT std_logic_vector(width-1 DOWNTO 0);
    irdy   : OUT std_logic;
    vld    : OUT std_logic;
    idat   : IN  std_logic_vector(width-1 DOWNTO 0);
    rdy    : IN  std_logic;
    ivld   : IN  std_logic
  );
END COMPONENT;

END ccs_out_wait_pkg_v1;

LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all; -- Prevent STARC 2.1.1.2 violation

ENTITY ccs_out_wait_v1 IS
  GENERIC (
    rscid : INTEGER;
    width : INTEGER
  );
  PORT (
    dat   : OUT std_logic_vector(width-1 DOWNTO 0);
    irdy  : OUT std_logic;
    vld   : OUT std_logic;
    idat  : IN  std_logic_vector(width-1 DOWNTO 0);
    rdy   : IN  std_logic;
    ivld  : IN  std_logic
  );
END ccs_out_wait_v1;

ARCHITECTURE beh OF ccs_out_wait_v1 IS
  constant stall_const : std_logic := '0';
  SIGNAL stall_ctrl : std_logic;
BEGIN
  stall_ctrl <= stall_const;

  dat  <= idat;
  irdy <= rdy and not stall_ctrl;
  vld  <= ivld and not stall_ctrl;

END beh;


--------> /home/raid7_4/raid1_1/linux/mentor/Catapult/2023.2/Mgc_home/pkgs/hls_pkgs/src/funcs.vhd 

-- a package of attributes that give verification tools a hint about
-- the function being implemented
PACKAGE attributes IS
  ATTRIBUTE CALYPTO_FUNC : string;
  ATTRIBUTE CALYPTO_DATA_ORDER : string;
end attributes;

-----------------------------------------------------------------------
-- Package that declares synthesizable functions needed for RTL output
-----------------------------------------------------------------------

LIBRARY ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

PACKAGE funcs IS

-----------------------------------------------------------------
-- utility functions
-----------------------------------------------------------------

   FUNCTION TO_STDLOGIC(arg1: BOOLEAN) RETURN STD_LOGIC;
--   FUNCTION TO_STDLOGIC(arg1: STD_ULOGIC_VECTOR(0 DOWNTO 0)) RETURN STD_LOGIC;
   FUNCTION TO_STDLOGIC(arg1: STD_LOGIC_VECTOR(0 DOWNTO 0)) RETURN STD_LOGIC;
   FUNCTION TO_STDLOGIC(arg1: UNSIGNED) RETURN STD_LOGIC;
   FUNCTION TO_STDLOGIC(arg1: SIGNED(0 DOWNTO 0)) RETURN STD_LOGIC;
   FUNCTION TO_STDLOGICVECTOR(arg1: STD_LOGIC) RETURN STD_LOGIC_VECTOR;

   FUNCTION maximum(arg1, arg2 : INTEGER) RETURN INTEGER;
   FUNCTION minimum(arg1, arg2 : INTEGER) RETURN INTEGER;
   FUNCTION ifeqsel(arg1, arg2, seleq, selne : INTEGER) RETURN INTEGER;
   FUNCTION resolve_std_logic_vector(input1: STD_LOGIC_VECTOR; input2 : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR;
   
-----------------------------------------------------------------
-- logic functions
-----------------------------------------------------------------

   FUNCTION and_s(inputs: STD_LOGIC_VECTOR) RETURN STD_LOGIC;
   FUNCTION or_s (inputs: STD_LOGIC_VECTOR) RETURN STD_LOGIC;
   FUNCTION xor_s(inputs: STD_LOGIC_VECTOR) RETURN STD_LOGIC;

   FUNCTION and_v(inputs: STD_LOGIC_VECTOR; olen: POSITIVE) RETURN STD_LOGIC_VECTOR;
   FUNCTION or_v (inputs: STD_LOGIC_VECTOR; olen: POSITIVE) RETURN STD_LOGIC_VECTOR;
   FUNCTION xor_v(inputs: STD_LOGIC_VECTOR; olen: POSITIVE) RETURN STD_LOGIC_VECTOR;

-----------------------------------------------------------------
-- mux functions
-----------------------------------------------------------------

   FUNCTION mux_s(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC       ) RETURN STD_LOGIC;
   FUNCTION mux_s(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC_VECTOR) RETURN STD_LOGIC;
   FUNCTION mux_v(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC       ) RETURN STD_LOGIC_VECTOR;
   FUNCTION mux_v(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR;

-----------------------------------------------------------------
-- latch functions
-----------------------------------------------------------------
   FUNCTION lat_s(dinput: STD_LOGIC       ; clk: STD_LOGIC; doutput: STD_LOGIC       ) RETURN STD_LOGIC;
   FUNCTION lat_v(dinput: STD_LOGIC_VECTOR; clk: STD_LOGIC; doutput: STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR;

-----------------------------------------------------------------
-- tristate functions
-----------------------------------------------------------------
--   FUNCTION tri_s(dinput: STD_LOGIC       ; control: STD_LOGIC) RETURN STD_LOGIC;
--   FUNCTION tri_v(dinput: STD_LOGIC_VECTOR; control: STD_LOGIC) RETURN STD_LOGIC_VECTOR;

-----------------------------------------------------------------
-- compare functions returning STD_LOGIC
-- in contrast to the functions returning boolean
-----------------------------------------------------------------

   FUNCTION "=" (l, r: UNSIGNED) RETURN STD_LOGIC;
   FUNCTION "=" (l, r: SIGNED  ) RETURN STD_LOGIC;
   FUNCTION "/="(l, r: UNSIGNED) RETURN STD_LOGIC;
   FUNCTION "/="(l, r: SIGNED  ) RETURN STD_LOGIC;
   FUNCTION "<="(l, r: UNSIGNED) RETURN STD_LOGIC;
   FUNCTION "<="(l, r: SIGNED  ) RETURN STD_LOGIC;
   FUNCTION "<" (l, r: UNSIGNED) RETURN STD_LOGIC;
   FUNCTION "<" (l, r: SIGNED  ) RETURN STD_LOGIC;
   FUNCTION ">="(l, r: UNSIGNED) RETURN STD_LOGIC;
   FUNCTION ">="(l, r: SIGNED  ) RETURN STD_LOGIC;
   FUNCTION ">" (l, r: UNSIGNED) RETURN STD_LOGIC;
   FUNCTION ">" (l, r: SIGNED  ) RETURN STD_LOGIC;

   -- RETURN 2 bits (left => lt, right => eq)
   FUNCTION cmp (l, r: STD_LOGIC_VECTOR) RETURN STD_LOGIC;

-----------------------------------------------------------------
-- Vectorized Overloaded Arithmetic Operators
-----------------------------------------------------------------

   FUNCTION faccu(arg: UNSIGNED; width: NATURAL) RETURN UNSIGNED;
 
   FUNCTION fabs(arg1: SIGNED  ) RETURN UNSIGNED;

   FUNCTION "/"  (l, r: UNSIGNED) RETURN UNSIGNED;
   FUNCTION "MOD"(l, r: UNSIGNED) RETURN UNSIGNED;
   FUNCTION "REM"(l, r: UNSIGNED) RETURN UNSIGNED;
   FUNCTION "**" (l, r: UNSIGNED) RETURN UNSIGNED;

   FUNCTION "/"  (l, r: SIGNED  ) RETURN SIGNED  ;
   FUNCTION "MOD"(l, r: SIGNED  ) RETURN SIGNED  ;
   FUNCTION "REM"(l, r: SIGNED  ) RETURN SIGNED  ;
   FUNCTION "**" (l, r: SIGNED  ) RETURN SIGNED  ;

-----------------------------------------------------------------
--               S H I F T   F U C T I O N S
-- negative shift shifts the opposite direction
-- *_stdar functions use shift functions from std_logic_arith
-----------------------------------------------------------------

   FUNCTION fshl(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshr(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshl(arg1: UNSIGNED; arg2: SIGNED  ; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshr(arg1: UNSIGNED; arg2: SIGNED  ; olen: POSITIVE) RETURN UNSIGNED;

   FUNCTION fshl(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE) RETURN SIGNED  ;
   FUNCTION fshr(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE) RETURN SIGNED  ;
   FUNCTION fshl(arg1: SIGNED  ; arg2: SIGNED  ; olen: POSITIVE) RETURN SIGNED  ;
   FUNCTION fshr(arg1: SIGNED  ; arg2: SIGNED  ; olen: POSITIVE) RETURN SIGNED  ;

   FUNCTION fshl(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshr(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshl(arg1: UNSIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshr(arg1: UNSIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED;

   FUNCTION frot(arg1: STD_LOGIC_VECTOR; arg2: STD_LOGIC_VECTOR; signd2: BOOLEAN; sdir: INTEGER range -1 TO 1) RETURN STD_LOGIC_VECTOR;
   FUNCTION frol(arg1: STD_LOGIC_VECTOR; arg2: UNSIGNED) RETURN STD_LOGIC_VECTOR;
   FUNCTION fror(arg1: STD_LOGIC_VECTOR; arg2: UNSIGNED) RETURN STD_LOGIC_VECTOR;
   FUNCTION frol(arg1: STD_LOGIC_VECTOR; arg2: SIGNED  ) RETURN STD_LOGIC_VECTOR;
   FUNCTION fror(arg1: STD_LOGIC_VECTOR; arg2: SIGNED  ) RETURN STD_LOGIC_VECTOR;

   -----------------------------------------------------------------
   -- *_stdar functions use shift functions from std_logic_arith
   -----------------------------------------------------------------
   FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: SIGNED  ; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: SIGNED  ; olen: POSITIVE) RETURN UNSIGNED;

   FUNCTION fshl_stdar(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE) RETURN SIGNED  ;
   FUNCTION fshr_stdar(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE) RETURN SIGNED  ;
   FUNCTION fshl_stdar(arg1: SIGNED  ; arg2: SIGNED  ; olen: POSITIVE) RETURN SIGNED  ;
   FUNCTION fshr_stdar(arg1: SIGNED  ; arg2: SIGNED  ; olen: POSITIVE) RETURN SIGNED  ;

   FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED;
   FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED;

-----------------------------------------------------------------
-- indexing functions: LSB always has index 0
-----------------------------------------------------------------

   FUNCTION readindex(vec: STD_LOGIC_VECTOR; index: INTEGER                 ) RETURN STD_LOGIC;
   FUNCTION readslice(vec: STD_LOGIC_VECTOR; index: INTEGER; width: POSITIVE) RETURN STD_LOGIC_VECTOR;

   FUNCTION writeindex(vec: STD_LOGIC_VECTOR; dinput: STD_LOGIC       ; index: INTEGER) RETURN STD_LOGIC_VECTOR;
   FUNCTION n_bits(p: NATURAL) RETURN POSITIVE;
   --FUNCTION writeslice(vec: STD_LOGIC_VECTOR; dinput: STD_LOGIC_VECTOR; index: INTEGER) RETURN STD_LOGIC_VECTOR;
   FUNCTION writeslice(vec: STD_LOGIC_VECTOR; dinput: STD_LOGIC_VECTOR; enable: STD_LOGIC_VECTOR; byte_width: INTEGER;  index: INTEGER) RETURN STD_LOGIC_VECTOR ;

   FUNCTION ceil_log2(size : NATURAL) return NATURAL;
   FUNCTION bits(size : NATURAL) return NATURAL;    

   PROCEDURE csa(a, b, c: IN INTEGER; s, cout: OUT STD_LOGIC_VECTOR);
   PROCEDURE csha(a, b: IN INTEGER; s, cout: OUT STD_LOGIC_VECTOR);
   
END funcs;


--------------------------- B O D Y ----------------------------


PACKAGE BODY funcs IS

-----------------------------------------------------------------
-- utility functions
-----------------------------------------------------------------

   FUNCTION TO_STDLOGIC(arg1: BOOLEAN) RETURN STD_LOGIC IS
     BEGIN IF arg1 THEN RETURN '1'; ELSE RETURN '0'; END IF; END;
--   FUNCTION TO_STDLOGIC(arg1: STD_ULOGIC_VECTOR(0 DOWNTO 0)) RETURN STD_LOGIC IS
--     BEGIN RETURN arg1(0); END;
   FUNCTION TO_STDLOGIC(arg1: STD_LOGIC_VECTOR(0 DOWNTO 0)) RETURN STD_LOGIC IS
     BEGIN RETURN arg1(0); END;
   FUNCTION TO_STDLOGIC(arg1: UNSIGNED) RETURN STD_LOGIC IS
     BEGIN RETURN arg1(0); END;
   FUNCTION TO_STDLOGIC(arg1: SIGNED(0 DOWNTO 0)) RETURN STD_LOGIC IS
     BEGIN RETURN arg1(0); END;

   FUNCTION TO_STDLOGICVECTOR(arg1: STD_LOGIC) RETURN STD_LOGIC_VECTOR IS
     VARIABLE result: STD_LOGIC_VECTOR(0 DOWNTO 0);
   BEGIN
     result := (0 => arg1);
     RETURN result;
   END;

   FUNCTION maximum (arg1,arg2: INTEGER) RETURN INTEGER IS
   BEGIN
     IF(arg1 > arg2) THEN
       RETURN(arg1) ;
     ELSE
       RETURN(arg2) ;
     END IF;
   END;

   FUNCTION minimum (arg1,arg2: INTEGER) RETURN INTEGER IS
   BEGIN
     IF(arg1 < arg2) THEN
       RETURN(arg1) ;
     ELSE
       RETURN(arg2) ;
     END IF;
   END;

   FUNCTION ifeqsel(arg1, arg2, seleq, selne : INTEGER) RETURN INTEGER IS
   BEGIN
     IF(arg1 = arg2) THEN
       RETURN(seleq) ;
     ELSE
       RETURN(selne) ;
     END IF;
   END;

   FUNCTION resolve_std_logic_vector(input1: STD_LOGIC_VECTOR; input2: STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
     CONSTANT len: INTEGER := input1'LENGTH;
     ALIAS input1a: STD_LOGIC_VECTOR(len-1 DOWNTO 0) IS input1;
     ALIAS input2a: STD_LOGIC_VECTOR(len-1 DOWNTO 0) IS input2;
     VARIABLE result: STD_LOGIC_VECTOR(len-1 DOWNTO 0);
   BEGIN
     result := (others => '0');
     --synopsys translate_off
     FOR i IN len-1 DOWNTO 0 LOOP
       result(i) := resolved(input1a(i) & input2a(i));
     END LOOP;
     --synopsys translate_on
     RETURN result;
   END;

   FUNCTION resolve_unsigned(input1: UNSIGNED; input2: UNSIGNED) RETURN UNSIGNED IS
   BEGIN RETURN UNSIGNED(resolve_std_logic_vector(STD_LOGIC_VECTOR(input1), STD_LOGIC_VECTOR(input2))); END;

   FUNCTION resolve_signed(input1: SIGNED; input2: SIGNED) RETURN SIGNED IS
   BEGIN RETURN SIGNED(resolve_std_logic_vector(STD_LOGIC_VECTOR(input1), STD_LOGIC_VECTOR(input2))); END;

-----------------------------------------------------------------
-- Logic Functions
-----------------------------------------------------------------

   FUNCTION "not"(arg1: UNSIGNED) RETURN UNSIGNED IS
     BEGIN RETURN UNSIGNED(not STD_LOGIC_VECTOR(arg1)); END;
   FUNCTION and_s(inputs: STD_LOGIC_VECTOR) RETURN STD_LOGIC IS
     BEGIN RETURN TO_STDLOGIC(and_v(inputs, 1)); END;
   FUNCTION or_s (inputs: STD_LOGIC_VECTOR) RETURN STD_LOGIC IS
     BEGIN RETURN TO_STDLOGIC(or_v(inputs, 1)); END;
   FUNCTION xor_s(inputs: STD_LOGIC_VECTOR) RETURN STD_LOGIC IS
     BEGIN RETURN TO_STDLOGIC(xor_v(inputs, 1)); END;

   FUNCTION and_v(inputs: STD_LOGIC_VECTOR; olen: POSITIVE) RETURN STD_LOGIC_VECTOR IS
     CONSTANT ilen: POSITIVE := inputs'LENGTH;
     CONSTANT ilenM1: POSITIVE := ilen-1; --2.1.6.3
     CONSTANT olenM1: INTEGER := olen-1; --2.1.6.3
     CONSTANT ilenMolenM1: INTEGER := ilen-olen-1; --2.1.6.3
     VARIABLE inputsx: STD_LOGIC_VECTOR(ilen-1 DOWNTO 0);
     CONSTANT icnt2: POSITIVE:= inputs'LENGTH/olen;
     VARIABLE result: STD_LOGIC_VECTOR(olen-1 DOWNTO 0);
   BEGIN
     --synopsys translate_off
     ASSERT ilen REM olen = 0 SEVERITY FAILURE;
     --synopsys translate_on
     inputsx := inputs;
     result := inputsx(olenM1 DOWNTO 0);
     FOR i IN icnt2-1 DOWNTO 1 LOOP
       inputsx(ilenMolenM1 DOWNTO 0) := inputsx(ilenM1 DOWNTO olen);
       result := result AND inputsx(olenM1 DOWNTO 0);
     END LOOP;
     RETURN result;
   END;

   FUNCTION or_v(inputs: STD_LOGIC_VECTOR; olen: POSITIVE) RETURN STD_LOGIC_VECTOR IS
     CONSTANT ilen: POSITIVE := inputs'LENGTH;
     CONSTANT ilenM1: POSITIVE := ilen-1; --2.1.6.3
     CONSTANT olenM1: INTEGER := olen-1; --2.1.6.3
     CONSTANT ilenMolenM1: INTEGER := ilen-olen-1; --2.1.6.3
     VARIABLE inputsx: STD_LOGIC_VECTOR(ilen-1 DOWNTO 0);
     CONSTANT icnt2: POSITIVE:= inputs'LENGTH/olen;
     VARIABLE result: STD_LOGIC_VECTOR(olen-1 DOWNTO 0);
   BEGIN
     --synopsys translate_off
     ASSERT ilen REM olen = 0 SEVERITY FAILURE;
     --synopsys translate_on
     inputsx := inputs;
     result := inputsx(olenM1 DOWNTO 0);
     -- this if is added as a quick fix for a bug in catapult evaluating the loop even if inputs'LENGTH==1
     -- see dts0100971279
     IF icnt2 > 1 THEN
       FOR i IN icnt2-1 DOWNTO 1 LOOP
         inputsx(ilenMolenM1 DOWNTO 0) := inputsx(ilenM1 DOWNTO olen);
         result := result OR inputsx(olenM1 DOWNTO 0);
       END LOOP;
     END IF;
     RETURN result;
   END;

   FUNCTION xor_v(inputs: STD_LOGIC_VECTOR; olen: POSITIVE) RETURN STD_LOGIC_VECTOR IS
     CONSTANT ilen: POSITIVE := inputs'LENGTH;
     CONSTANT ilenM1: POSITIVE := ilen-1; --2.1.6.3
     CONSTANT olenM1: INTEGER := olen-1; --2.1.6.3
     CONSTANT ilenMolenM1: INTEGER := ilen-olen-1; --2.1.6.3
     VARIABLE inputsx: STD_LOGIC_VECTOR(ilen-1 DOWNTO 0);
     CONSTANT icnt2: POSITIVE:= inputs'LENGTH/olen;
     VARIABLE result: STD_LOGIC_VECTOR(olen-1 DOWNTO 0);
   BEGIN
     --synopsys translate_off
     ASSERT ilen REM olen = 0 SEVERITY FAILURE;
     --synopsys translate_on
     inputsx := inputs;
     result := inputsx(olenM1 DOWNTO 0);
     FOR i IN icnt2-1 DOWNTO 1 LOOP
       inputsx(ilenMolenM1 DOWNTO 0) := inputsx(ilenM1 DOWNTO olen);
       result := result XOR inputsx(olenM1 DOWNTO 0);
     END LOOP;
     RETURN result;
   END;

-----------------------------------------------------------------
-- Muxes
-----------------------------------------------------------------
   
   FUNCTION mux_sel2_v(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC_VECTOR(1 DOWNTO 0))
   RETURN STD_LOGIC_VECTOR IS
     CONSTANT size   : POSITIVE := inputs'LENGTH / 4;
     ALIAS    inputs0: STD_LOGIC_VECTOR( inputs'LENGTH-1 DOWNTO 0) IS inputs;
     VARIABLE result : STD_LOGIC_Vector( size-1 DOWNTO 0);
   BEGIN
     -- for synthesis only
     -- simulation inconsistent with control values 'UXZHLWD'
     CASE sel IS
     WHEN "00" =>
       result := inputs0(1*size-1 DOWNTO 0*size);
     WHEN "01" =>
       result := inputs0(2*size-1 DOWNTO 1*size);
     WHEN "10" =>
       result := inputs0(3*size-1 DOWNTO 2*size);
     WHEN "11" =>
       result := inputs0(4*size-1 DOWNTO 3*size);
     WHEN others =>
       result := (others => 'X');
     END CASE;
     RETURN result;
   END;
   
   FUNCTION mux_sel3_v(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC_VECTOR(2 DOWNTO 0))
   RETURN STD_LOGIC_VECTOR IS
     CONSTANT size   : POSITIVE := inputs'LENGTH / 8;
     ALIAS    inputs0: STD_LOGIC_VECTOR(inputs'LENGTH-1 DOWNTO 0) IS inputs;
     VARIABLE result : STD_LOGIC_Vector(size-1 DOWNTO 0);
   BEGIN
     -- for synthesis only
     -- simulation inconsistent with control values 'UXZHLWD'
     CASE sel IS
     WHEN "000" =>
       result := inputs0(1*size-1 DOWNTO 0*size);
     WHEN "001" =>
       result := inputs0(2*size-1 DOWNTO 1*size);
     WHEN "010" =>
       result := inputs0(3*size-1 DOWNTO 2*size);
     WHEN "011" =>
       result := inputs0(4*size-1 DOWNTO 3*size);
     WHEN "100" =>
       result := inputs0(5*size-1 DOWNTO 4*size);
     WHEN "101" =>
       result := inputs0(6*size-1 DOWNTO 5*size);
     WHEN "110" =>
       result := inputs0(7*size-1 DOWNTO 6*size);
     WHEN "111" =>
       result := inputs0(8*size-1 DOWNTO 7*size);
     WHEN others =>
       result := (others => 'X');
     END CASE;
     RETURN result;
   END;
   
   FUNCTION mux_sel4_v(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC_VECTOR(3 DOWNTO 0))
   RETURN STD_LOGIC_VECTOR IS
     CONSTANT size   : POSITIVE := inputs'LENGTH / 16;
     ALIAS    inputs0: STD_LOGIC_VECTOR(inputs'LENGTH-1 DOWNTO 0) IS inputs;
     VARIABLE result : STD_LOGIC_Vector(size-1 DOWNTO 0);
   BEGIN
     -- for synthesis only
     -- simulation inconsistent with control values 'UXZHLWD'
     CASE sel IS
     WHEN "0000" =>
       result := inputs0( 1*size-1 DOWNTO 0*size);
     WHEN "0001" =>
       result := inputs0( 2*size-1 DOWNTO 1*size);
     WHEN "0010" =>
       result := inputs0( 3*size-1 DOWNTO 2*size);
     WHEN "0011" =>
       result := inputs0( 4*size-1 DOWNTO 3*size);
     WHEN "0100" =>
       result := inputs0( 5*size-1 DOWNTO 4*size);
     WHEN "0101" =>
       result := inputs0( 6*size-1 DOWNTO 5*size);
     WHEN "0110" =>
       result := inputs0( 7*size-1 DOWNTO 6*size);
     WHEN "0111" =>
       result := inputs0( 8*size-1 DOWNTO 7*size);
     WHEN "1000" =>
       result := inputs0( 9*size-1 DOWNTO 8*size);
     WHEN "1001" =>
       result := inputs0( 10*size-1 DOWNTO 9*size);
     WHEN "1010" =>
       result := inputs0( 11*size-1 DOWNTO 10*size);
     WHEN "1011" =>
       result := inputs0( 12*size-1 DOWNTO 11*size);
     WHEN "1100" =>
       result := inputs0( 13*size-1 DOWNTO 12*size);
     WHEN "1101" =>
       result := inputs0( 14*size-1 DOWNTO 13*size);
     WHEN "1110" =>
       result := inputs0( 15*size-1 DOWNTO 14*size);
     WHEN "1111" =>
       result := inputs0( 16*size-1 DOWNTO 15*size);
     WHEN others =>
       result := (others => 'X');
     END CASE;
     RETURN result;
   END;
   
   FUNCTION mux_sel5_v(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC_VECTOR(4 DOWNTO 0))
   RETURN STD_LOGIC_VECTOR IS
     CONSTANT size   : POSITIVE := inputs'LENGTH / 32;
     ALIAS    inputs0: STD_LOGIC_VECTOR(inputs'LENGTH-1 DOWNTO 0) IS inputs;
     VARIABLE result : STD_LOGIC_Vector(size-1 DOWNTO 0 );
   BEGIN
     -- for synthesis only
     -- simulation inconsistent with control values 'UXZHLWD'
     CASE sel IS
     WHEN "00000" =>
       result := inputs0( 1*size-1 DOWNTO 0*size);
     WHEN "00001" =>
       result := inputs0( 2*size-1 DOWNTO 1*size);
     WHEN "00010" =>
       result := inputs0( 3*size-1 DOWNTO 2*size);
     WHEN "00011" =>
       result := inputs0( 4*size-1 DOWNTO 3*size);
     WHEN "00100" =>
       result := inputs0( 5*size-1 DOWNTO 4*size);
     WHEN "00101" =>
       result := inputs0( 6*size-1 DOWNTO 5*size);
     WHEN "00110" =>
       result := inputs0( 7*size-1 DOWNTO 6*size);
     WHEN "00111" =>
       result := inputs0( 8*size-1 DOWNTO 7*size);
     WHEN "01000" =>
       result := inputs0( 9*size-1 DOWNTO 8*size);
     WHEN "01001" =>
       result := inputs0( 10*size-1 DOWNTO 9*size);
     WHEN "01010" =>
       result := inputs0( 11*size-1 DOWNTO 10*size);
     WHEN "01011" =>
       result := inputs0( 12*size-1 DOWNTO 11*size);
     WHEN "01100" =>
       result := inputs0( 13*size-1 DOWNTO 12*size);
     WHEN "01101" =>
       result := inputs0( 14*size-1 DOWNTO 13*size);
     WHEN "01110" =>
       result := inputs0( 15*size-1 DOWNTO 14*size);
     WHEN "01111" =>
       result := inputs0( 16*size-1 DOWNTO 15*size);
     WHEN "10000" =>
       result := inputs0( 17*size-1 DOWNTO 16*size);
     WHEN "10001" =>
       result := inputs0( 18*size-1 DOWNTO 17*size);
     WHEN "10010" =>
       result := inputs0( 19*size-1 DOWNTO 18*size);
     WHEN "10011" =>
       result := inputs0( 20*size-1 DOWNTO 19*size);
     WHEN "10100" =>
       result := inputs0( 21*size-1 DOWNTO 20*size);
     WHEN "10101" =>
       result := inputs0( 22*size-1 DOWNTO 21*size);
     WHEN "10110" =>
       result := inputs0( 23*size-1 DOWNTO 22*size);
     WHEN "10111" =>
       result := inputs0( 24*size-1 DOWNTO 23*size);
     WHEN "11000" =>
       result := inputs0( 25*size-1 DOWNTO 24*size);
     WHEN "11001" =>
       result := inputs0( 26*size-1 DOWNTO 25*size);
     WHEN "11010" =>
       result := inputs0( 27*size-1 DOWNTO 26*size);
     WHEN "11011" =>
       result := inputs0( 28*size-1 DOWNTO 27*size);
     WHEN "11100" =>
       result := inputs0( 29*size-1 DOWNTO 28*size);
     WHEN "11101" =>
       result := inputs0( 30*size-1 DOWNTO 29*size);
     WHEN "11110" =>
       result := inputs0( 31*size-1 DOWNTO 30*size);
     WHEN "11111" =>
       result := inputs0( 32*size-1 DOWNTO 31*size);
     WHEN others =>
       result := (others => 'X');
     END CASE;
     RETURN result;
   END;
   
   FUNCTION mux_sel6_v(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC_VECTOR(5 DOWNTO 0))
   RETURN STD_LOGIC_VECTOR IS
     CONSTANT size   : POSITIVE := inputs'LENGTH / 64;
     ALIAS    inputs0: STD_LOGIC_VECTOR(inputs'LENGTH-1 DOWNTO 0) IS inputs;
     VARIABLE result : STD_LOGIC_Vector(size-1 DOWNTO 0);
   BEGIN
     -- for synthesis only
     -- simulation inconsistent with control values 'UXZHLWD'
     CASE sel IS
     WHEN "000000" =>
       result := inputs0( 1*size-1 DOWNTO 0*size);
     WHEN "000001" =>
       result := inputs0( 2*size-1 DOWNTO 1*size);
     WHEN "000010" =>
       result := inputs0( 3*size-1 DOWNTO 2*size);
     WHEN "000011" =>
       result := inputs0( 4*size-1 DOWNTO 3*size);
     WHEN "000100" =>
       result := inputs0( 5*size-1 DOWNTO 4*size);
     WHEN "000101" =>
       result := inputs0( 6*size-1 DOWNTO 5*size);
     WHEN "000110" =>
       result := inputs0( 7*size-1 DOWNTO 6*size);
     WHEN "000111" =>
       result := inputs0( 8*size-1 DOWNTO 7*size);
     WHEN "001000" =>
       result := inputs0( 9*size-1 DOWNTO 8*size);
     WHEN "001001" =>
       result := inputs0( 10*size-1 DOWNTO 9*size);
     WHEN "001010" =>
       result := inputs0( 11*size-1 DOWNTO 10*size);
     WHEN "001011" =>
       result := inputs0( 12*size-1 DOWNTO 11*size);
     WHEN "001100" =>
       result := inputs0( 13*size-1 DOWNTO 12*size);
     WHEN "001101" =>
       result := inputs0( 14*size-1 DOWNTO 13*size);
     WHEN "001110" =>
       result := inputs0( 15*size-1 DOWNTO 14*size);
     WHEN "001111" =>
       result := inputs0( 16*size-1 DOWNTO 15*size);
     WHEN "010000" =>
       result := inputs0( 17*size-1 DOWNTO 16*size);
     WHEN "010001" =>
       result := inputs0( 18*size-1 DOWNTO 17*size);
     WHEN "010010" =>
       result := inputs0( 19*size-1 DOWNTO 18*size);
     WHEN "010011" =>
       result := inputs0( 20*size-1 DOWNTO 19*size);
     WHEN "010100" =>
       result := inputs0( 21*size-1 DOWNTO 20*size);
     WHEN "010101" =>
       result := inputs0( 22*size-1 DOWNTO 21*size);
     WHEN "010110" =>
       result := inputs0( 23*size-1 DOWNTO 22*size);
     WHEN "010111" =>
       result := inputs0( 24*size-1 DOWNTO 23*size);
     WHEN "011000" =>
       result := inputs0( 25*size-1 DOWNTO 24*size);
     WHEN "011001" =>
       result := inputs0( 26*size-1 DOWNTO 25*size);
     WHEN "011010" =>
       result := inputs0( 27*size-1 DOWNTO 26*size);
     WHEN "011011" =>
       result := inputs0( 28*size-1 DOWNTO 27*size);
     WHEN "011100" =>
       result := inputs0( 29*size-1 DOWNTO 28*size);
     WHEN "011101" =>
       result := inputs0( 30*size-1 DOWNTO 29*size);
     WHEN "011110" =>
       result := inputs0( 31*size-1 DOWNTO 30*size);
     WHEN "011111" =>
       result := inputs0( 32*size-1 DOWNTO 31*size);
     WHEN "100000" =>
       result := inputs0( 33*size-1 DOWNTO 32*size);
     WHEN "100001" =>
       result := inputs0( 34*size-1 DOWNTO 33*size);
     WHEN "100010" =>
       result := inputs0( 35*size-1 DOWNTO 34*size);
     WHEN "100011" =>
       result := inputs0( 36*size-1 DOWNTO 35*size);
     WHEN "100100" =>
       result := inputs0( 37*size-1 DOWNTO 36*size);
     WHEN "100101" =>
       result := inputs0( 38*size-1 DOWNTO 37*size);
     WHEN "100110" =>
       result := inputs0( 39*size-1 DOWNTO 38*size);
     WHEN "100111" =>
       result := inputs0( 40*size-1 DOWNTO 39*size);
     WHEN "101000" =>
       result := inputs0( 41*size-1 DOWNTO 40*size);
     WHEN "101001" =>
       result := inputs0( 42*size-1 DOWNTO 41*size);
     WHEN "101010" =>
       result := inputs0( 43*size-1 DOWNTO 42*size);
     WHEN "101011" =>
       result := inputs0( 44*size-1 DOWNTO 43*size);
     WHEN "101100" =>
       result := inputs0( 45*size-1 DOWNTO 44*size);
     WHEN "101101" =>
       result := inputs0( 46*size-1 DOWNTO 45*size);
     WHEN "101110" =>
       result := inputs0( 47*size-1 DOWNTO 46*size);
     WHEN "101111" =>
       result := inputs0( 48*size-1 DOWNTO 47*size);
     WHEN "110000" =>
       result := inputs0( 49*size-1 DOWNTO 48*size);
     WHEN "110001" =>
       result := inputs0( 50*size-1 DOWNTO 49*size);
     WHEN "110010" =>
       result := inputs0( 51*size-1 DOWNTO 50*size);
     WHEN "110011" =>
       result := inputs0( 52*size-1 DOWNTO 51*size);
     WHEN "110100" =>
       result := inputs0( 53*size-1 DOWNTO 52*size);
     WHEN "110101" =>
       result := inputs0( 54*size-1 DOWNTO 53*size);
     WHEN "110110" =>
       result := inputs0( 55*size-1 DOWNTO 54*size);
     WHEN "110111" =>
       result := inputs0( 56*size-1 DOWNTO 55*size);
     WHEN "111000" =>
       result := inputs0( 57*size-1 DOWNTO 56*size);
     WHEN "111001" =>
       result := inputs0( 58*size-1 DOWNTO 57*size);
     WHEN "111010" =>
       result := inputs0( 59*size-1 DOWNTO 58*size);
     WHEN "111011" =>
       result := inputs0( 60*size-1 DOWNTO 59*size);
     WHEN "111100" =>
       result := inputs0( 61*size-1 DOWNTO 60*size);
     WHEN "111101" =>
       result := inputs0( 62*size-1 DOWNTO 61*size);
     WHEN "111110" =>
       result := inputs0( 63*size-1 DOWNTO 62*size);
     WHEN "111111" =>
       result := inputs0( 64*size-1 DOWNTO 63*size);
     WHEN others =>
       result := (others => 'X');
     END CASE;
     RETURN result;
   END;

   FUNCTION mux_s(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC) RETURN STD_LOGIC IS
   BEGIN RETURN TO_STDLOGIC(mux_v(inputs, sel)); END;

   FUNCTION mux_s(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC_VECTOR) RETURN STD_LOGIC IS
   BEGIN RETURN TO_STDLOGIC(mux_v(inputs, sel)); END;

   FUNCTION mux_v(inputs: STD_LOGIC_VECTOR; sel: STD_LOGIC) RETURN STD_LOGIC_VECTOR IS  --pragma hls_map_to_operator mux
     ALIAS    inputs0: STD_LOGIC_VECTOR(inputs'LENGTH-1 DOWNTO 0) IS inputs;
     CONSTANT size   : POSITIVE := inputs'LENGTH / 2;
     CONSTANT olen   : POSITIVE := inputs'LENGTH / 2;
     VARIABLE result : STD_LOGIC_VECTOR(olen-1 DOWNTO 0);
   BEGIN
     --synopsys translate_off
     ASSERT inputs'LENGTH = olen * 2 SEVERITY FAILURE;
     --synopsys translate_on
       CASE sel IS
       WHEN '1'
     --synopsys translate_off
            | 'H'
     --synopsys translate_on
            =>
         result := inputs0( size-1 DOWNTO 0);
       WHEN '0' 
     --synopsys translate_off
            | 'L'
     --synopsys translate_on
            =>
         result := inputs0(2*size-1  DOWNTO size);
       WHEN others =>
         --synopsys translate_off
         result := resolve_std_logic_vector(inputs0(size-1 DOWNTO 0), inputs0( 2*size-1 DOWNTO size));
         --synopsys translate_on
       END CASE;
       RETURN result;
   END;
--   BEGIN RETURN mux_v(inputs, TO_STDLOGICVECTOR(sel)); END;

   FUNCTION mux_v(inputs: STD_LOGIC_VECTOR; sel : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS --pragma hls_map_to_operator mux
     ALIAS    inputs0: STD_LOGIC_VECTOR( inputs'LENGTH-1 DOWNTO 0) IS inputs;
     ALIAS    sel0   : STD_LOGIC_VECTOR( sel'LENGTH-1 DOWNTO 0 ) IS sel;

     VARIABLE sellen : INTEGER RANGE 2-sel'LENGTH TO sel'LENGTH;
     CONSTANT size   : POSITIVE := inputs'LENGTH / 2;
     CONSTANT olen   : POSITIVE := inputs'LENGTH / 2**sel'LENGTH;
     VARIABLE result : STD_LOGIC_VECTOR(olen-1 DOWNTO 0);
     TYPE inputs_array_type is array(natural range <>) of std_logic_vector( olen - 1 DOWNTO 0);
     VARIABLE inputs_array : inputs_array_type( 2**sel'LENGTH - 1 DOWNTO 0);
   BEGIN
     sellen := sel'LENGTH;
     --synopsys translate_off
     ASSERT inputs'LENGTH = olen * 2**sellen SEVERITY FAILURE;
     sellen := 2-sellen;
     --synopsys translate_on
     CASE sellen IS
     WHEN 1 =>
       CASE sel0(0) IS

       WHEN '1' 
     --synopsys translate_off
            | 'H'
     --synopsys translate_on
            =>
         result := inputs0(  size-1 DOWNTO 0);
       WHEN '0' 
     --synopsys translate_off
            | 'L'
     --synopsys translate_on
            =>
         result := inputs0(2*size-1 DOWNTO size);
       WHEN others =>
         --synopsys translate_off
         result := resolve_std_logic_vector(inputs0( size-1 DOWNTO 0), inputs0( 2*size-1 DOWNTO size));
         --synopsys translate_on
       END CASE;
     WHEN 2 =>
       result := mux_sel2_v(inputs, not sel);
     WHEN 3 =>
       result := mux_sel3_v(inputs, not sel);
     WHEN 4 =>
       result := mux_sel4_v(inputs, not sel);
     WHEN 5 =>
       result := mux_sel5_v(inputs, not sel);
     WHEN 6 =>
       result := mux_sel6_v(inputs, not sel);
     WHEN others =>
       -- synopsys translate_off
       IF(Is_X(sel0)) THEN
         result := (others => 'X');
       ELSE
       -- synopsys translate_on
         FOR i in 0 to 2**sel'LENGTH - 1 LOOP
           inputs_array(i) := inputs0( ((i + 1) * olen) - 1  DOWNTO i*olen);
         END LOOP;
         result := inputs_array(CONV_INTEGER( (UNSIGNED(NOT sel0)) ));
       -- synopsys translate_off
       END IF;
       -- synopsys translate_on
     END CASE;
     RETURN result;
   END;

 
-----------------------------------------------------------------
-- Latches
-----------------------------------------------------------------

   FUNCTION lat_s(dinput: STD_LOGIC; clk: STD_LOGIC; doutput: STD_LOGIC) RETURN STD_LOGIC IS
   BEGIN RETURN mux_s(STD_LOGIC_VECTOR'(doutput & dinput), clk); END;

   FUNCTION lat_v(dinput: STD_LOGIC_VECTOR ; clk: STD_LOGIC; doutput: STD_LOGIC_VECTOR ) RETURN STD_LOGIC_VECTOR IS
   BEGIN
     --synopsys translate_off
     ASSERT dinput'LENGTH = doutput'LENGTH SEVERITY FAILURE;
     --synopsys translate_on
     RETURN mux_v(doutput & dinput, clk);
   END;

-----------------------------------------------------------------
-- Tri-States
-----------------------------------------------------------------
--   FUNCTION tri_s(dinput: STD_LOGIC; control: STD_LOGIC) RETURN STD_LOGIC IS
--   BEGIN RETURN TO_STDLOGIC(tri_v(TO_STDLOGICVECTOR(dinput), control)); END;
--
--   FUNCTION tri_v(dinput: STD_LOGIC_VECTOR ; control: STD_LOGIC) RETURN STD_LOGIC_VECTOR IS
--     VARIABLE result: STD_LOGIC_VECTOR(dinput'range);
--   BEGIN
--     CASE control IS
--     WHEN '0' | 'L' =>
--       result := (others => 'Z');
--     WHEN '1' | 'H' =>
--       FOR i IN dinput'range LOOP
--         result(i) := to_UX01(dinput(i));
--       END LOOP;
--     WHEN others =>
--       -- synopsys translate_off
--       result := (others => 'X');
--       -- synopsys translate_on
--     END CASE;
--     RETURN result;
--   END;

-----------------------------------------------------------------
-- compare functions returning STD_LOGIC
-- in contrast to the functions returning boolean
-----------------------------------------------------------------

   FUNCTION "=" (l, r: UNSIGNED) RETURN STD_LOGIC IS
     BEGIN RETURN not or_s(STD_LOGIC_VECTOR(l) xor STD_LOGIC_VECTOR(r)); END;
   FUNCTION "=" (l, r: SIGNED  ) RETURN STD_LOGIC IS
     BEGIN RETURN not or_s(STD_LOGIC_VECTOR(l) xor STD_LOGIC_VECTOR(r)); END;
   FUNCTION "/="(l, r: UNSIGNED) RETURN STD_LOGIC IS
     BEGIN RETURN or_s(STD_LOGIC_VECTOR(l) xor STD_LOGIC_VECTOR(r)); END;
   FUNCTION "/="(l, r: SIGNED  ) RETURN STD_LOGIC IS
     BEGIN RETURN or_s(STD_LOGIC_VECTOR(l) xor STD_LOGIC_VECTOR(r)); END;

   FUNCTION "<" (l, r: UNSIGNED) RETURN STD_LOGIC IS
     VARIABLE diff: UNSIGNED(l'LENGTH DOWNTO 0);
   BEGIN
     --synopsys translate_off
     ASSERT l'LENGTH = r'LENGTH SEVERITY FAILURE;
     --synopsys translate_on
     diff := ('0'&l) - ('0'&r);
     RETURN diff(l'LENGTH);
   END;
   FUNCTION "<"(l, r: SIGNED  ) RETURN STD_LOGIC IS
   BEGIN
     RETURN (UNSIGNED(l) < UNSIGNED(r)) xor (l(l'LEFT) xor r(r'LEFT));
   END;

   FUNCTION "<="(l, r: UNSIGNED) RETURN STD_LOGIC IS
     BEGIN RETURN not STD_LOGIC'(r < l); END;
   FUNCTION "<=" (l, r: SIGNED  ) RETURN STD_LOGIC IS
     BEGIN RETURN not STD_LOGIC'(r < l); END;
   FUNCTION ">" (l, r: UNSIGNED) RETURN STD_LOGIC IS
     BEGIN RETURN r < l; END;
   FUNCTION ">"(l, r: SIGNED  ) RETURN STD_LOGIC IS
     BEGIN RETURN r < l; END;
   FUNCTION ">="(l, r: UNSIGNED) RETURN STD_LOGIC IS
     BEGIN RETURN not STD_LOGIC'(l < r); END;
   FUNCTION ">=" (l, r: SIGNED  ) RETURN STD_LOGIC IS
     BEGIN RETURN not STD_LOGIC'(l < r); END;

   FUNCTION cmp (l, r: STD_LOGIC_VECTOR) RETURN STD_LOGIC IS
   BEGIN
     --synopsys translate_off
     ASSERT l'LENGTH = r'LENGTH SEVERITY FAILURE;
     --synopsys translate_on
     RETURN not or_s(l xor r);
   END;

-----------------------------------------------------------------
-- Vectorized Overloaded Arithmetic Operators
-----------------------------------------------------------------

   --some functions to placate spyglass
   FUNCTION mult_natural(a,b : NATURAL) RETURN NATURAL IS
   BEGIN
     return a*b;
   END mult_natural;

   FUNCTION div_natural(a,b : NATURAL) RETURN NATURAL IS
   BEGIN
     return a/b;
   END div_natural;

   FUNCTION mod_natural(a,b : NATURAL) RETURN NATURAL IS
   BEGIN
     return a mod b;
   END mod_natural;

   FUNCTION add_unsigned(a,b : UNSIGNED) RETURN UNSIGNED IS
   BEGIN
     return a+b;
   END add_unsigned;

   FUNCTION sub_unsigned(a,b : UNSIGNED) RETURN UNSIGNED IS
   BEGIN
     return a-b;
   END sub_unsigned;

   FUNCTION sub_int(a,b : INTEGER) RETURN INTEGER IS
   BEGIN
     return a-b;
   END sub_int;

   FUNCTION concat_0(b : UNSIGNED) RETURN UNSIGNED IS
   BEGIN
     return '0' & b;
   END concat_0;

   FUNCTION concat_uns(a,b : UNSIGNED) RETURN UNSIGNED IS
   BEGIN
     return a&b;
   END concat_uns;

   FUNCTION concat_vect(a,b : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
   BEGIN
     return a&b;
   END concat_vect;





   FUNCTION faccu(arg: UNSIGNED; width: NATURAL) RETURN UNSIGNED IS
     CONSTANT ninps : NATURAL := arg'LENGTH / width;
     ALIAS    arg0  : UNSIGNED(arg'LENGTH-1 DOWNTO 0) IS arg;
     VARIABLE result: UNSIGNED(width-1 DOWNTO 0);
     VARIABLE from  : INTEGER;
     VARIABLE dto   : INTEGER;
   BEGIN
     --synopsys translate_off
     ASSERT arg'LENGTH = width * ninps SEVERITY FAILURE;
     --synopsys translate_on
     result := (OTHERS => '0');
     FOR i IN ninps-1 DOWNTO 0 LOOP
       --result := result + arg0((i+1)*width-1 DOWNTO i*width);
       from := mult_natural((i+1), width)-1; --2.1.6.3
       dto  := mult_natural(i,width); --2.1.6.3
       result := add_unsigned(result , arg0(from DOWNTO dto) );
     END LOOP;
     RETURN result;
   END faccu;

   FUNCTION  fabs (arg1: SIGNED) RETURN UNSIGNED IS
   BEGIN
     CASE arg1(arg1'LEFT) IS
     WHEN '1'
     --synopsys translate_off
          | 'H'
     --synopsys translate_on
       =>
       RETURN UNSIGNED'("0") - UNSIGNED(arg1);
     WHEN '0'
     --synopsys translate_off
          | 'L'
     --synopsys translate_on
       =>
       RETURN UNSIGNED(arg1);
     WHEN others =>
       RETURN resolve_unsigned(UNSIGNED(arg1), UNSIGNED'("0") - UNSIGNED(arg1));
     END CASE;
   END;

   PROCEDURE divmod(l, r: UNSIGNED; rdiv, rmod: OUT UNSIGNED) IS
     CONSTANT llen: INTEGER := l'LENGTH;
     CONSTANT rlen: INTEGER := r'LENGTH;
     CONSTANT llen_plus_rlen: INTEGER := llen + rlen;
     VARIABLE lbuf: UNSIGNED(llen+rlen-1 DOWNTO 0);
     VARIABLE diff: UNSIGNED(rlen DOWNTO 0);
   BEGIN
     --synopsys translate_off
     ASSERT rdiv'LENGTH = llen AND rmod'LENGTH = rlen SEVERITY FAILURE;
     --synopsys translate_on
     lbuf := (others => '0');
     lbuf(llen-1 DOWNTO 0) := l;
     FOR i IN rdiv'range LOOP
       diff := sub_unsigned(lbuf(llen_plus_rlen-1 DOWNTO llen-1) ,(concat_0(r)));
       rdiv(i) := not diff(rlen);
       IF diff(rlen) = '0' THEN
         lbuf(llen_plus_rlen-1 DOWNTO llen-1) := diff;
       END IF;
       lbuf(llen_plus_rlen-1 DOWNTO 1) := lbuf(llen_plus_rlen-2 DOWNTO 0);
     END LOOP;
     rmod := lbuf(llen_plus_rlen-1 DOWNTO llen);
   END divmod;

   FUNCTION "/"  (l, r: UNSIGNED) RETURN UNSIGNED IS
     VARIABLE rdiv: UNSIGNED(l'LENGTH-1 DOWNTO 0);
     VARIABLE rmod: UNSIGNED(r'LENGTH-1 DOWNTO 0);
   BEGIN
     divmod(l, r, rdiv, rmod);
     RETURN rdiv;
   END "/";

   FUNCTION "MOD"(l, r: UNSIGNED) RETURN UNSIGNED IS
     VARIABLE rdiv: UNSIGNED(l'LENGTH-1 DOWNTO 0);
     VARIABLE rmod: UNSIGNED(r'LENGTH-1 DOWNTO 0);
   BEGIN
     divmod(l, r, rdiv, rmod);
     RETURN rmod;
   END;

   FUNCTION "REM"(l, r: UNSIGNED) RETURN UNSIGNED IS
     BEGIN RETURN l MOD r; END;

   FUNCTION "/"  (l, r: SIGNED  ) RETURN SIGNED  IS
     VARIABLE rdiv: UNSIGNED(l'LENGTH-1 DOWNTO 0);
     VARIABLE rmod: UNSIGNED(r'LENGTH-1 DOWNTO 0);
   BEGIN
     divmod(fabs(l), fabs(r), rdiv, rmod);
     IF to_X01(l(l'LEFT)) /= to_X01(r(r'LEFT)) THEN
       rdiv := UNSIGNED'("0") - rdiv;
     END IF;
     RETURN SIGNED(rdiv); -- overflow problem "1000" / "11"
   END "/";

   FUNCTION "MOD"(l, r: SIGNED  ) RETURN SIGNED  IS
     VARIABLE rdiv: UNSIGNED(l'LENGTH-1 DOWNTO 0);
     VARIABLE rmod: UNSIGNED(r'LENGTH-1 DOWNTO 0);
     CONSTANT rnul: UNSIGNED(r'LENGTH-1 DOWNTO 0) := (others => '0');
   BEGIN
     divmod(fabs(l), fabs(r), rdiv, rmod);
     IF to_X01(l(l'LEFT)) = '1' THEN
       rmod := UNSIGNED'("0") - rmod;
     END IF;
     IF rmod /= rnul AND to_X01(l(l'LEFT)) /= to_X01(r(r'LEFT)) THEN
       rmod := UNSIGNED(r) + rmod;
     END IF;
     RETURN SIGNED(rmod);
   END "MOD";

   FUNCTION "REM"(l, r: SIGNED  ) RETURN SIGNED  IS
     VARIABLE rdiv: UNSIGNED(l'LENGTH-1 DOWNTO 0);
     VARIABLE rmod: UNSIGNED(r'LENGTH-1 DOWNTO 0);
   BEGIN
     divmod(fabs(l), fabs(r), rdiv, rmod);
     IF to_X01(l(l'LEFT)) = '1' THEN
       rmod := UNSIGNED'("0") - rmod;
     END IF;
     RETURN SIGNED(rmod);
   END "REM";

   FUNCTION mult_unsigned(l,r : UNSIGNED) return UNSIGNED is
   BEGIN
     return l*r; 
   END mult_unsigned;

   FUNCTION "**" (l, r : UNSIGNED) RETURN UNSIGNED IS
     CONSTANT llen  : NATURAL := l'LENGTH;
     VARIABLE result: UNSIGNED(llen-1 DOWNTO 0);
     VARIABLE fak   : UNSIGNED(llen-1 DOWNTO 0);
   BEGIN
     fak := l;
     result := (others => '0'); result(0) := '1';
     FOR i IN r'reverse_range LOOP
       --was:result := UNSIGNED(mux_v(STD_LOGIC_VECTOR(result & (result*fak)), r(i)));
       result := UNSIGNED(mux_v(STD_LOGIC_VECTOR( concat_uns(result , mult_unsigned(result,fak) )), r(i)));

       fak := mult_unsigned(fak , fak);
     END LOOP;
     RETURN result;
   END "**";

   FUNCTION "**" (l, r : SIGNED) RETURN SIGNED IS
     CONSTANT rlen  : NATURAL := r'LENGTH;
     ALIAS    r0    : SIGNED(0 TO r'LENGTH-1) IS r;
     VARIABLE result: SIGNED(l'range);
   BEGIN
     CASE r(r'LEFT) IS
     WHEN '0'
   --synopsys translate_off
          | 'L'
   --synopsys translate_on
     =>
       result := SIGNED(UNSIGNED(l) ** UNSIGNED(r0(1 TO r'LENGTH-1)));
     WHEN '1'
   --synopsys translate_off
          | 'H'
   --synopsys translate_on
     =>
       result := (others => '0');
     WHEN others =>
       result := (others => 'X');
     END CASE;
     RETURN result;
   END "**";

-----------------------------------------------------------------
--               S H I F T   F U C T I O N S
-- negative shift shifts the opposite direction
-----------------------------------------------------------------

   FUNCTION add_nat(arg1 : NATURAL; arg2 : NATURAL ) RETURN NATURAL IS
   BEGIN
     return (arg1 + arg2);
   END;
   
--   FUNCTION UNSIGNED_2_BIT_VECTOR(arg1 : NATURAL; arg2 : NATURAL ) RETURN BIT_VECTOR IS
--   BEGIN
--     return (arg1 + arg2);
--   END;
   
   FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
     CONSTANT ilen: INTEGER := arg1'LENGTH;
     CONSTANT olenM1: INTEGER := olen-1; -- 2.1.6.3
     CONSTANT ilenub: INTEGER := arg1'LENGTH-1;
     CONSTANT len: INTEGER := maximum(ilen, olen);
     VARIABLE result: UNSIGNED(len-1 DOWNTO 0);
   BEGIN
     result := (others => sbit);
     result(ilenub DOWNTO 0) := arg1;
     result := shl(result, arg2);
     RETURN result(olenM1 DOWNTO 0);
   END;

   FUNCTION fshl_stdar(arg1: SIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN SIGNED IS
     CONSTANT ilen: INTEGER := arg1'LENGTH;
     CONSTANT olenM1: INTEGER := olen-1; -- 2.1.6.3
     CONSTANT ilenub: INTEGER := arg1'LENGTH-1;
     CONSTANT len: INTEGER := maximum(ilen, olen);
     VARIABLE result: SIGNED(len-1 DOWNTO 0);
   BEGIN
     result := (others => sbit);
     result(ilenub DOWNTO 0) := arg1;
     result := shl(SIGNED(result), arg2);
     RETURN result(olenM1 DOWNTO 0);
   END;

   FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
     CONSTANT ilen: INTEGER := arg1'LENGTH;
     CONSTANT olenM1: INTEGER := olen-1; -- 2.1.6.3
     CONSTANT ilenub: INTEGER := arg1'LENGTH-1;
     CONSTANT len: INTEGER := maximum(ilen, olen);
     VARIABLE result: UNSIGNED(len-1 DOWNTO 0);
   BEGIN
     result := (others => sbit);
     result(ilenub DOWNTO 0) := arg1;
     result := shr(result, arg2);
     RETURN result(olenM1 DOWNTO 0);
   END;

   FUNCTION fshr_stdar(arg1: SIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN SIGNED IS
     CONSTANT ilen: INTEGER := arg1'LENGTH;
     CONSTANT olenM1: INTEGER := olen-1; -- 2.1.6.3
     CONSTANT ilenub: INTEGER := arg1'LENGTH-1;
     CONSTANT len: INTEGER := maximum(ilen, olen);
     VARIABLE result: SIGNED(len-1 DOWNTO 0);
   BEGIN
     result := (others => sbit);
     result(ilenub DOWNTO 0) := arg1;
     result := shr(result, arg2);
     RETURN result(olenM1 DOWNTO 0);
   END;

   FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
     CONSTANT arg1l: NATURAL := arg1'LENGTH - 1;
     ALIAS    arg1x: UNSIGNED(arg1l DOWNTO 0) IS arg1;
     CONSTANT arg2l: NATURAL := arg2'LENGTH - 1;
     ALIAS    arg2x: SIGNED(arg2l DOWNTO 0) IS arg2;
     VARIABLE arg1x_pad: UNSIGNED(arg1l+1 DOWNTO 0);
     VARIABLE result: UNSIGNED(olen-1 DOWNTO 0);
   BEGIN
     result := (others=>'0');
     arg1x_pad(arg1l+1) := sbit;
     arg1x_pad(arg1l downto 0) := arg1x;
     IF arg2l = 0 THEN
       RETURN fshr_stdar(arg1x_pad, UNSIGNED(arg2x), sbit, olen);
     -- ELSIF arg1l = 0 THEN
     --   RETURN fshl(sbit & arg1x, arg2x, sbit, olen);
     ELSE
       CASE arg2x(arg2l) IS
       WHEN '0'
     --synopsys translate_off
            | 'L'
     --synopsys translate_on
       =>
         RETURN fshl_stdar(arg1x_pad, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);
       WHEN '1'
     --synopsys translate_off
            | 'H'
     --synopsys translate_on
       =>
         RETURN fshr_stdar(arg1x_pad(arg1l+1 DOWNTO 1), '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);
       WHEN others =>
         --synopsys translate_off
         result := resolve_unsigned(
           fshl_stdar(arg1x, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit,  olen),
           fshr_stdar(arg1x_pad(arg1l+1 DOWNTO 1), '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen)
         );
         --synopsys translate_on
         RETURN result;
       END CASE;
     END IF;
   END;

   FUNCTION fshl_stdar(arg1: SIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN SIGNED IS
     CONSTANT arg1l: NATURAL := arg1'LENGTH - 1;
     ALIAS    arg1x: SIGNED(arg1l DOWNTO 0) IS arg1;
     CONSTANT arg2l: NATURAL := arg2'LENGTH - 1;
     ALIAS    arg2x: SIGNED(arg2l DOWNTO 0) IS arg2;
     VARIABLE arg1x_pad: SIGNED(arg1l+1 DOWNTO 0);
     VARIABLE result: SIGNED(olen-1 DOWNTO 0);
   BEGIN
     result := (others=>'0');
     arg1x_pad(arg1l+1) := sbit;
     arg1x_pad(arg1l downto 0) := arg1x;
     IF arg2l = 0 THEN
       RETURN fshr_stdar(arg1x_pad, UNSIGNED(arg2x), sbit, olen);
     -- ELSIF arg1l = 0 THEN
     --   RETURN fshl(sbit & arg1x, arg2x, sbit, olen);
     ELSE
       CASE arg2x(arg2l) IS
       WHEN '0'
       --synopsys translate_off
            | 'L'
       --synopsys translate_on
       =>
         RETURN fshl_stdar(arg1x_pad, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);
       WHEN '1'
       --synopsys translate_off
            | 'H'
       --synopsys translate_on
       =>
         RETURN fshr_stdar(arg1x_pad(arg1l+1 DOWNTO 1), '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);
       WHEN others =>
         --synopsys translate_off
         result := resolve_signed(
           fshl_stdar(arg1x, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit,  olen),
           fshr_stdar(arg1x_pad(arg1l+1 DOWNTO 1), '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen)
         );
         --synopsys translate_on
         RETURN result;
       END CASE;
     END IF;
   END;

   FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
     CONSTANT arg2l: INTEGER := arg2'LENGTH - 1;
     ALIAS    arg2x: SIGNED(arg2l DOWNTO 0) IS arg2;
     VARIABLE result: UNSIGNED(olen-1 DOWNTO 0);
   BEGIN
     result := (others => '0');
     IF arg2l = 0 THEN
       RETURN fshl_stdar(arg1, UNSIGNED(arg2x), olen);
     ELSE
       CASE arg2x(arg2l) IS
       WHEN '0'
       --synopsys translate_off
            | 'L'
       --synopsys translate_on
        =>
         RETURN fshr_stdar(arg1, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);
       WHEN '1'
       --synopsys translate_off
            | 'H'
       --synopsys translate_on
        =>
         RETURN fshl_stdar(arg1 & '0', '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), olen);
       WHEN others =>
         --synopsys translate_off
         result := resolve_unsigned(
           fshr_stdar(arg1, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen),
           fshl_stdar(arg1 & '0', '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), olen)
         );
         --synopsys translate_on
	 return result;
       END CASE;
     END IF;
   END;

   FUNCTION fshr_stdar(arg1: SIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN SIGNED IS
     CONSTANT arg2l: INTEGER := arg2'LENGTH - 1;
     ALIAS    arg2x: SIGNED(arg2l DOWNTO 0) IS arg2;
     VARIABLE result: SIGNED(olen-1 DOWNTO 0);
   BEGIN
     result := (others => '0');
     IF arg2l = 0 THEN
       RETURN fshl_stdar(arg1, UNSIGNED(arg2x), olen);
     ELSE
       CASE arg2x(arg2l) IS
       WHEN '0'
       --synopsys translate_off
            | 'L'
       --synopsys translate_on
       =>
         RETURN fshr_stdar(arg1, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);
       WHEN '1'
       --synopsys translate_off
            | 'H'
       --synopsys translate_on
       =>
         RETURN fshl_stdar(arg1 & '0', '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), olen);
       WHEN others =>
         --synopsys translate_off
         result := resolve_signed(
           fshr_stdar(arg1, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen),
           fshl_stdar(arg1 & '0', '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), olen)
         );
         --synopsys translate_on
	 return result;
       END CASE;
     END IF;
   END;

   FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE) RETURN UNSIGNED IS
     BEGIN RETURN fshl_stdar(arg1, arg2, '0', olen); END;
   FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE) RETURN UNSIGNED IS
     BEGIN RETURN fshr_stdar(arg1, arg2, '0', olen); END;
   FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: SIGNED  ; olen: POSITIVE) RETURN UNSIGNED IS
     BEGIN RETURN fshl_stdar(arg1, arg2, '0', olen); END;
   FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: SIGNED  ; olen: POSITIVE) RETURN UNSIGNED IS
     BEGIN RETURN fshr_stdar(arg1, arg2, '0', olen); END;

   FUNCTION fshl_stdar(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE) RETURN SIGNED   IS
     BEGIN RETURN fshl_stdar(arg1, arg2, arg1(arg1'LEFT), olen); END;
   FUNCTION fshr_stdar(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE) RETURN SIGNED   IS
     BEGIN RETURN fshr_stdar(arg1, arg2, arg1(arg1'LEFT), olen); END;
   FUNCTION fshl_stdar(arg1: SIGNED  ; arg2: SIGNED  ; olen: POSITIVE) RETURN SIGNED   IS
     BEGIN RETURN fshl_stdar(arg1, arg2, arg1(arg1'LEFT), olen); END;
   FUNCTION fshr_stdar(arg1: SIGNED  ; arg2: SIGNED  ; olen: POSITIVE) RETURN SIGNED   IS
     BEGIN RETURN fshr_stdar(arg1, arg2, arg1(arg1'LEFT), olen); END;


   FUNCTION fshl(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
     CONSTANT ilen: INTEGER := arg1'LENGTH;
     CONSTANT olenM1: INTEGER := olen-1; --2.1.6.3
     CONSTANT len: INTEGER := maximum(ilen, olen);
     VARIABLE result: UNSIGNED(len-1 DOWNTO 0);
     VARIABLE temp: UNSIGNED(len-1 DOWNTO 0);
     --SUBTYPE  sw_range IS NATURAL range 1 TO len;
     VARIABLE sw: NATURAL range 1 TO len;
     VARIABLE temp_idx : INTEGER; --2.1.6.3
   BEGIN
     sw := 1;
     result := (others => sbit);
     result(ilen-1 DOWNTO 0) := arg1;
     FOR i IN arg2'reverse_range LOOP
       temp := (others => '0');
       FOR i2 IN len-1-sw DOWNTO 0 LOOP
         --was:temp(i2+sw) := result(i2);
         temp_idx := add_nat(i2,sw);
         temp(temp_idx) := result(i2);
       END LOOP;
       result := UNSIGNED(mux_v(STD_LOGIC_VECTOR(concat_uns(result,temp)), arg2(i)));
       sw := minimum(mult_natural(sw,2), len);
     END LOOP;
     RETURN result(olenM1 DOWNTO 0);
   END;

   FUNCTION fshr(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
     CONSTANT ilen: INTEGER := arg1'LENGTH;
     CONSTANT olenM1: INTEGER := olen-1; --2.1.6.3
     CONSTANT len: INTEGER := maximum(ilen, olen);
     VARIABLE result: UNSIGNED(len-1 DOWNTO 0);
     VARIABLE temp: UNSIGNED(len-1 DOWNTO 0);
     SUBTYPE  sw_range IS NATURAL range 1 TO len;
     VARIABLE sw: sw_range;
     VARIABLE result_idx : INTEGER; --2.1.6.3
   BEGIN
     sw := 1;
     result := (others => sbit);
     result(ilen-1 DOWNTO 0) := arg1;
     FOR i IN arg2'reverse_range LOOP
       temp := (others => sbit);
       FOR i2 IN len-1-sw DOWNTO 0 LOOP
         -- was: temp(i2) := result(i2+sw);
         result_idx := add_nat(i2,sw);
         temp(i2) := result(result_idx);
       END LOOP;
       result := UNSIGNED(mux_v(STD_LOGIC_VECTOR(concat_uns(result,temp)), arg2(i)));
       sw := minimum(mult_natural(sw,2), len);
     END LOOP;
     RETURN result(olenM1 DOWNTO 0);
   END;

   FUNCTION fshl(arg1: UNSIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
     CONSTANT arg1l: NATURAL := arg1'LENGTH - 1;
     ALIAS    arg1x: UNSIGNED(arg1l DOWNTO 0) IS arg1;
     CONSTANT arg2l: NATURAL := arg2'LENGTH - 1;
     ALIAS    arg2x: SIGNED(arg2l DOWNTO 0) IS arg2;
     VARIABLE arg1x_pad: UNSIGNED(arg1l+1 DOWNTO 0);
     VARIABLE result: UNSIGNED(olen-1 DOWNTO 0);
   BEGIN
     result := (others=>'0');
     arg1x_pad(arg1l+1) := sbit;
     arg1x_pad(arg1l downto 0) := arg1x;
     IF arg2l = 0 THEN
       RETURN fshr(arg1x_pad, UNSIGNED(arg2x), sbit, olen);
     -- ELSIF arg1l = 0 THEN
     --   RETURN fshl(sbit & arg1x, arg2x, sbit, olen);
     ELSE
       CASE arg2x(arg2l) IS
       WHEN '0'
       --synopsys translate_off
            | 'L'
       --synopsys translate_on
       =>
         RETURN fshl(arg1x_pad, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);

       WHEN '1'
       --synopsys translate_off
            | 'H'
       --synopsys translate_on
       =>
         RETURN fshr(arg1x_pad(arg1l+1 DOWNTO 1), not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);

       WHEN others =>
         --synopsys translate_off
         result := resolve_unsigned(
           fshl(arg1x_pad, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit,  olen),
           fshr(arg1x_pad(arg1l+1 DOWNTO 1), not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen)
         );
         --synopsys translate_on
         RETURN result;
       END CASE;
     END IF;
   END;

   FUNCTION fshr(arg1: UNSIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
     CONSTANT arg2l: INTEGER := arg2'LENGTH - 1;
     ALIAS    arg2x: SIGNED(arg2l DOWNTO 0) IS arg2;
     VARIABLE result: UNSIGNED(olen-1 DOWNTO 0);
   BEGIN
     result := (others => '0');
     IF arg2l = 0 THEN
       RETURN fshl(arg1, UNSIGNED(arg2x), olen);
     ELSE
       CASE arg2x(arg2l) IS
       WHEN '0'
       --synopsys translate_off
            | 'L'
       --synopsys translate_on
       =>
         RETURN fshr(arg1, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);

       WHEN '1'
       --synopsys translate_off
            | 'H'
       --synopsys translate_on
       =>
         RETURN fshl(arg1 & '0', not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), olen);
       WHEN others =>
         --synopsys translate_off
         result := resolve_unsigned(
           fshr(arg1, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen),
           fshl(arg1 & '0', not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), olen)
         );
         --synopsys translate_on
	 return result;
       END CASE;
     END IF;
   END;

   FUNCTION fshl(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE) RETURN UNSIGNED IS
     BEGIN RETURN fshl(arg1, arg2, '0', olen); END;
   FUNCTION fshr(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE) RETURN UNSIGNED IS
     BEGIN RETURN fshr(arg1, arg2, '0', olen); END;
   FUNCTION fshl(arg1: UNSIGNED; arg2: SIGNED  ; olen: POSITIVE) RETURN UNSIGNED IS
     BEGIN RETURN fshl(arg1, arg2, '0', olen); END;
   FUNCTION fshr(arg1: UNSIGNED; arg2: SIGNED  ; olen: POSITIVE) RETURN UNSIGNED IS
     BEGIN RETURN fshr(arg1, arg2, '0', olen); END;

   FUNCTION fshl(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE) RETURN SIGNED   IS
     BEGIN RETURN SIGNED(fshl(UNSIGNED(arg1), arg2, arg1(arg1'LEFT), olen)); END;
   FUNCTION fshr(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE) RETURN SIGNED   IS
     BEGIN RETURN SIGNED(fshr(UNSIGNED(arg1), arg2, arg1(arg1'LEFT), olen)); END;
   FUNCTION fshl(arg1: SIGNED  ; arg2: SIGNED  ; olen: POSITIVE) RETURN SIGNED   IS
     BEGIN RETURN SIGNED(fshl(UNSIGNED(arg1), arg2, arg1(arg1'LEFT), olen)); END;
   FUNCTION fshr(arg1: SIGNED  ; arg2: SIGNED  ; olen: POSITIVE) RETURN SIGNED   IS
     BEGIN RETURN SIGNED(fshr(UNSIGNED(arg1), arg2, arg1(arg1'LEFT), olen)); END;


   FUNCTION frot(arg1: STD_LOGIC_VECTOR; arg2: STD_LOGIC_VECTOR; signd2: BOOLEAN; sdir: INTEGER range -1 TO 1) RETURN STD_LOGIC_VECTOR IS
     CONSTANT len: INTEGER := arg1'LENGTH;
     VARIABLE result: STD_LOGIC_VECTOR(len-1 DOWNTO 0);
     VARIABLE temp: STD_LOGIC_VECTOR(len-1 DOWNTO 0);
     SUBTYPE sw_range IS NATURAL range 0 TO len-1;
     VARIABLE sw: sw_range;
     VARIABLE temp_idx : INTEGER; --2.1.6.3
   BEGIN
     result := (others=>'0');
     result := arg1;
     sw := sdir MOD len;
     FOR i IN arg2'reverse_range LOOP
       EXIT WHEN sw = 0;
       IF signd2 AND i = arg2'LEFT THEN 
         sw := sub_int(len,sw); 
       END IF;
       -- temp := result(len-sw-1 DOWNTO 0) & result(len-1 DOWNTO len-sw)
       FOR i2 IN len-1 DOWNTO 0 LOOP
         --was: temp((i2+sw) MOD len) := result(i2);
         temp_idx := add_nat(i2,sw) MOD len;
         temp(temp_idx) := result(i2);
       END LOOP;
       result := mux_v(STD_LOGIC_VECTOR(concat_vect(result,temp)), arg2(i));
       sw := mod_natural(mult_natural(sw,2), len);
     END LOOP;
     RETURN result;
   END frot;

   FUNCTION frol(arg1: STD_LOGIC_VECTOR; arg2: UNSIGNED) RETURN STD_LOGIC_VECTOR IS
     BEGIN RETURN frot(arg1, STD_LOGIC_VECTOR(arg2), FALSE, 1); END;
   FUNCTION fror(arg1: STD_LOGIC_VECTOR; arg2: UNSIGNED) RETURN STD_LOGIC_VECTOR IS
     BEGIN RETURN frot(arg1, STD_LOGIC_VECTOR(arg2), FALSE, -1); END;
   FUNCTION frol(arg1: STD_LOGIC_VECTOR; arg2: SIGNED  ) RETURN STD_LOGIC_VECTOR IS
     BEGIN RETURN frot(arg1, STD_LOGIC_VECTOR(arg2), TRUE, 1); END;
   FUNCTION fror(arg1: STD_LOGIC_VECTOR; arg2: SIGNED  ) RETURN STD_LOGIC_VECTOR IS
     BEGIN RETURN frot(arg1, STD_LOGIC_VECTOR(arg2), TRUE, -1); END;

-----------------------------------------------------------------
-- indexing functions: LSB always has index 0
-----------------------------------------------------------------

   FUNCTION readindex(vec: STD_LOGIC_VECTOR; index: INTEGER                 ) RETURN STD_LOGIC IS
     CONSTANT len : INTEGER := vec'LENGTH;
     ALIAS    vec0: STD_LOGIC_VECTOR(len-1 DOWNTO 0) IS vec;
   BEGIN
     IF index >= len OR index < 0 THEN
       RETURN 'X';
     END IF;
     RETURN vec0(index);
   END;

   FUNCTION readslice(vec: STD_LOGIC_VECTOR; index: INTEGER; width: POSITIVE) RETURN STD_LOGIC_VECTOR IS
     CONSTANT len : INTEGER := vec'LENGTH;
     CONSTANT indexPwidthM1 : INTEGER := index+width-1; --2.1.6.3
     ALIAS    vec0: STD_LOGIC_VECTOR(len-1 DOWNTO 0) IS vec;
     CONSTANT xxx : STD_LOGIC_VECTOR(width-1 DOWNTO 0) := (others => 'X');
   BEGIN
     IF index+width > len OR index < 0 THEN
       RETURN xxx;
     END IF;
     RETURN vec0(indexPwidthM1 DOWNTO index);
   END;

   FUNCTION writeindex(vec: STD_LOGIC_VECTOR; dinput: STD_LOGIC       ; index: INTEGER) RETURN STD_LOGIC_VECTOR IS
     CONSTANT len : INTEGER := vec'LENGTH;
     VARIABLE vec0: STD_LOGIC_VECTOR(len-1 DOWNTO 0);
     CONSTANT xxx : STD_LOGIC_VECTOR(len-1 DOWNTO 0) := (others => 'X');
   BEGIN
     vec0 := vec;
     IF index >= len OR index < 0 THEN
       RETURN xxx;
     END IF;
     vec0(index) := dinput;
     RETURN vec0;
   END;

   FUNCTION n_bits(p: NATURAL) RETURN POSITIVE IS
     VARIABLE n_b : POSITIVE;
     VARIABLE p_v : NATURAL;
   BEGIN
     p_v := p;
     FOR i IN 1 TO 32 LOOP
       p_v := div_natural(p_v,2);
       n_b := i;
       EXIT WHEN (p_v = 0);
     END LOOP;
     RETURN n_b;
   END;


--   FUNCTION writeslice(vec: STD_LOGIC_VECTOR; dinput: STD_LOGIC_VECTOR; index: INTEGER) RETURN STD_LOGIC_VECTOR IS
--
--     CONSTANT vlen: INTEGER := vec'LENGTH;
--     CONSTANT ilen: INTEGER := dinput'LENGTH;
--     CONSTANT max_shift: INTEGER := vlen-ilen;
--     CONSTANT ones: UNSIGNED(ilen-1 DOWNTO 0) := (others => '1');
--     CONSTANT xxx : STD_LOGIC_VECTOR(vlen-1 DOWNTO 0) := (others => 'X');
--     VARIABLE shift : UNSIGNED(n_bits(max_shift)-1 DOWNTO 0);
--     VARIABLE vec0: STD_LOGIC_VECTOR(vlen-1 DOWNTO 0);
--     VARIABLE inp: UNSIGNED(vlen-1 DOWNTO 0);
--     VARIABLE mask: UNSIGNED(vlen-1 DOWNTO 0);
--   BEGIN
--     inp := (others => '0');
--     mask := (others => '0');
--
--     IF index > max_shift OR index < 0 THEN
--       RETURN xxx;
--     END IF;
--
--     shift := CONV_UNSIGNED(index, shift'LENGTH);
--     inp(ilen-1 DOWNTO 0) := UNSIGNED(dinput);
--     mask(ilen-1 DOWNTO 0) := ones;
--     inp := fshl(inp, shift, vlen);
--     mask := fshl(mask, shift, vlen);
--     vec0 := (vec and (not STD_LOGIC_VECTOR(mask))) or STD_LOGIC_VECTOR(inp);
--     RETURN vec0;
--   END;

   FUNCTION writeslice(vec: STD_LOGIC_VECTOR; dinput: STD_LOGIC_VECTOR; enable: STD_LOGIC_VECTOR; byte_width: INTEGER;  index: INTEGER) RETURN STD_LOGIC_VECTOR IS

     type enable_matrix is array (0 to enable'LENGTH-1 ) of std_logic_vector(byte_width-1 downto 0);
     CONSTANT vlen: INTEGER := vec'LENGTH;
     CONSTANT ilen: INTEGER := dinput'LENGTH;
     CONSTANT max_shift: INTEGER := vlen-ilen;
     CONSTANT ones: UNSIGNED(ilen-1 DOWNTO 0) := (others => '1');
     CONSTANT xxx : STD_LOGIC_VECTOR(vlen-1 DOWNTO 0) := (others => 'X');
     VARIABLE shift : UNSIGNED(n_bits(max_shift)-1 DOWNTO 0);
     VARIABLE vec0: STD_LOGIC_VECTOR(vlen-1 DOWNTO 0);
     VARIABLE inp: UNSIGNED(vlen-1 DOWNTO 0);
     VARIABLE mask: UNSIGNED(vlen-1 DOWNTO 0);
     VARIABLE mask2: UNSIGNED(vlen-1 DOWNTO 0);
     VARIABLE enables: enable_matrix;
     VARIABLE cat_enables: STD_LOGIC_VECTOR(ilen-1 DOWNTO 0 );
     VARIABLE lsbi : INTEGER;
     VARIABLE msbi : INTEGER;

   BEGIN
     cat_enables := (others => '0');
     lsbi := 0;
     msbi := byte_width-1;
     inp := (others => '0');
     mask := (others => '0');

     IF index > max_shift OR index < 0 THEN
       RETURN xxx;
     END IF;

     --initialize enables
     for i in 0 TO (enable'LENGTH-1) loop
       enables(i)  := (others => enable(i));
       cat_enables(msbi downto lsbi) := enables(i) ;
       lsbi := msbi+1;
       msbi := msbi+byte_width;
     end loop;


     shift := CONV_UNSIGNED(index, shift'LENGTH);
     inp(ilen-1 DOWNTO 0) := UNSIGNED(dinput);
     mask(ilen-1 DOWNTO 0) := UNSIGNED((STD_LOGIC_VECTOR(ones) AND cat_enables));
     inp := fshl(inp, shift, vlen);
     mask := fshl(mask, shift, vlen);
     vec0 := (vec and (not STD_LOGIC_VECTOR(mask))) or STD_LOGIC_VECTOR(inp);
     RETURN vec0;
   END;


   FUNCTION ceil_log2(size : NATURAL) return NATURAL is
     VARIABLE cnt : NATURAL;
     VARIABLE res : NATURAL;
   begin
     cnt := 1;
     res := 0;
     while (cnt < size) loop
       res := res + 1;
       cnt := 2 * cnt;
     end loop;
     return res;
   END;
   
   FUNCTION bits(size : NATURAL) return NATURAL is
   begin
     return ceil_log2(size);
   END;

   PROCEDURE csa(a, b, c: IN INTEGER; s, cout: OUT STD_LOGIC_VECTOR) IS
   BEGIN
     s    := conv_std_logic_vector(a, s'LENGTH) xor conv_std_logic_vector(b, s'LENGTH) xor conv_std_logic_vector(c, s'LENGTH);
     cout := ( (conv_std_logic_vector(a, cout'LENGTH) and conv_std_logic_vector(b, cout'LENGTH)) or (conv_std_logic_vector(a, cout'LENGTH) and conv_std_logic_vector(c, cout'LENGTH)) or (conv_std_logic_vector(b, cout'LENGTH) and conv_std_logic_vector(c, cout'LENGTH)) );
   END PROCEDURE csa;

   PROCEDURE csha(a, b: IN INTEGER; s, cout: OUT STD_LOGIC_VECTOR) IS
   BEGIN
     s    := conv_std_logic_vector(a, s'LENGTH) xor conv_std_logic_vector(b, s'LENGTH);
     cout := (conv_std_logic_vector(a, cout'LENGTH) and conv_std_logic_vector(b, cout'LENGTH));
   END PROCEDURE csha;

END funcs;

--------> /home/raid7_4/raid1_1/linux/mentor/Catapult/2023.2/Mgc_home/pkgs/hls_pkgs/mgc_comps_src/mgc_comps.vhd 
LIBRARY ieee;

USE ieee.std_logic_1164.all;

PACKAGE mgc_comps IS
 
FUNCTION ifeqsel(arg1, arg2, seleq, selne : INTEGER) RETURN INTEGER;
FUNCTION ceil_log2(size : NATURAL) return NATURAL;
 

COMPONENT mgc_not
  GENERIC (
    width  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width-1 DOWNTO 0);
    z: out std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_and
  GENERIC (
    width  : NATURAL;
    ninps  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width*ninps - 1 DOWNTO 0);
    z: out std_logic_vector(width       - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_nand
  GENERIC (
    width  : NATURAL;
    ninps  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width*ninps - 1 DOWNTO 0);
    z: out std_logic_vector(width       - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_or
  GENERIC (
    width  : NATURAL;
    ninps  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width*ninps - 1 DOWNTO 0);
    z: out std_logic_vector(width       - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_nor
  GENERIC (
    width  : NATURAL;
    ninps  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width*ninps - 1 DOWNTO 0);
    z: out std_logic_vector(width       - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_xor
  GENERIC (
    width  : NATURAL;
    ninps  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width*ninps - 1 DOWNTO 0);
    z: out std_logic_vector(width       - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_xnor
  GENERIC (
    width  : NATURAL;
    ninps  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width*ninps - 1 DOWNTO 0);
    z: out std_logic_vector(width       - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_lut
  GENERIC (
    width  : NATURAL;
    ninps  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width*ninps - 1 DOWNTO 0);
    z: out std_logic_vector(width       - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_switch
  GENERIC (
    widths  : NATURAL;
    ninps  : NATURAL;
    widtha  : NATURAL;
    ninpa  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(widtha*ninpa - 1 DOWNTO 0);
    c: in  std_logic_vector(widths*ninps - 1 DOWNTO 0);
    s: in  std_logic;
    z: out std_logic_vector(widtha       - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mux
  GENERIC (
    width  :  NATURAL;
    ctrlw  :  NATURAL;
    p2ctrlw : NATURAL := 0
  );
  PORT (
    a: in  std_logic_vector(width*(2**ctrlw) - 1 DOWNTO 0);
    c: in  std_logic_vector(ctrlw            - 1 DOWNTO 0);
    z: out std_logic_vector(width            - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mux1hot
  GENERIC (
    width  : NATURAL;
    ctrlw  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width*ctrlw - 1 DOWNTO 0);
    c: in  std_logic_vector(ctrlw       - 1 DOWNTO 0);
    z: out std_logic_vector(width       - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_reg_pos
  GENERIC (
    width  : NATURAL;
    has_a_rst : NATURAL;  -- 0 to 1
    a_rst_on  : NATURAL;  -- 0 to 1
    has_s_rst : NATURAL;  -- 0 to 1
    s_rst_on  : NATURAL;  -- 0 to 1
    has_enable : NATURAL; -- 0 to 1
    enable_on  : NATURAL  -- 0 to 1
  );
  PORT (
    clk: in  std_logic;
    d  : in  std_logic_vector(width-1 DOWNTO 0);
    z  : out std_logic_vector(width-1 DOWNTO 0);
    sync_rst_val : in std_logic_vector(width-1 DOWNTO 0);
    sync_rst : in std_logic;
    async_rst_val : in std_logic_vector(width-1 DOWNTO 0);
    async_rst : in std_logic;
    en : in std_logic
  );
END COMPONENT;

COMPONENT mgc_reg_neg
  GENERIC (
    width  : NATURAL;
    has_a_rst : NATURAL;  -- 0 to 1
    a_rst_on  : NATURAL;  -- 0 to 1
    has_s_rst : NATURAL;  -- 0 to 1
    s_rst_on  : NATURAL;   -- 0 to 1
    has_enable : NATURAL; -- 0 to 1
    enable_on  : NATURAL -- 0 to 1
  );
  PORT (
    clk: in  std_logic;
    d  : in  std_logic_vector(width-1 DOWNTO 0);
    z  : out std_logic_vector(width-1 DOWNTO 0);
    sync_rst_val : in std_logic_vector(width-1 DOWNTO 0);
    sync_rst : in std_logic;
    async_rst_val : in std_logic_vector(width-1 DOWNTO 0);
    async_rst : in std_logic;
    en : in std_logic
  );
END COMPONENT;

COMPONENT mgc_generic_reg
  GENERIC(
   width: natural := 8;
   ph_clk: integer range 0 to 1 := 1; -- clock polarity, 1=rising_edge
   ph_en: integer range 0 to 1 := 1;
   ph_a_rst: integer range 0 to 1 := 1;   --  0 to 1 IGNORED
   ph_s_rst: integer range 0 to 1 := 1;   --  0 to 1 IGNORED
   a_rst_used: integer range 0 to 1 := 1;
   s_rst_used: integer range 0 to 1 := 0;
   en_used: integer range 0 to 1 := 1
  );
  PORT(
   d: std_logic_vector(width-1 downto 0);
   clk: in std_logic;
   en: in std_logic;
   a_rst: in std_logic;
   s_rst: in std_logic;
   q: out std_logic_vector(width-1 downto 0)
  );
END COMPONENT;

COMPONENT mgc_equal
  GENERIC (
    width  : NATURAL
  );
  PORT (
    a : in  std_logic_vector(width-1 DOWNTO 0);
    b : in  std_logic_vector(width-1 DOWNTO 0);
    eq: out std_logic;
    ne: out std_logic
  );
END COMPONENT;

COMPONENT mgc_shift_l
  GENERIC (
    width_a: NATURAL;
    signd_a: NATURAL;
    width_s: NATURAL;
    width_z: NATURAL
  );
  PORT (
    a : in  std_logic_vector(width_a-1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_shift_r
  GENERIC (
    width_a: NATURAL;
    signd_a: NATURAL;
    width_s: NATURAL;
    width_z: NATURAL
  );
  PORT (
    a : in  std_logic_vector(width_a-1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_shift_bl
  GENERIC (
    width_a: NATURAL;
    signd_a: NATURAL;
    width_s: NATURAL;
    width_z: NATURAL
  );
  PORT (
    a : in  std_logic_vector(width_a-1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_shift_br
  GENERIC (
    width_a: NATURAL;
    signd_a: NATURAL;
    width_s: NATURAL;
    width_z: NATURAL
  );
  PORT (
    a : in  std_logic_vector(width_a-1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_rot
  GENERIC (
    width  : NATURAL;
    width_s: NATURAL;
    signd_s: NATURAL;      -- 0:unsigned 1:signed
    sleft  : NATURAL;      -- 0:right 1:left;
    log2w  : NATURAL := 0; -- LOG2(width)
    l2wp2  : NATURAL := 0  --2**LOG2(width)
  );
  PORT (
    a : in  std_logic_vector(width  -1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width  -1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_add
  GENERIC (
    width   : NATURAL; 
    signd_a : NATURAL := 0;
    width_b : NATURAL := 0; -- if == 0 use width, compatiability with versions < 2005a
    signd_b : NATURAL := 0;
    width_z : NATURAL := 0  -- if == 0 use width, compatiability with versions < 2005a
  );
  PORT (
    a: in  std_logic_vector(width-1 DOWNTO 0);
    b: in  std_logic_vector(ifeqsel(width_b,0,width,width_b)-1 DOWNTO 0);
    z: out std_logic_vector(ifeqsel(width_z,0,width,width_z)-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_sub
  GENERIC (
    width   : NATURAL; 
    signd_a : NATURAL := 0;
    width_b : NATURAL := 0; -- if == 0 use width, compatiability with versions < 2005a
    signd_b : NATURAL := 0;
    width_z : NATURAL := 0  -- if == 0 use width, compatiability with versions < 2005a
  );
  PORT (
    a: in  std_logic_vector(width-1 DOWNTO 0);
    b: in  std_logic_vector(ifeqsel(width_b,0,width,width_b)-1 DOWNTO 0);
    z: out std_logic_vector(ifeqsel(width_z,0,width,width_z)-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_add_ci
  GENERIC (
    width_a : NATURAL; 
    signd_a : NATURAL := 0;
    width_b : NATURAL := 0; -- if == 0 use width_a, compatiability with versions < 2005a
    signd_b : NATURAL := 0;
    width_z : NATURAL := 0  -- if == 0 use width_a, compatiability with versions < 2005a
  );
  PORT (
    a: in  std_logic_vector(width_a-1 DOWNTO 0);
    b: in  std_logic_vector(ifeqsel(width_b,0,width_a,width_b)-1 DOWNTO 0);
    c: in  std_logic_vector(0 DOWNTO 0);
    z: out std_logic_vector(ifeqsel(width_z,0,width_a,width_z)-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_addc
  GENERIC (
    width   : NATURAL; 
    signd_a : NATURAL := 0;
    width_b : NATURAL := 0; -- if == 0 use width, compatiability with versions < 2005a
    signd_b : NATURAL := 0;
    width_z : NATURAL := 0  -- if == 0 use width, compatiability with versions < 2005a
  );
  PORT (
    a: in  std_logic_vector(width-1 DOWNTO 0);
    b: in  std_logic_vector(ifeqsel(width_b,0,width,width_b)-1 DOWNTO 0);
    c: in  std_logic_vector(0 DOWNTO 0);
    z: out std_logic_vector(ifeqsel(width_z,0,width,width_z)-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_add_msb
  GENERIC (
    width   : NATURAL; 
    signd_a : NATURAL := 0;
    width_b : NATURAL := 0; -- if == 0 use width, compatiability with versions < 2005a
    signd_b : NATURAL := 0;
    width_z : NATURAL := 0  -- if == 0 use width, compatiability with versions < 2005a
  );
  PORT (
    a: in  std_logic_vector(width-1 DOWNTO 0);
    b: in  std_logic_vector(ifeqsel(width_b,0,width,width_b)-1 DOWNTO 0);
    c: in  std_logic_vector(0 DOWNTO 0);
    z: out std_logic_vector(ifeqsel(width_z,0,width,width_z)-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_add3
  GENERIC (
    width   : NATURAL; 
    signd_a : NATURAL := 0;
    width_b : NATURAL := 0; -- if == 0 use width, compatiability with versions < 2005a
    signd_b : NATURAL := 0;
    width_c : NATURAL := 0; -- if == 0 use width, compatiability with versions < 2005a
    signd_c : NATURAL := 0;
    width_z : NATURAL := 0  -- if == 0 use width, compatiability with versions < 2005a
  );
  PORT (
    a: in  std_logic_vector(width-1 DOWNTO 0);
    b: in  std_logic_vector(ifeqsel(width_b,0,width,width_b)-1 DOWNTO 0);
    c: in  std_logic_vector(ifeqsel(width_c,0,width,width_c)-1 DOWNTO 0);
    d: in  std_logic_vector(0 DOWNTO 0);
    e: in  std_logic_vector(0 DOWNTO 0);
    z: out std_logic_vector(ifeqsel(width_z,0,width,width_z)-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_lt
  GENERIC (
    width_a : NATURAL; 
    signd_a : NATURAL := 0;
    width_b : NATURAL := 0; -- if == 0 use width, compatiability with versions < 2005a
    signd_b : NATURAL := 0
  );
  PORT (
    a: in  std_logic_vector(width_a-1 DOWNTO 0);
    b: in  std_logic_vector(width_b-1 DOWNTO 0);
    z: out std_logic
  );
END COMPONENT;

COMPONENT mgc_add_pipe
  GENERIC (
     width_a : natural := 16;
     signd_a : integer range 0 to 1 := 0;
     width_b : natural := 3;
     signd_b : integer range 0 to 1 := 0;
     width_z : natural := 18;
     ph_clk : integer range 0 to 1 := 1;
     ph_en : integer range 0 to 1 := 1;
     ph_a_rst : integer range 0 to 1 := 1;
     ph_s_rst : integer range 0 to 1 := 1;
     n_outreg : natural := 2;
     stages : natural := 2; -- Default value is minimum required value
     a_rst_used: integer range 0 to 1 := 1;
     s_rst_used: integer range 0 to 1 := 0;
     en_used: integer range 0 to 1 := 1
     );
  PORT(
     a: in std_logic_vector(width_a-1 downto 0);
     b: in std_logic_vector(width_b-1 downto 0);
     clk: in std_logic;
     en: in std_logic;
     a_rst: in std_logic;
     s_rst: in std_logic;
     z: out std_logic_vector(width_z-1 downto 0)
     );
END COMPONENT;

COMPONENT mgc_sub_pipe
  GENERIC (
     width_a : natural := 16;
     signd_a : integer range 0 to 1 := 0;
     width_b : natural := 3;
     signd_b : integer range 0 to 1 := 0;
     width_z : natural := 18;
     ph_clk : integer range 0 to 1 := 1;
     ph_en : integer range 0 to 1 := 1;
     ph_a_rst : integer range 0 to 1 := 1;
     ph_s_rst : integer range 0 to 1 := 1;
     n_outreg : natural := 2;
     stages : natural := 2; -- Default value is minimum required value
     a_rst_used: integer range 0 to 1 := 1;
     s_rst_used: integer range 0 to 1 := 0;
     en_used: integer range 0 to 1 := 1
     );
  PORT(
     a: in std_logic_vector(width_a-1 downto 0);
     b: in std_logic_vector(width_b-1 downto 0);
     clk: in std_logic;
     en: in std_logic;
     a_rst: in std_logic;
     s_rst: in std_logic;
     z: out std_logic_vector(width_z-1 downto 0)
     );
END COMPONENT;

COMPONENT mgc_addc_pipe
  GENERIC (
     width_a : natural := 16;
     signd_a : integer range 0 to 1 := 0;
     width_b : natural := 3;
     signd_b : integer range 0 to 1 := 0;
     width_z : natural := 18;
     ph_clk : integer range 0 to 1 := 1;
     ph_en : integer range 0 to 1 := 1;
     ph_a_rst : integer range 0 to 1 := 1;
     ph_s_rst : integer range 0 to 1 := 1;
     n_outreg : natural := 2;
     stages : natural := 2; -- Default value is minimum required value
     a_rst_used: integer range 0 to 1 := 1;
     s_rst_used: integer range 0 to 1 := 0;
     en_used: integer range 0 to 1 := 1
     );
  PORT(
     a: in std_logic_vector(width_a-1 downto 0);
     b: in std_logic_vector(width_b-1 downto 0);
     c: in std_logic_vector(0 downto 0);
     clk: in std_logic;
     en: in std_logic;
     a_rst: in std_logic;
     s_rst: in std_logic;
     z: out std_logic_vector(width_z-1 downto 0)
     );
END COMPONENT;

COMPONENT mgc_addsub
  GENERIC (
    width   : NATURAL; 
    signd_a : NATURAL := 0;
    width_b : NATURAL := 0; -- if == 0 use width, compatiability with versions < 2005a
    signd_b : NATURAL := 0;
    width_z : NATURAL := 0  -- if == 0 use width, compatiability with versions < 2005a
  );
  PORT (
    a: in  std_logic_vector(width-1 DOWNTO 0);
    b: in  std_logic_vector(ifeqsel(width_b,0,width,width_b)-1 DOWNTO 0);
    add: in  std_logic;
    z: out std_logic_vector(ifeqsel(width_z,0,width,width_z)-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_accu
  GENERIC (
    width  : NATURAL;
    ninps  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width*ninps-1 DOWNTO 0);
    z: out std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_abs
  GENERIC (
    width  : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width-1 DOWNTO 0);
    z: out std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_sqr
  GENERIC (
    width_a : NATURAL;
    signd_a : NATURAL;
    width_z : NATURAL    -- <= 2 * width_a
  );
  PORT (
    a: in  std_logic_vector(width_a-1 DOWNTO 0);
    z: out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mul
  GENERIC (
    width_a : NATURAL;
    signd_a : NATURAL;
    width_b : NATURAL;
    signd_b : NATURAL;
    width_z : NATURAL    -- <= width_a + width_b
  );
  PORT (
    a: in  std_logic_vector(width_a-1 DOWNTO 0);
    b: in  std_logic_vector(width_b-1 DOWNTO 0);
    z: out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mul_fast
  GENERIC (
    width_a : NATURAL;
    signd_a : NATURAL;
    width_b : NATURAL;
    signd_b : NATURAL;
    width_z : NATURAL    -- <= width_a + width_b
  );
  PORT (
    a: in  std_logic_vector(width_a-1 DOWNTO 0);
    b: in  std_logic_vector(width_b-1 DOWNTO 0);
    z: out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mul_pipe
  GENERIC (
    width_a       : NATURAL;
    signd_a       : NATURAL;
    width_b       : NATURAL;
    signd_b       : NATURAL;
    width_z       : NATURAL; -- <= width_a + width_b
    clock_edge    : NATURAL; -- 0 to 1
    enable_active : NATURAL; -- 0 to 1
    a_rst_active  : NATURAL; -- 0 to 1 
    s_rst_active  : NATURAL; -- 0 to 1 
    stages        : NATURAL;    
    n_inreg       : NATURAL := 0 -- default for backwards compatability 

  );
  PORT (
    a     : in  std_logic_vector(width_a-1 DOWNTO 0);
    b     : in  std_logic_vector(width_b-1 DOWNTO 0);
    clk   : in  std_logic;
    en    : in  std_logic;
    a_rst : in  std_logic; --spyglass disable SYNTH_5121,W240
    s_rst : in  std_logic; --spyglass disable SYNTH_5121,W240
    z     : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mul2add1
  GENERIC (
    gentype : NATURAL;
    width_a : NATURAL;
    signd_a : NATURAL;
    width_b : NATURAL;
    signd_b : NATURAL;
    width_b2 : NATURAL;
    signd_b2 : NATURAL;
    width_c : NATURAL;
    signd_c : NATURAL;
    width_d : NATURAL;
    signd_d : NATURAL;
    width_d2 : NATURAL;
    signd_d2 : NATURAL;
    width_e : NATURAL;
    signd_e : NATURAL;
    width_z : NATURAL;   -- <= max(width_a + width_b, width_c + width_d)+1
    isadd   : NATURAL;
    add_b2  : NATURAL;
    add_d2  : NATURAL;
    use_const  : NATURAL
  );
  PORT (
    a   : in  std_logic_vector(width_a-1 DOWNTO 0);
    b   : in  std_logic_vector(width_b-1 DOWNTO 0);
    b2  : in  std_logic_vector(width_b2-1 DOWNTO 0); --spyglass disable SYNTH_5121,W240
    c   : in  std_logic_vector(width_c-1 DOWNTO 0);
    d   : in  std_logic_vector(width_d-1 DOWNTO 0);
    d2  : in  std_logic_vector(width_d2-1 DOWNTO 0); --spyglass disable SYNTH_5121,W240
    cst : in  std_logic_vector(width_e-1 DOWNTO 0); --spyglass disable SYNTH_5121,W240
    z   : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mul2add1_pipe
  GENERIC (
    gentype : NATURAL;
    width_a : NATURAL;
    signd_a : NATURAL;
    width_b : NATURAL;
    signd_b : NATURAL;
    width_b2 : NATURAL;
    signd_b2 : NATURAL;
    width_c : NATURAL;
    signd_c : NATURAL;
    width_d : NATURAL;
    signd_d : NATURAL;
    width_d2 : NATURAL;
    signd_d2 : NATURAL;
    width_e : NATURAL;
    signd_e : NATURAL;
    width_z : NATURAL;    -- <= max(width_a + width_b, width_c + width_d)+1
    isadd   : NATURAL;
    add_b2   : NATURAL;
    add_d2   : NATURAL;
    use_const : NATURAL;
    clock_edge    : NATURAL; -- 0 to 1
    enable_active : NATURAL; -- 0 to 1
    a_rst_active  : NATURAL; -- 0 to 1 IGNORED
    s_rst_active  : NATURAL; -- 0 to 1 IGNORED
    stages        : NATURAL;    
    n_inreg       : NATURAL := 0 -- default for backwards compatability 
  );
  PORT (
    a     : in  std_logic_vector(width_a-1 DOWNTO 0);
    b     : in  std_logic_vector(width_b-1 DOWNTO 0);
    b2     : in  std_logic_vector(width_b2-1 DOWNTO 0);--spyglass disable SYNTH_5121,W240
    c     : in  std_logic_vector(width_c-1 DOWNTO 0);
    d     : in  std_logic_vector(width_d-1 DOWNTO 0);
    d2     : in  std_logic_vector(width_d2-1 DOWNTO 0);--spyglass disable SYNTH_5121,W240
    cst   : in  std_logic_vector(width_e-1 DOWNTO 0);--spyglass disable SYNTH_5121,W240
    clk   : in  std_logic;
    en    : in  std_logic;
    a_rst : in  std_logic;--spyglass disable SYNTH_5121,W240
    s_rst : in  std_logic;--spyglass disable SYNTH_5121,W240
    z     : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mul4add1
  GENERIC (
    gentype : NATURAL;
    width_a1 : NATURAL;
    signd_a1 : NATURAL;
    width_a2 : NATURAL;
    signd_a2 : NATURAL;
    width_b1 : NATURAL;
    signd_b1 : NATURAL;
    width_b2 : NATURAL;
    signd_b2 : NATURAL;
    width_c1 : NATURAL;
    signd_c1 : NATURAL;
    width_c2 : NATURAL;
    signd_c2 : NATURAL;
    width_d1 : NATURAL;
    signd_d1 : NATURAL;
    width_d2 : NATURAL;
    signd_d2 : NATURAL;
    width_c : NATURAL;
    signd_c : NATURAL;
    width_z : NATURAL;   -- <= max(width_a + width_b, width_c + width_d)+1
    add_a : NATURAL;
    add_b : NATURAL;
    add_c : NATURAL;
    use_const : NATURAL
  );
  PORT (
    a1  : in  std_logic_vector(width_a1-1 DOWNTO 0);
    a2  : in  std_logic_vector(width_a2-1 DOWNTO 0);
    b1  : in  std_logic_vector(width_b1-1 DOWNTO 0);
    b2  : in  std_logic_vector(width_b2-1 DOWNTO 0);
    c1  : in  std_logic_vector(width_c1-1 DOWNTO 0);
    c2  : in  std_logic_vector(width_c2-1 DOWNTO 0);
    d1  : in  std_logic_vector(width_d1-1 DOWNTO 0);--spyglass disable SYNTH_5121,W240
    d2  : in  std_logic_vector(width_d2-1 DOWNTO 0);--spyglass disable SYNTH_5121,W240
    c  : in  std_logic_vector(width_c-1 DOWNTO 0); --spyglass disable SYNTH_5121,W240
    z   : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mul4add1_pipe
  GENERIC (
    gentype : NATURAL;
    width_a1 : NATURAL;
    signd_a1 : NATURAL;
    width_a2 : NATURAL;
    signd_a2 : NATURAL;
    width_b1 : NATURAL;
    signd_b1 : NATURAL;
    width_b2 : NATURAL;
    signd_b2 : NATURAL;
    width_c1 : NATURAL;
    signd_c1 : NATURAL;
    width_c2 : NATURAL;
    signd_c2 : NATURAL;
    width_d1 : NATURAL;
    signd_d1 : NATURAL;
    width_d2 : NATURAL;
    signd_d2 : NATURAL;
    width_c  : NATURAL;
    signd_c  : NATURAL;
    width_z : NATURAL;    -- <= max(width_a + width_b, width_c + width_d)+1
    add_a : NATURAL;
    add_b : NATURAL;
    add_c : NATURAL;
    use_const : NATURAL;
    clock_edge    : NATURAL; -- 0 to 1
    enable_active : NATURAL; -- 0 to 1
    a_rst_active  : NATURAL; -- 0 to 1 IGNORED
    s_rst_active  : NATURAL; -- 0 to 1 IGNORED
    stages        : NATURAL;    
    n_inreg       : NATURAL := 0 -- default for backwards compatability 
  );
  PORT (
    a1  : in  std_logic_vector(width_a1-1 DOWNTO 0);
    a2  : in  std_logic_vector(width_a2-1 DOWNTO 0);
    b1  : in  std_logic_vector(width_b1-1 DOWNTO 0);
    b2  : in  std_logic_vector(width_b2-1 DOWNTO 0);
    c1  : in  std_logic_vector(width_c1-1 DOWNTO 0);
    c2  : in  std_logic_vector(width_c2-1 DOWNTO 0);
    d1  : in  std_logic_vector(width_d1-1 DOWNTO 0);--spyglass disable SYNTH_5121,W240
    d2  : in  std_logic_vector(width_d2-1 DOWNTO 0);--spyglass disable SYNTH_5121,W240
    c   : in  std_logic_vector(width_c-1 DOWNTO 0); --spyglass disable SYNTH_5121,W240
    clk   : in  std_logic;
    en    : in  std_logic;
    a_rst : in  std_logic; --spyglass disable SYNTH_5121,W240
    s_rst : in  std_logic; --spyglass disable SYNTH_5121,W240
    z     : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_muladd1
  -- operation is z = a * (b + d) + c + cst
  GENERIC (
    width_a : NATURAL;
    signd_a : NATURAL;
    width_b : NATURAL;
    signd_b : NATURAL;
    width_c : NATURAL;
    signd_c : NATURAL;
    width_cst : NATURAL;
    signd_cst : NATURAL;
    width_d : NATURAL;
    signd_d : NATURAL;
    width_z : NATURAL;    -- <= max(width_a + width_b, width_c, width_cst)+1
    add_axb : NATURAL;
    add_c   : NATURAL;
    add_d   : NATURAL;
    use_const : NATURAL
  );
  PORT (
    a:   in  std_logic_vector(width_a-1 DOWNTO 0);
    b:   in  std_logic_vector(width_b-1 DOWNTO 0);
    c:   in  std_logic_vector(width_c-1 DOWNTO 0);
    cst: in  std_logic_vector(width_cst-1 DOWNTO 0); --spyglass disable SYNTH_5121,W240
    d:   in  std_logic_vector(width_d-1 DOWNTO 0); --spyglass disable SYNTH_5121,W240
    z:   out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_muladd1_pipe
  -- operation is z = a * (b + d) + c + cst
  GENERIC (
    gentype : NATURAL;
    width_a : NATURAL;
    signd_a : NATURAL;
    width_b : NATURAL;
    signd_b : NATURAL;
    width_c : NATURAL;
    signd_c : NATURAL;
    width_cst : NATURAL;
    signd_cst : NATURAL;
    width_d : NATURAL;
    signd_d : NATURAL;
    width_z : NATURAL;    -- <= max(width_a + width_b, width_c, width_cst)+1
    add_axb : NATURAL;
    add_c   : NATURAL;
    add_d   : NATURAL;
    use_const : NATURAL;
    clock_edge    : NATURAL; -- 0 to 1
    enable_active : NATURAL; -- 0 to 1
    a_rst_active  : NATURAL; -- 0 to 1 IGNORED
    s_rst_active  : NATURAL; -- 0 to 1 IGNORED
    stages        : NATURAL;    
    n_inreg       : NATURAL := 0 -- default for backwards compatability 
  );
  PORT (
    a     : in  std_logic_vector(width_a-1 DOWNTO 0);
    b     : in  std_logic_vector(width_b-1 DOWNTO 0);
    c     : in  std_logic_vector(width_c-1 DOWNTO 0);
    cst   : in  std_logic_vector(width_cst-1 DOWNTO 0); --spyglass disable SYNTH_5121,W240
    d     : in  std_logic_vector(width_d-1 DOWNTO 0); --spyglass disable SYNTH_5121,W240
    clk   : in  std_logic;
    en    : in  std_logic;
    a_rst : in  std_logic; --spyglass disable SYNTH_5121,W240
    s_rst : in  std_logic; --spyglass disable SYNTH_5121,W240
    z     : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_cplxmul
  GENERIC (
    width_ar : NATURAL;
    signd_ar : NATURAL;
    width_ai : NATURAL;
    signd_ai : NATURAL;
    width_br : NATURAL;
    signd_br : NATURAL;
    width_bi : NATURAL;
    signd_bi : NATURAL;
    width_zr : NATURAL;   -- <= max(width_a + width_b, width_c + width_d)+1
    width_zi : NATURAL;   -- <= max(width_a + width_b, width_c + width_d)+1
    add_rr   : NATURAL;
    add_ri   : NATURAL;
    add_ir   : NATURAL;
    add_ii   : NATURAL;
    gentype  : NATURAL
  );
  PORT (
    ar  : in  std_logic_vector(width_ar-1 DOWNTO 0);
    ai  : in  std_logic_vector(width_ai-1 DOWNTO 0);
    br  : in  std_logic_vector(width_br-1 DOWNTO 0);
    bi  : in  std_logic_vector(width_bi-1 DOWNTO 0);
    zr  : out std_logic_vector(width_zr-1 DOWNTO 0);
    zi  : out std_logic_vector(width_zi-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_cplxmul_pipe
  GENERIC (
    width_ar : NATURAL;
    signd_ar : NATURAL;
    width_ai : NATURAL;
    signd_ai : NATURAL;
    width_br : NATURAL;
    signd_br : NATURAL;
    width_bi : NATURAL;
    signd_bi : NATURAL;
    width_zr : NATURAL;   -- <= max(width_a + width_b, width_c + width_d)+1
    width_zi : NATURAL;   -- <= max(width_a + width_b, width_c + width_d)+1
    add_rr   : NATURAL;
    add_ri   : NATURAL;
    add_ir   : NATURAL;
    add_ii   : NATURAL;
    gentype  : NATURAL;
    clock_edge    : NATURAL; -- 0 to 1
    enable_active : NATURAL; -- 0 to 1
    a_rst_active  : NATURAL; -- 0 to 1 --spyglass disable SYNTH_5121,W240
    s_rst_active  : NATURAL; -- 0 to 1 --spyglass disable SYNTH_5121,W240
    stages        : NATURAL;    
    n_inreg       : NATURAL := 0 -- default for backwards compatability 
  );
  PORT (
    ar  : in  std_logic_vector(width_ar-1 DOWNTO 0);
    ai  : in  std_logic_vector(width_ai-1 DOWNTO 0);
    br  : in  std_logic_vector(width_br-1 DOWNTO 0);
    bi  : in  std_logic_vector(width_bi-1 DOWNTO 0);
    clk   : in  std_logic;
    en    : in  std_logic;
    a_rst : in  std_logic;
    s_rst : in  std_logic;
    zr  : out std_logic_vector(width_zr-1 DOWNTO 0);
    zi  : out std_logic_vector(width_zi-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mulacc_pipe
  GENERIC (
    width_a : NATURAL;
    signd_a : NATURAL;
    width_b : NATURAL;
    signd_b : NATURAL;
    width_c : NATURAL;
    signd_c : NATURAL;
    width_d : NATURAL;
    signd_d : NATURAL;
    width_z : NATURAL;    -- <= max(width_a + width_b, width_c)+1
    add_d   : NATURAL;
    is_square: NATURAL;
    clock_edge    : NATURAL; -- 0 to 1
    enable_active : NATURAL; -- 0 to 1
    a_rst_active  : NATURAL; -- 0 to 1 IGNORED
    s_rst_active  : NATURAL; -- 0 to 1 IGNORED
    stages        : NATURAL;    
    n_inreg       : NATURAL := 0 -- default for backwards compatability 
  );
  PORT (
    a         : in  std_logic_vector(width_a-1 DOWNTO 0);
    b         : in  std_logic_vector(width_b-1 DOWNTO 0);
    c         : in  std_logic_vector(width_c-1 DOWNTO 0);
    d         : in  std_logic_vector(width_d-1 DOWNTO 0); --spyglass disable SYNTH_5121,W240 
    load      : in  std_logic;
    datavalid : in  std_logic;
    clk       : in  std_logic;
    en        : in  std_logic;
    a_rst     : in  std_logic; --spyglass disable SYNTH_5121,W240 
    s_rst     : in  std_logic; --spyglass disable SYNTH_5121,W240
    z         : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mul2acc_pipe
  GENERIC (
    width_a : NATURAL;
    signd_a : NATURAL;
    width_b : NATURAL;
    signd_b : NATURAL;
    width_b2: NATURAL;
    signd_b2: NATURAL;
    width_c : NATURAL;
    signd_c : NATURAL;
    width_d : NATURAL;
    signd_d : NATURAL;
    width_d2: NATURAL;
    signd_d2: NATURAL;
    width_e : NATURAL;
    signd_e : NATURAL;
    width_z : NATURAL;    -- <= max(width_a + width_b, width_c)+1
    add_cxd : NATURAL;
    add_b2  : NATURAL;
    add_d2  : NATURAL;
    square_b: NATURAL;
    square_d: NATURAL;
    clock_edge    : NATURAL; -- 0 to 1
    enable_active : NATURAL; -- 0 to 1
    a_rst_active  : NATURAL; -- 0 to 1 IGNORED
    s_rst_active  : NATURAL; -- 0 to 1 IGNORED
    stages        : NATURAL;    
    n_inreg       : NATURAL := 0 -- default for backwards compatability 
  );
  PORT (
    a         : in  std_logic_vector(width_a-1 DOWNTO 0);
    b         : in  std_logic_vector(width_b-1 DOWNTO 0);
    b2        : in  std_logic_vector(width_b2-1 DOWNTO 0);--spyglass disable SYNTH_5121,W240
    c         : in  std_logic_vector(width_c-1 DOWNTO 0);
    d         : in  std_logic_vector(width_d-1 DOWNTO 0);
    d2        : in  std_logic_vector(width_d2-1 DOWNTO 0);--spyglass disable SYNTH_5121,W240
    e         : in  std_logic_vector(width_e-1 DOWNTO 0);--spyglass disable SYNTH_5121,W240
    load      : in  std_logic;
    datavalid : in  std_logic;
    clk       : in  std_logic;
    en        : in  std_logic;
    a_rst     : in  std_logic;--spyglass disable SYNTH_5121,W240
    s_rst     : in  std_logic;--spyglass disable SYNTH_5121,W240
    z         : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mul4acc_pipe
  GENERIC (
    width_a0 : NATURAL;
    signd_a0 : NATURAL;
    width_a1 : NATURAL;
    signd_a1 : NATURAL;
    width_b0 : NATURAL;
    signd_b0 : NATURAL;
    width_b1 : NATURAL;
    signd_b1 : NATURAL;
    width_c0 : NATURAL;
    signd_c0 : NATURAL;
    width_c1 : NATURAL;
    signd_c1 : NATURAL;
    width_d0 : NATURAL;
    signd_d0 : NATURAL;
    width_d1 : NATURAL;
    signd_d1 : NATURAL;
    width_e : NATURAL;
    signd_e : NATURAL;
    width_z : NATURAL;    -- <= max(width_a + width_b, width_c)+1
    add_a : NATURAL;
    add_b : NATURAL;
    add_c : NATURAL;
    min_fb_size : NATURAL;
    clock_edge    : NATURAL; -- 0 to 1
    enable_active : NATURAL; -- 0 to 1
    a_rst_active  : NATURAL; -- 0 to 1 IGNORED
    s_rst_active  : NATURAL; -- 0 to 1 IGNORED
    stages        : NATURAL;    
    n_inreg       : NATURAL := 0 -- default for backwards compatability 
  );
  PORT (
    a0         : in  std_logic_vector(width_a0-1 DOWNTO 0);
    a1         : in  std_logic_vector(width_a1-1 DOWNTO 0);
    b0         : in  std_logic_vector(width_b0-1 DOWNTO 0);
    b1         : in  std_logic_vector(width_b1-1 DOWNTO 0);
    c0         : in  std_logic_vector(width_c0-1 DOWNTO 0);
    c1         : in  std_logic_vector(width_c1-1 DOWNTO 0);
    d0         : in  std_logic_vector(width_d0-1 DOWNTO 0); --spyglass disable SYNTH_5121,W240
    d1         : in  std_logic_vector(width_d1-1 DOWNTO 0); --spyglass disable SYNTH_5121,W240
    e         : in  std_logic_vector(width_e-1 DOWNTO 0);   --spyglass disable SYNTH_5121,W240
    load      : in  std_logic;
    datavalid : in  std_logic;
    clk       : in  std_logic;
    en        : in  std_logic;
    a_rst     : in  std_logic; --spyglass disable SYNTH_5121,W240
    s_rst     : in  std_logic; --spyglass disable SYNTH_5121,W240
    z         : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_div
  GENERIC (
    width_a : NATURAL;
    width_b : NATURAL;
    signd   : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width_a-1 DOWNTO 0);
    b: in  std_logic_vector(width_b-1 DOWNTO 0);
    z: out std_logic_vector(width_a-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_mod
  GENERIC (
    width_a : NATURAL;
    width_b : NATURAL;
    signd   : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width_a-1 DOWNTO 0);
    b: in  std_logic_vector(width_b-1 DOWNTO 0);
    z: out std_logic_vector(width_b-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_rem
  GENERIC (
    width_a : NATURAL;
    width_b : NATURAL;
    signd   : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width_a-1 DOWNTO 0);
    b: in  std_logic_vector(width_b-1 DOWNTO 0);
    z: out std_logic_vector(width_b-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_csa
  GENERIC (
     width : NATURAL
  );
  PORT (
     a: in std_logic_vector(width-1 downto 0);
     b: in std_logic_vector(width-1 downto 0);
     c: in std_logic_vector(width-1 downto 0);
     s: out std_logic_vector(width-1 downto 0);
     cout: out std_logic_vector(width-1 downto 0)
  );
END COMPONENT;

COMPONENT mgc_csha
  GENERIC (
     width : NATURAL
  );
  PORT (
     a: in std_logic_vector(width-1 downto 0);
     b: in std_logic_vector(width-1 downto 0);
     s: out std_logic_vector(width-1 downto 0);
     cout: out std_logic_vector(width-1 downto 0)
  );
END COMPONENT;

COMPONENT mgc_rom
    GENERIC (
      rom_id : natural := 1;
      size : natural := 33;
      width : natural := 32
      );
    PORT (
      data_in : std_logic_vector((size*width)-1 downto 0);
      addr : std_logic_vector(ceil_log2(size)-1 downto 0);
      data_out : out std_logic_vector(width-1 downto 0)
    );
END COMPONENT;

END mgc_comps;

PACKAGE BODY mgc_comps IS
 
   FUNCTION ceil_log2(size : NATURAL) return NATURAL is
     VARIABLE cnt : NATURAL;
     VARIABLE res : NATURAL;
   begin
     cnt := 1;
     res := 0;
     while (cnt < size) loop
       res := res + 1;
       cnt := 2 * cnt;
     end loop;
     return res;
   END;

   FUNCTION ifeqsel(arg1, arg2, seleq, selne : INTEGER) RETURN INTEGER IS
   BEGIN
     IF(arg1 = arg2) THEN
       RETURN(seleq) ;
     ELSE
       RETURN(selne) ;
     END IF;
   END;
 
END mgc_comps;

--------> /home/raid7_4/raid1_1/linux/mentor/Catapult/2023.2/Mgc_home/pkgs/hls_pkgs/mgc_comps_src/mgc_div_beh.vhd 

LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY mgc_div IS
  GENERIC (
    width_a : NATURAL;
    width_b : NATURAL;
    signd   : NATURAL
  );
  PORT (
    a: in  std_logic_vector(width_a-1 DOWNTO 0);
    b: in  std_logic_vector(width_b-1 DOWNTO 0);
    z: out std_logic_vector(width_a-1 DOWNTO 0)
  );
END mgc_div;

LIBRARY ieee;

USE ieee.std_logic_arith.all;

USE work.funcs.all;

ARCHITECTURE beh OF mgc_div IS
BEGIN
  z <= std_logic_vector(unsigned(a) / unsigned(b)) WHEN signd = 0 ELSE
       std_logic_vector(  signed(a) /   signed(b));
END beh;

--------> /home/raid7_4/raid1_1/linux/mentor/Catapult/2023.2/Mgc_home/pkgs/siflibs/mgc_shift_comps_v5.vhd 
LIBRARY ieee;

USE ieee.std_logic_1164.all;

PACKAGE mgc_shift_comps_v5 IS

COMPONENT mgc_shift_l_v5
  GENERIC (
    width_a: NATURAL;
    signd_a: NATURAL;
    width_s: NATURAL;
    width_z: NATURAL
  );
  PORT (
    a : in  std_logic_vector(width_a-1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_shift_r_v5
  GENERIC (
    width_a: NATURAL;
    signd_a: NATURAL;
    width_s: NATURAL;
    width_z: NATURAL
  );
  PORT (
    a : in  std_logic_vector(width_a-1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_shift_bl_v5
  GENERIC (
    width_a: NATURAL;
    signd_a: NATURAL;
    width_s: NATURAL;
    width_z: NATURAL
  );
  PORT (
    a : in  std_logic_vector(width_a-1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mgc_shift_br_v5
  GENERIC (
    width_a: NATURAL;
    signd_a: NATURAL;
    width_s: NATURAL;
    width_z: NATURAL
  );
  PORT (
    a : in  std_logic_vector(width_a-1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END COMPONENT;

END mgc_shift_comps_v5;

--------> /home/raid7_4/raid1_1/linux/mentor/Catapult/2023.2/Mgc_home/pkgs/siflibs/mgc_shift_l_beh_v5.vhd 
LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY mgc_shift_l_v5 IS
  GENERIC (
    width_a: NATURAL;
    signd_a: NATURAL;
    width_s: NATURAL;
    width_z: NATURAL
  );
  PORT (
    a : in  std_logic_vector(width_a-1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END mgc_shift_l_v5;

LIBRARY ieee;

USE ieee.std_logic_arith.all;

ARCHITECTURE beh OF mgc_shift_l_v5 IS

  FUNCTION maximum (arg1,arg2: INTEGER) RETURN INTEGER IS
  BEGIN
    IF(arg1 > arg2) THEN
      RETURN(arg1) ;
    ELSE
      RETURN(arg2) ;
    END IF;
  END;

  FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
    CONSTANT ilen: INTEGER := arg1'LENGTH;
    CONSTANT olenM1: INTEGER := olen-1; -- 2.1.6.3
    CONSTANT ilenub: INTEGER := arg1'LENGTH-1;
    CONSTANT len: INTEGER := maximum(ilen, olen);
    VARIABLE result: UNSIGNED(len-1 DOWNTO 0);
  BEGIN
    result := (others => sbit);
    result(ilenub DOWNTO 0) := arg1;
    result := shl(result, arg2);
    RETURN result(olenM1 DOWNTO 0);
  END;

  FUNCTION fshl_stdar(arg1: SIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN SIGNED IS
    CONSTANT ilen: INTEGER := arg1'LENGTH;
    CONSTANT olenM1: INTEGER := olen-1; -- 2.1.6.3
    CONSTANT ilenub: INTEGER := arg1'LENGTH-1;
    CONSTANT len: INTEGER := maximum(ilen, olen);
    VARIABLE result: SIGNED(len-1 DOWNTO 0);
  BEGIN
    result := (others => sbit);
    result(ilenub DOWNTO 0) := arg1;
    result := shl(SIGNED(result), arg2);
    RETURN result(olenM1 DOWNTO 0);
  END;

  FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: UNSIGNED; olen: POSITIVE)
  RETURN UNSIGNED IS
  BEGIN
    RETURN fshl_stdar(arg1, arg2, '0', olen);
  END;

  FUNCTION fshl_stdar(arg1: SIGNED  ; arg2: UNSIGNED; olen: POSITIVE)
  RETURN SIGNED IS
  BEGIN
    RETURN fshl_stdar(arg1, arg2, arg1(arg1'LEFT), olen);
  END;

BEGIN
UNSGNED:  IF signd_a = 0 GENERATE
    z <= std_logic_vector(fshl_stdar(unsigned(a), unsigned(s), width_z));
  END GENERATE;
SGNED:  IF signd_a /= 0 GENERATE
    z <= std_logic_vector(fshl_stdar(  signed(a), unsigned(s), width_z));
  END GENERATE;
END beh;

--------> /home/raid7_4/raid1_1/linux/mentor/Catapult/2023.2/Mgc_home/pkgs/siflibs/mgc_shift_bl_beh_v5.vhd 
LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY mgc_shift_bl_v5 IS
  GENERIC (
    width_a: NATURAL;
    signd_a: NATURAL;
    width_s: NATURAL;
    width_z: NATURAL
  );
  PORT (
    a : in  std_logic_vector(width_a-1 DOWNTO 0);
    s : in  std_logic_vector(width_s-1 DOWNTO 0);
    z : out std_logic_vector(width_z-1 DOWNTO 0)
  );
END mgc_shift_bl_v5;

LIBRARY ieee;

USE ieee.std_logic_arith.all;

ARCHITECTURE beh OF mgc_shift_bl_v5 IS

  FUNCTION resolve_std_logic_vector(input1: STD_LOGIC_VECTOR; input2: STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
    CONSTANT len: INTEGER := input1'LENGTH;
    ALIAS input1a: STD_LOGIC_VECTOR(len-1 DOWNTO 0) IS input1;
    ALIAS input2a: STD_LOGIC_VECTOR(len-1 DOWNTO 0) IS input2;
    VARIABLE result: STD_LOGIC_VECTOR(len-1 DOWNTO 0);
  BEGIN
    result := (others => '0');
    --synopsys translate_off
    FOR i IN len-1 DOWNTO 0 LOOP
      result(i) := resolved(input1a(i) & input2a(i));
    END LOOP;
    --synopsys translate_on
    RETURN result;
  END;

  FUNCTION resolve_unsigned(input1: UNSIGNED; input2: UNSIGNED)
  RETURN UNSIGNED IS
  BEGIN
    RETURN UNSIGNED(resolve_std_logic_vector(STD_LOGIC_VECTOR(input1),
                                             STD_LOGIC_VECTOR(input2)));
  END;

  FUNCTION resolve_signed(input1: SIGNED; input2: SIGNED)
  RETURN SIGNED IS
  BEGIN
    RETURN SIGNED(resolve_std_logic_vector(STD_LOGIC_VECTOR(input1),
                                           STD_LOGIC_VECTOR(input2)));
  END;

  FUNCTION "not"(arg1: UNSIGNED) RETURN UNSIGNED IS
    BEGIN RETURN UNSIGNED(not STD_LOGIC_VECTOR(arg1)); END;

  FUNCTION maximum (arg1,arg2: INTEGER) RETURN INTEGER IS
  BEGIN
    IF(arg1 > arg2) THEN
      RETURN(arg1) ;
    ELSE
      RETURN(arg2) ;
    END IF;
  END;

  FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
    CONSTANT ilen: INTEGER := arg1'LENGTH;
    CONSTANT olenM1: INTEGER := olen-1; -- 2.1.6.3
    CONSTANT ilenub: INTEGER := arg1'LENGTH-1;
    CONSTANT len: INTEGER := maximum(ilen, olen);
    VARIABLE result: UNSIGNED(len-1 DOWNTO 0);
  BEGIN
    result := (others => sbit);
    result(ilenub DOWNTO 0) := arg1;
    result := shl(result, arg2);
    RETURN result(olenM1 DOWNTO 0);
  END;

  FUNCTION fshr_stdar(arg1: UNSIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
    CONSTANT ilen: INTEGER := arg1'LENGTH;
    CONSTANT olenM1: INTEGER := olen-1; -- 2.1.6.3
    CONSTANT ilenub: INTEGER := arg1'LENGTH-1;
    CONSTANT len: INTEGER := maximum(ilen, olen);
    VARIABLE result: UNSIGNED(len-1 DOWNTO 0);
  BEGIN
    result := (others => sbit);
    result(ilenub DOWNTO 0) := arg1;
    result := shr(result, arg2);
    RETURN result(olenM1 DOWNTO 0);
  END;

  FUNCTION fshl_stdar(arg1: SIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN SIGNED IS
    CONSTANT ilen: INTEGER := arg1'LENGTH;
    CONSTANT olenM1: INTEGER := olen-1; -- 2.1.6.3
    CONSTANT ilenub: INTEGER := arg1'LENGTH-1;
    CONSTANT len: INTEGER := maximum(ilen, olen);
    VARIABLE result: SIGNED(len-1 DOWNTO 0);
  BEGIN
    result := (others => sbit);
    result(ilenub DOWNTO 0) := arg1;
    result := shl(SIGNED(result), arg2);
    RETURN result(olenM1 DOWNTO 0);
  END;

  FUNCTION fshr_stdar(arg1: SIGNED; arg2: UNSIGNED; sbit: STD_LOGIC; olen: POSITIVE) RETURN SIGNED IS
    CONSTANT ilen: INTEGER := arg1'LENGTH;
    CONSTANT olenM1: INTEGER := olen-1; -- 2.1.6.3
    CONSTANT ilenub: INTEGER := arg1'LENGTH-1;
    CONSTANT len: INTEGER := maximum(ilen, olen);
    VARIABLE result: SIGNED(len-1 DOWNTO 0);
  BEGIN
    result := (others => sbit);
    result(ilenub DOWNTO 0) := arg1;
    result := shr(result, arg2);
    RETURN result(olenM1 DOWNTO 0);
  END;

 FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN UNSIGNED IS
    CONSTANT arg1l: NATURAL := arg1'LENGTH - 1;
    ALIAS    arg1x: UNSIGNED(arg1l DOWNTO 0) IS arg1;
    CONSTANT arg2l: NATURAL := arg2'LENGTH - 1;
    ALIAS    arg2x: SIGNED(arg2l DOWNTO 0) IS arg2;
    VARIABLE arg1x_pad: UNSIGNED(arg1l+1 DOWNTO 0);
    VARIABLE result: UNSIGNED(olen-1 DOWNTO 0);
  BEGIN
    result := (others=>'0');
    arg1x_pad(arg1l+1) := sbit;
    arg1x_pad(arg1l downto 0) := arg1x;
    IF arg2l = 0 THEN
      RETURN fshr_stdar(arg1x_pad, UNSIGNED(arg2x), sbit, olen);
    -- ELSIF arg1l = 0 THEN
    --   RETURN fshl(sbit & arg1x, arg2x, sbit, olen);
    ELSE
      CASE arg2x(arg2l) IS
      WHEN '0'
    --synopsys translate_off
           | 'L'
    --synopsys translate_on
      =>
        RETURN fshl_stdar(arg1x_pad, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);
      WHEN '1'
    --synopsys translate_off
           | 'H'
    --synopsys translate_on
      =>
        RETURN fshr_stdar(arg1x_pad(arg1l+1 DOWNTO 1), '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);
      WHEN others =>
        --synopsys translate_off
        result := resolve_unsigned(
          fshl_stdar(arg1x, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit,  olen),
          fshr_stdar(arg1x_pad(arg1l+1 DOWNTO 1), '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen)
        );
        --synopsys translate_on
        RETURN result;
      END CASE;
    END IF;
  END;

  FUNCTION fshl_stdar(arg1: SIGNED; arg2: SIGNED  ; sbit: STD_LOGIC; olen: POSITIVE) RETURN SIGNED IS
    CONSTANT arg1l: NATURAL := arg1'LENGTH - 1;
    ALIAS    arg1x: SIGNED(arg1l DOWNTO 0) IS arg1;
    CONSTANT arg2l: NATURAL := arg2'LENGTH - 1;
    ALIAS    arg2x: SIGNED(arg2l DOWNTO 0) IS arg2;
    VARIABLE arg1x_pad: SIGNED(arg1l+1 DOWNTO 0);
    VARIABLE result: SIGNED(olen-1 DOWNTO 0);
  BEGIN
    result := (others=>'0');
    arg1x_pad(arg1l+1) := sbit;
    arg1x_pad(arg1l downto 0) := arg1x;
    IF arg2l = 0 THEN
      RETURN fshr_stdar(arg1x_pad, UNSIGNED(arg2x), sbit, olen);
    -- ELSIF arg1l = 0 THEN
    --   RETURN fshl(sbit & arg1x, arg2x, sbit, olen);
    ELSE
      CASE arg2x(arg2l) IS
      WHEN '0'
      --synopsys translate_off
           | 'L'
      --synopsys translate_on
      =>
        RETURN fshl_stdar(arg1x_pad, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);
      WHEN '1'
      --synopsys translate_off
           | 'H'
      --synopsys translate_on
      =>
        RETURN fshr_stdar(arg1x_pad(arg1l+1 DOWNTO 1), '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen);
      WHEN others =>
        --synopsys translate_off
        result := resolve_signed(
          fshl_stdar(arg1x, UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit,  olen),
          fshr_stdar(arg1x_pad(arg1l+1 DOWNTO 1), '0' & not UNSIGNED(arg2x(arg2l-1 DOWNTO 0)), sbit, olen)
        );
        --synopsys translate_on
        RETURN result;
      END CASE;
    END IF;
  END;

  FUNCTION fshl_stdar(arg1: UNSIGNED; arg2: SIGNED  ; olen: POSITIVE)
  RETURN UNSIGNED IS
  BEGIN
    RETURN fshl_stdar(arg1, arg2, '0', olen);
  END;

  FUNCTION fshl_stdar(arg1: SIGNED  ; arg2: SIGNED  ; olen: POSITIVE)
  RETURN SIGNED IS
  BEGIN
    RETURN fshl_stdar(arg1, arg2, arg1(arg1'LEFT), olen);
  END;

BEGIN
UNSGNED:  IF signd_a = 0 GENERATE
    z <= std_logic_vector(fshl_stdar(unsigned(a), signed(s), width_z));
  END GENERATE;
SGNED:  IF signd_a /= 0 GENERATE
    z <= std_logic_vector(fshl_stdar(  signed(a), signed(s), width_z));
  END GENERATE;
END beh;

--------> ../td_ccore_solutions/leading_sign_22_0_d840c0cc3faff3dab9b8e63cb3d67e055661_0/rtl.vhdl 
-- ----------------------------------------------------------------------
--  HLS HDL:        VHDL Netlister
--  HLS Version:    2023.2/1059873 Production Release
--  HLS Date:       Mon Aug  7 10:54:31 PDT 2023
-- 
--  Generated by:   r12016@cad40
--  Generated date: Sat Jun 15 02:19:25 2024
-- ----------------------------------------------------------------------

-- 
-- ------------------------------------------------------------------
--  Design Unit:    leading_sign_22_0
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;


ENTITY leading_sign_22_0 IS
  PORT(
    mantissa : IN STD_LOGIC_VECTOR (21 DOWNTO 0);
    rtn : OUT STD_LOGIC_VECTOR (4 DOWNTO 0)
  );
END leading_sign_22_0;

ARCHITECTURE v1 OF leading_sign_22_0 IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_42_4_sdt_4
      : STD_LOGIC;
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_50_2_sdt_2
      : STD_LOGIC;
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_50_2_sdt_1
      : STD_LOGIC;
  SIGNAL c_h_1_8 : STD_LOGIC;
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_and_83_ssc
      : STD_LOGIC;

  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_or_1_nl
      : STD_LOGIC;
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_or_2_nl
      : STD_LOGIC;
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leadi000000
      : STD_LOGIC;
  FUNCTION CONV_SL_1_1(input_val:BOOLEAN)
  RETURN STD_LOGIC IS
  BEGIN
    IF input_val THEN RETURN '1';ELSE RETURN '0';END IF;
  END;

BEGIN
  ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_42_4_sdt_4
      <= NOT(CONV_SL_1_1(mantissa(8 DOWNTO 6)/=STD_LOGIC_VECTOR'("000")));
  ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_50_2_sdt_2
      <= NOT(CONV_SL_1_1(mantissa(3 DOWNTO 2)/=STD_LOGIC_VECTOR'("00")));
  ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_50_2_sdt_1
      <= NOT(CONV_SL_1_1(mantissa(5 DOWNTO 4)/=STD_LOGIC_VECTOR'("00")));
  c_h_1_8 <= ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_50_2_sdt_1
      AND ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_50_2_sdt_2;
  ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_and_83_ssc
      <= CONV_SL_1_1(mantissa(1 DOWNTO 0)=STD_LOGIC_VECTOR'("00")) AND c_h_1_8 AND
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_42_4_sdt_4;
  ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_or_1_nl
      <= c_h_1_8 OR (NOT ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_42_4_sdt_4);
  ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_or_2_nl
      <= (NOT((mantissa(8)) OR ((NOT(ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_50_2_sdt_1
      AND (NOT ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_50_2_sdt_2)))
      AND ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_42_4_sdt_4)))
      OR ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_and_83_ssc;
  ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leadi000000
      <= NOT((NOT(CONV_SL_1_1(mantissa(8 DOWNTO 7)/=STD_LOGIC_VECTOR'("01")))) OR
      ((NOT((NOT((mantissa(5)) OR (NOT(CONV_SL_1_1(mantissa(4 DOWNTO 3)/=STD_LOGIC_VECTOR'("01"))))))
      AND (NOT((mantissa(1)) AND c_h_1_8)))) AND ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_42_4_sdt_4)
      OR ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_and_83_ssc);
  rtn <= STD_LOGIC_VECTOR'( ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_42_4_sdt_4
      & (NOT ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_42_4_sdt_4)
      & ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_or_1_nl
      & ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_or_2_nl
      & ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leadi000000);
END v1;




--------> /home/raid7_4/raid1_1/linux/mentor/Catapult/2023.2/Mgc_home/pkgs/ccs_xilinx/hdl/BLOCK_1R1W_RBW.vhd 
-- Memory Type:            BLOCK
-- Operating Mode:         Simple Dual Port (2-Port)
-- Clock Mode:             Single Clock
-- 
-- RTL Code RW Resolution: RBW
-- Catapult RW Resolution: RBW
-- 
-- HDL Work Library:       Xilinx_RAMS_lib
-- Component Name:         BLOCK_1R1W_RBW
-- Latency = 1:            RAM with no registers on inputs or outputs
--         = 2:            adds embedded register on RAM output
--         = 3:            adds fabric registers to non-clock input RAM pins
--         = 4:            adds fabric register to output (driven by embedded register from latency=2)
-- suppress_sim_read_addr_range_errs:  0 - report errors  1 - suppress errors

LIBRARY ieee;

  USE ieee.std_logic_1164.all;
  USE ieee.numeric_std.all;
PACKAGE BLOCK_1R1W_RBW_pkg IS
  COMPONENT BLOCK_1R1W_RBW IS
  GENERIC (
    addr_width : integer := 8 ;
    data_width : integer := 7 ;
    depth : integer := 256 ;
    latency : integer := 1 ;
    suppress_sim_read_addr_range_errs : integer := 1 
    
  );
  PORT (
    clk : in std_logic ;
    clken : in std_logic ;
    d : in std_logic_vector(data_width-1 downto 0) ;
    q : out std_logic_vector(data_width-1 downto 0) ;
    radr : in std_logic_vector(addr_width-1 downto 0) ;
    re : in std_logic ;
    wadr : in std_logic_vector(addr_width-1 downto 0) ;
    we : in std_logic 
    
  );
  END COMPONENT;
END BLOCK_1R1W_RBW_pkg;
LIBRARY ieee;

  USE ieee.std_logic_1164.all;
  USE ieee.numeric_std.all;
ENTITY BLOCK_1R1W_RBW IS
  GENERIC (
    addr_width : integer := 8 ;
    data_width : integer := 7 ;
    depth : integer := 256 ;
    latency : integer := 1 ;
    suppress_sim_read_addr_range_errs : integer := 1 
    
  );
  PORT (
    clk : in std_logic ;
    clken : in std_logic ;
    d : in std_logic_vector(data_width-1 downto 0) ;
    q : out std_logic_vector(data_width-1 downto 0) ;
    radr : in std_logic_vector(addr_width-1 downto 0) ;
    re : in std_logic ;
    wadr : in std_logic_vector(addr_width-1 downto 0) ;
    we : in std_logic 
    
  );
 END BLOCK_1R1W_RBW;
ARCHITECTURE rtl OF BLOCK_1R1W_RBW IS
  TYPE ram_t IS ARRAY (depth-1 DOWNTO 0) OF std_logic_vector(data_width-1 DOWNTO 0);
  SIGNAL mem : ram_t := (OTHERS => (OTHERS => '0'));
  ATTRIBUTE ram_style: STRING;
  ATTRIBUTE ram_style OF mem : SIGNAL IS "block";
  ATTRIBUTE syn_ramstyle: STRING;
  ATTRIBUTE syn_ramstyle OF mem : SIGNAL IS "block";
  
  SIGNAL ramq : std_logic_vector(data_width-1 downto 0);
  
BEGIN
-- Port Map
-- readA :: CLOCK clk ENABLE clken DATA_OUT q ADDRESS radr READ_ENABLE re
-- writeA :: CLOCK clk ENABLE clken DATA_IN d ADDRESS wadr WRITE_ENABLE we

-- Access memory with non-registered inputs (latency = 1||2)
  IN_PIN :  IF latency < 3 GENERATE
  BEGIN
    PROCESS (clk)
    BEGIN
      IF (rising_edge(clk)) THEN
         IF (clken = '1') THEN
          -- workaround for simulation when read address out-of-range during inactive cycle
          --pragma translate_off
          IF (suppress_sim_read_addr_range_errs < 1 or to_integer(unsigned(radr)) < depth) THEN
          --pragma translate_on
          ramq <= mem(to_integer(unsigned(radr)));
          --pragma translate_off
          END IF;
          --pragma translate_on
          IF (we = '1') THEN
            mem(to_integer(unsigned(wadr))) <= d;
          END IF;
        END IF;
      END IF;
    END PROCESS;
    
  END GENERATE IN_PIN; 

-- Register all non-clock inputs (latency = 3||4)
  IN_REG :  IF latency > 2 GENERATE
    SIGNAL radr_reg : std_logic_vector(addr_width-1 downto 0);
    SIGNAL re_reg : std_logic;
    SIGNAL d_reg : std_logic_vector(data_width-1 downto 0);
    SIGNAL wadr_reg : std_logic_vector(addr_width-1 downto 0);
    SIGNAL we_reg : std_logic;
    
  BEGIN
    PROCESS (clk)
    BEGIN
      IF (rising_edge(clk)) THEN
        IF (clken = '1') THEN
          radr_reg <= radr;
          re_reg <= re;
        END IF;
      END IF;
    END PROCESS;
    PROCESS (clk)
    BEGIN
      IF (rising_edge(clk)) THEN
        IF (clken = '1') THEN
          d_reg <= d;
          wadr_reg <= wadr;
          we_reg <= we;
        END IF;
      END IF;
    END PROCESS;
    
    PROCESS (clk)
    BEGIN
      IF (rising_edge(clk)) THEN
         IF (clken = '1') THEN
          -- workaround for simulation when read address out-of-range during inactive cycle
          --pragma translate_off
          IF (suppress_sim_read_addr_range_errs < 1 or to_integer(unsigned(radr_reg)) < depth) THEN
          --pragma translate_on
          ramq <= mem(to_integer(unsigned(radr_reg)));
          --pragma translate_off
          END IF;
          --pragma translate_on
          IF (we_reg = '1') THEN
            mem(to_integer(unsigned(wadr_reg))) <= d_reg;
          END IF;
        END IF;
      END IF;
    END PROCESS;
    
  END GENERATE IN_REG;

  out_ram : IF latency = 1 GENERATE
  BEGIN
    q <= ramq;
    
  END GENERATE out_ram;

  out_reg1 : IF ((latency = 2) OR (latency = 3)) GENERATE
    SIGNAL tmpq : std_logic_vector(data_width-1 downto 0);
    
  BEGIN
    PROCESS (clk)
    BEGIN
      IF (rising_edge(clk)) THEN
        IF (clken = '1') THEN
          tmpq <= ramq;
        END IF;
      END IF;
    END PROCESS;
    
    q <= tmpq;
    
  END GENERATE out_reg1;

  out_reg2 : IF latency = 4 GENERATE
    SIGNAL tmp1q : std_logic_vector(data_width-1 downto 0);
    
    SIGNAL tmp2q : std_logic_vector(data_width-1 downto 0);
    
  BEGIN
    PROCESS (clk)
    BEGIN
      IF (rising_edge(clk)) THEN
        IF (clken = '1') THEN
          tmp1q <= ramq;
        END IF;
      END IF;
    END PROCESS;
    
    PROCESS (clk)
    BEGIN
      IF (rising_edge(clk)) THEN
        IF (clken = '1') THEN
          tmp2q <= tmp1q;
        END IF;
      END IF;
    END PROCESS;
    
    q <= tmp2q;
    
  END GENERATE out_reg2;


END rtl;

--------> ./rtl_UNET_IP_mainmgc_rom_17_792_5_1.vhdl 
-- ----------------------------------------------------------------------
--  HLS HDL:        VHDL Netlister
--  HLS Version:    2023.2/1059873 Production Release
--  HLS Date:       Mon Aug  7 10:54:31 PDT 2023
-- 
--  Generated by:   r12016@cad40
--  Generated date: Sat Jun 15 02:23:56 2024
-- ----------------------------------------------------------------------

-- 
LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;


PACKAGE UNET_IP_mainmgc_rom_17_792_5_1_pkg IS 
  COMPONENT UNET_IP_mainmgc_rom_17_792_5_1
    PORT (
      addr : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
      data_out : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
    );
  END COMPONENT;
END UNET_IP_mainmgc_rom_17_792_5_1_pkg;

PACKAGE BODY UNET_IP_mainmgc_rom_17_792_5_1_pkg IS
END UNET_IP_mainmgc_rom_17_792_5_1_pkg;

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;


USE work.UNET_IP_mainmgc_rom_17_792_5_1_pkg.all;
LIBRARY std;

USE std.textio.all;
USE ieee.std_logic_textio.all;

ENTITY UNET_IP_mainmgc_rom_17_792_5_1 IS
    PORT (
      addr : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
      data_out : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
    );
END UNET_IP_mainmgc_rom_17_792_5_1;

ARCHITECTURE v4 OF UNET_IP_mainmgc_rom_17_792_5_1 IS
  -- Start of SIF_NL_VHDL::nhl_rom_body
  -- Constants for ROM dimensions
  CONSTANT n_width    : INTEGER := 5;
  CONSTANT n_size     : INTEGER := 792;
  CONSTANT n_addr_w   : INTEGER := 10;
  CONSTANT n_inreg    : INTEGER := 0;
  CONSTANT n_outreg   : INTEGER := 0;
  -- Define data types for ROM storage;
  SUBTYPE  word  IS std_logic_vector((n_width)-1 DOWNTO 0);
  TYPE     lookup_table IS ARRAY (0 to n_size-1) of word;

  SIGNAL mem : lookup_table := lookup_table'(
    word'("00100"),
    word'("01000"),
    word'("11111"),
    word'("11001"),
    word'("10101"),
    word'("11001"),
    word'("01001"),
    word'("00110"),
    word'("00111"),
    word'("00010"),
    word'("00001"),
    word'("00001"),
    word'("11011"),
    word'("11100"),
    word'("01011"),
    word'("00011"),
    word'("11011"),
    word'("00110"),
    word'("00000"),
    word'("00001"),
    word'("10111"),
    word'("11111"),
    word'("11110"),
    word'("10111"),
    word'("11110"),
    word'("11000"),
    word'("11011"),
    word'("01100"),
    word'("00110"),
    word'("00111"),
    word'("11000"),
    word'("11001"),
    word'("10111"),
    word'("11100"),
    word'("01001"),
    word'("00100"),
    word'("11101"),
    word'("11010"),
    word'("11011"),
    word'("01011"),
    word'("01000"),
    word'("00001"),
    word'("10110"),
    word'("01011"),
    word'("11101"),
    word'("01001"),
    word'("00010"),
    word'("11101"),
    word'("11001"),
    word'("11110"),
    word'("00001"),
    word'("10111"),
    word'("10111"),
    word'("01011"),
    word'("01001"),
    word'("00010"),
    word'("00100"),
    word'("11111"),
    word'("11101"),
    word'("11111"),
    word'("00000"),
    word'("11010"),
    word'("01010"),
    word'("11011"),
    word'("00110"),
    word'("00110"),
    word'("00110"),
    word'("11111"),
    word'("01001"),
    word'("01011"),
    word'("10110"),
    word'("01000"),
    word'("10101"),
    word'("01011"),
    word'("11110"),
    word'("11011"),
    word'("00110"),
    word'("10100"),
    word'("11001"),
    word'("10100"),
    word'("10100"),
    word'("11011"),
    word'("11001"),
    word'("00000"),
    word'("00101"),
    word'("11011"),
    word'("11111"),
    word'("10111"),
    word'("01000"),
    word'("10111"),
    word'("11001"),
    word'("00111"),
    word'("11010"),
    word'("10101"),
    word'("10101"),
    word'("11001"),
    word'("11001"),
    word'("10111"),
    word'("01000"),
    word'("00100"),
    word'("10100"),
    word'("01010"),
    word'("11001"),
    word'("00011"),
    word'("00111"),
    word'("01011"),
    word'("11110"),
    word'("11100"),
    word'("10100"),
    word'("01001"),
    word'("00001"),
    word'("01000"),
    word'("11011"),
    word'("11111"),
    word'("00111"),
    word'("00111"),
    word'("00100"),
    word'("01000"),
    word'("00100"),
    word'("01000"),
    word'("01100"),
    word'("11000"),
    word'("01100"),
    word'("00001"),
    word'("00000"),
    word'("01011"),
    word'("00000"),
    word'("10100"),
    word'("11100"),
    word'("01010"),
    word'("01011"),
    word'("11011"),
    word'("10011"),
    word'("00010"),
    word'("10110"),
    word'("00110"),
    word'("11101"),
    word'("01000"),
    word'("11111"),
    word'("00110"),
    word'("00000"),
    word'("01011"),
    word'("00111"),
    word'("01100"),
    word'("01000"),
    word'("00000"),
    word'("11111"),
    word'("11110"),
    word'("00100"),
    word'("11011"),
    word'("00101"),
    word'("00101"),
    word'("01010"),
    word'("01000"),
    word'("01001"),
    word'("11100"),
    word'("01010"),
    word'("10100"),
    word'("11110"),
    word'("10100"),
    word'("11110"),
    word'("11110"),
    word'("11110"),
    word'("10110"),
    word'("00011"),
    word'("00100"),
    word'("10100"),
    word'("01000"),
    word'("11100"),
    word'("11011"),
    word'("10110"),
    word'("00101"),
    word'("01000"),
    word'("00011"),
    word'("11011"),
    word'("10111"),
    word'("10111"),
    word'("11100"),
    word'("00100"),
    word'("00111"),
    word'("01000"),
    word'("00001"),
    word'("11100"),
    word'("01011"),
    word'("10110"),
    word'("01001"),
    word'("00101"),
    word'("01001"),
    word'("10100"),
    word'("00010"),
    word'("11001"),
    word'("01011"),
    word'("10101"),
    word'("11011"),
    word'("11010"),
    word'("10101"),
    word'("10111"),
    word'("11001"),
    word'("10111"),
    word'("00110"),
    word'("00001"),
    word'("11101"),
    word'("00010"),
    word'("11000"),
    word'("01011"),
    word'("11011"),
    word'("00011"),
    word'("00100"),
    word'("00011"),
    word'("00001"),
    word'("00010"),
    word'("11100"),
    word'("00010"),
    word'("01000"),
    word'("01001"),
    word'("01011"),
    word'("00001"),
    word'("11000"),
    word'("00011"),
    word'("00111"),
    word'("11101"),
    word'("11001"),
    word'("11100"),
    word'("00101"),
    word'("11110"),
    word'("11010"),
    word'("00100"),
    word'("00011"),
    word'("00001"),
    word'("11001"),
    word'("11010"),
    word'("11110"),
    word'("11011"),
    word'("11011"),
    word'("00100"),
    word'("00011"),
    word'("11111"),
    word'("11111"),
    word'("00001"),
    word'("11011"),
    word'("11000"),
    word'("00001"),
    word'("00000"),
    word'("00001"),
    word'("00010"),
    word'("11111"),
    word'("11011"),
    word'("11001"),
    word'("11101"),
    word'("11100"),
    word'("00100"),
    word'("00000"),
    word'("11100"),
    word'("00100"),
    word'("11001"),
    word'("00101"),
    word'("00001"),
    word'("11000"),
    word'("11001"),
    word'("11110"),
    word'("00000"),
    word'("11011"),
    word'("11100"),
    word'("11000"),
    word'("00010"),
    word'("11011"),
    word'("11110"),
    word'("11111"),
    word'("00011"),
    word'("00010"),
    word'("00000"),
    word'("00011"),
    word'("11101"),
    word'("11001"),
    word'("11111"),
    word'("00101"),
    word'("00100"),
    word'("11001"),
    word'("11000"),
    word'("00101"),
    word'("11101"),
    word'("11100"),
    word'("11001"),
    word'("11011"),
    word'("11110"),
    word'("00001"),
    word'("11110"),
    word'("00010"),
    word'("11011"),
    word'("00001"),
    word'("00010"),
    word'("11110"),
    word'("11100"),
    word'("11110"),
    word'("11010"),
    word'("00000"),
    word'("00010"),
    word'("11011"),
    word'("11100"),
    word'("00000"),
    word'("11110"),
    word'("00101"),
    word'("11110"),
    word'("11101"),
    word'("00001"),
    word'("11100"),
    word'("11100"),
    word'("11101"),
    word'("11101"),
    word'("00001"),
    word'("11011"),
    word'("00011"),
    word'("11011"),
    word'("11100"),
    word'("00010"),
    word'("11010"),
    word'("00110"),
    word'("11101"),
    word'("00001"),
    word'("00110"),
    word'("00010"),
    word'("11101"),
    word'("11100"),
    word'("00100"),
    word'("11000"),
    word'("11001"),
    word'("11111"),
    word'("11001"),
    word'("11000"),
    word'("00001"),
    word'("00000"),
    word'("00001"),
    word'("00101"),
    word'("11100"),
    word'("11010"),
    word'("11110"),
    word'("00010"),
    word'("11011"),
    word'("00010"),
    word'("11000"),
    word'("00010"),
    word'("11000"),
    word'("00011"),
    word'("11100"),
    word'("11111"),
    word'("00101"),
    word'("00011"),
    word'("11010"),
    word'("00100"),
    word'("00010"),
    word'("00010"),
    word'("00100"),
    word'("11101"),
    word'("11111"),
    word'("11101"),
    word'("00110"),
    word'("00101"),
    word'("11111"),
    word'("00000"),
    word'("00100"),
    word'("00111"),
    word'("00100"),
    word'("11110"),
    word'("11010"),
    word'("11010"),
    word'("11100"),
    word'("00100"),
    word'("00101"),
    word'("11110"),
    word'("11011"),
    word'("00011"),
    word'("11100"),
    word'("00001"),
    word'("00010"),
    word'("00001"),
    word'("11000"),
    word'("11000"),
    word'("00110"),
    word'("11011"),
    word'("11100"),
    word'("00110"),
    word'("11000"),
    word'("00011"),
    word'("11011"),
    word'("00011"),
    word'("11110"),
    word'("11100"),
    word'("11001"),
    word'("11011"),
    word'("00110"),
    word'("11010"),
    word'("11111"),
    word'("11010"),
    word'("00011"),
    word'("00100"),
    word'("00100"),
    word'("11100"),
    word'("00101"),
    word'("10111"),
    word'("00010"),
    word'("11001"),
    word'("00110"),
    word'("11110"),
    word'("11000"),
    word'("11101"),
    word'("11100"),
    word'("11001"),
    word'("11011"),
    word'("00011"),
    word'("00000"),
    word'("00110"),
    word'("11001"),
    word'("00100"),
    word'("11010"),
    word'("11110"),
    word'("00011"),
    word'("00010"),
    word'("00110"),
    word'("00100"),
    word'("11111"),
    word'("00011"),
    word'("11010"),
    word'("00111"),
    word'("00010"),
    word'("00010"),
    word'("11001"),
    word'("00100"),
    word'("11110"),
    word'("00000"),
    word'("11100"),
    word'("11101"),
    word'("00111"),
    word'("00001"),
    word'("11100"),
    word'("11110"),
    word'("11000"),
    word'("00101"),
    word'("11100"),
    word'("11101"),
    word'("00110"),
    word'("11000"),
    word'("11100"),
    word'("00011"),
    word'("00010"),
    word'("11000"),
    word'("11100"),
    word'("00001"),
    word'("11010"),
    word'("00100"),
    word'("00100"),
    word'("11000"),
    word'("11010"),
    word'("11101"),
    word'("11010"),
    word'("10111"),
    word'("00010"),
    word'("11000"),
    word'("11100"),
    word'("11100"),
    word'("00010"),
    word'("00010"),
    word'("11000"),
    word'("00101"),
    word'("00000"),
    word'("00010"),
    word'("11111"),
    word'("11101"),
    word'("11010"),
    word'("11010"),
    word'("00001"),
    word'("00110"),
    word'("11111"),
    word'("00101"),
    word'("00111"),
    word'("11010"),
    word'("11001"),
    word'("00011"),
    word'("00010"),
    word'("11101"),
    word'("00110"),
    word'("00110"),
    word'("11111"),
    word'("11110"),
    word'("11101"),
    word'("00010"),
    word'("11001"),
    word'("11100"),
    word'("00110"),
    word'("11010"),
    word'("00111"),
    word'("11101"),
    word'("11100"),
    word'("00101"),
    word'("11110"),
    word'("00001"),
    word'("11011"),
    word'("00010"),
    word'("00010"),
    word'("11010"),
    word'("00101"),
    word'("11101"),
    word'("00110"),
    word'("11000"),
    word'("00101"),
    word'("11100"),
    word'("01000"),
    word'("11101"),
    word'("00010"),
    word'("00010"),
    word'("00110"),
    word'("00110"),
    word'("11110"),
    word'("01000"),
    word'("11001"),
    word'("11100"),
    word'("00001"),
    word'("00101"),
    word'("00101"),
    word'("00011"),
    word'("11100"),
    word'("11011"),
    word'("11011"),
    word'("00111"),
    word'("11001"),
    word'("00000"),
    word'("00100"),
    word'("11101"),
    word'("00101"),
    word'("00000"),
    word'("00110"),
    word'("00001"),
    word'("00000"),
    word'("00100"),
    word'("11001"),
    word'("00010"),
    word'("11100"),
    word'("00110"),
    word'("00110"),
    word'("11100"),
    word'("00100"),
    word'("00001"),
    word'("00000"),
    word'("00011"),
    word'("00010"),
    word'("11111"),
    word'("00110"),
    word'("00001"),
    word'("00000"),
    word'("00101"),
    word'("11111"),
    word'("11110"),
    word'("00010"),
    word'("10111"),
    word'("11100"),
    word'("00000"),
    word'("11011"),
    word'("00011"),
    word'("11000"),
    word'("00001"),
    word'("11010"),
    word'("00011"),
    word'("11101"),
    word'("11111"),
    word'("00110"),
    word'("11100"),
    word'("11100"),
    word'("11101"),
    word'("11101"),
    word'("00101"),
    word'("11001"),
    word'("11010"),
    word'("00000"),
    word'("00011"),
    word'("11101"),
    word'("00011"),
    word'("11111"),
    word'("00000"),
    word'("00101"),
    word'("11111"),
    word'("00011"),
    word'("00000"),
    word'("00101"),
    word'("11001"),
    word'("11110"),
    word'("00001"),
    word'("11100"),
    word'("11101"),
    word'("11000"),
    word'("11111"),
    word'("11111"),
    word'("11011"),
    word'("00110"),
    word'("00110"),
    word'("00111"),
    word'("11011"),
    word'("11000"),
    word'("11110"),
    word'("11111"),
    word'("00000"),
    word'("11111"),
    word'("00100"),
    word'("11011"),
    word'("11010"),
    word'("11010"),
    word'("11111"),
    word'("00001"),
    word'("11100"),
    word'("00110"),
    word'("11101"),
    word'("00000"),
    word'("11010"),
    word'("11100"),
    word'("00000"),
    word'("00011"),
    word'("11001"),
    word'("11010"),
    word'("11011"),
    word'("00111"),
    word'("00010"),
    word'("11010"),
    word'("11101"),
    word'("00110"),
    word'("00101"),
    word'("00100"),
    word'("11101"),
    word'("00010"),
    word'("11010"),
    word'("11110"),
    word'("11101"),
    word'("11010"),
    word'("11101"),
    word'("00000"),
    word'("00000"),
    word'("11111"),
    word'("00000"),
    word'("11010"),
    word'("11101"),
    word'("11110"),
    word'("11001"),
    word'("00000"),
    word'("00001"),
    word'("00001"),
    word'("11000"),
    word'("11001"),
    word'("11100"),
    word'("11010"),
    word'("11000"),
    word'("11010"),
    word'("00010"),
    word'("11110"),
    word'("11110"),
    word'("00000"),
    word'("00010"),
    word'("00110"),
    word'("00101"),
    word'("11001"),
    word'("00100"),
    word'("00001"),
    word'("00101"),
    word'("00010"),
    word'("00001"),
    word'("00001"),
    word'("11111"),
    word'("11111"),
    word'("00100"),
    word'("00011"),
    word'("11010"),
    word'("11111"),
    word'("11001"),
    word'("00011"),
    word'("00010"),
    word'("00110"),
    word'("11110"),
    word'("00011"),
    word'("11011"),
    word'("11100"),
    word'("00010"),
    word'("00110"),
    word'("11011"),
    word'("11001"),
    word'("11100"),
    word'("00000"),
    word'("11000"),
    word'("00010"),
    word'("00101"),
    word'("11110"),
    word'("00011"),
    word'("00110"),
    word'("00011"),
    word'("11111"),
    word'("11100"),
    word'("11011"),
    word'("11001"),
    word'("00010"),
    word'("11000"),
    word'("00110"),
    word'("00101"),
    word'("11001"),
    word'("11011"),
    word'("00000"),
    word'("11110"),
    word'("00010"),
    word'("11010"),
    word'("11011"),
    word'("11001"),
    word'("00001"),
    word'("11011"),
    word'("00111"),
    word'("00101"),
    word'("11100"),
    word'("00011"),
    word'("11010"),
    word'("11100"),
    word'("00000"),
    word'("00110"),
    word'("11011"),
    word'("00101"),
    word'("11001"),
    word'("11101"),
    word'("11010"),
    word'("11100"),
    word'("11100"),
    word'("00010"),
    word'("00011"),
    word'("00111"),
    word'("11101"),
    word'("00010"),
    word'("11001"),
    word'("00001"),
    word'("00110"),
    word'("00100"),
    word'("00010"),
    word'("11110"),
    word'("11011"),
    word'("00101"),
    word'("00110"),
    word'("00010"),
    word'("11001"),
    word'("00010"),
    word'("00100"),
    word'("11110"),
    word'("11111"),
    word'("00100"),
    word'("11000"),
    word'("00100"),
    word'("00000"),
    word'("11000"),
    word'("11100"),
    word'("11110"),
    word'("00001"),
    word'("11010"),
    word'("11001"),
    word'("11111"),
    word'("11001"),
    word'("11111"),
    word'("11101"),
    word'("11011"),
    word'("11100"),
    word'("11100"),
    word'("11101"),
    word'("11011"),
    word'("00101"),
    word'("11111"),
    word'("11110"),
    word'("00000"),
    word'("00110"),
    word'("00010"),
    word'("00110"),
    word'("00110"),
    word'("00011"),
    word'("00100"),
    word'("11101"),
    word'("00011"),
    word'("11111"),
    word'("11001"),
    word'("11011"),
    word'("11011"),
    word'("00000"),
    word'("11011"),
    word'("11001"),
    word'("11111"),
    word'("00111"),
    word'("11010"),
    word'("11100"),
    word'("11010"),
    word'("11011"),
    word'("00100"),
    word'("11111"),
    word'("00011"),
    word'("00011"),
    word'("00001"),
    word'("11100")
  );
BEGIN

  -- Reading ROM
  PROCESS(addr)
    VARIABLE idx_addr : INTEGER;
  BEGIN
    idx_addr := conv_integer(unsigned(addr(9 DOWNTO 0)));
    IF idx_addr >= 0 AND idx_addr < 792 THEN
      data_out <= mem(idx_addr);
    ELSE
      data_out <= (OTHERS => '0');
    END IF;
  END PROCESS;

END v4;



--------> ./rtl.vhdl 
-- ----------------------------------------------------------------------
--  HLS HDL:        VHDL Netlister
--  HLS Version:    2023.2/1059873 Production Release
--  HLS Date:       Mon Aug  7 10:54:31 PDT 2023
-- 
--  Generated by:   r12016@cad40
--  Generated date: Sat Jun 15 02:23:56 2024
-- ----------------------------------------------------------------------

-- 
-- ------------------------------------------------------------------
--  Design Unit:    UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_6_15_12_32768_1_32768_12_1_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_wait_pkg_v1.ALL;
USE work.ccs_out_wait_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;
USE work.BLOCK_1R1W_RBW_pkg.ALL;


ENTITY UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_6_15_12_32768_1_32768_12_1_gen
    IS
  PORT(
    clken : OUT STD_LOGIC;
    q : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    re : OUT STD_LOGIC;
    radr : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
    we : OUT STD_LOGIC;
    d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
    wadr : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
    clken_d : IN STD_LOGIC;
    d_d : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    q_d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
    radr_d : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
    re_d : IN STD_LOGIC;
    wadr_d : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
    we_d : IN STD_LOGIC;
    writeA_w_ram_ir_internal_WMASK_B_d : IN STD_LOGIC;
    readA_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC
  );
END UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_6_15_12_32768_1_32768_12_1_gen;

ARCHITECTURE v4 OF UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_6_15_12_32768_1_32768_12_1_gen
    IS
  -- Default Constants

BEGIN
  clken <= (clken_d);
  q_d <= q;
  re <= (readA_r_ram_ir_internal_RMASK_B_d);
  radr <= (radr_d);
  we <= (writeA_w_ram_ir_internal_WMASK_B_d);
  d <= (d_d);
  wadr <= (wadr_d);
END v4;

-- ------------------------------------------------------------------
--  Design Unit:    UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_5_15_12_32768_1_32768_12_1_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_wait_pkg_v1.ALL;
USE work.ccs_out_wait_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;
USE work.BLOCK_1R1W_RBW_pkg.ALL;


ENTITY UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_5_15_12_32768_1_32768_12_1_gen
    IS
  PORT(
    clken : OUT STD_LOGIC;
    q : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    re : OUT STD_LOGIC;
    radr : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
    we : OUT STD_LOGIC;
    d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
    wadr : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
    clken_d : IN STD_LOGIC;
    d_d : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    q_d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
    radr_d : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
    re_d : IN STD_LOGIC;
    wadr_d : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
    we_d : IN STD_LOGIC;
    writeA_w_ram_ir_internal_WMASK_B_d : IN STD_LOGIC;
    readA_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC
  );
END UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_5_15_12_32768_1_32768_12_1_gen;

ARCHITECTURE v4 OF UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_5_15_12_32768_1_32768_12_1_gen
    IS
  -- Default Constants

BEGIN
  clken <= (clken_d);
  q_d <= q;
  re <= (readA_r_ram_ir_internal_RMASK_B_d);
  radr <= (radr_d);
  we <= (writeA_w_ram_ir_internal_WMASK_B_d);
  d <= (d_d);
  wadr <= (wadr_d);
END v4;

-- ------------------------------------------------------------------
--  Design Unit:    UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_4_14_12_13068_1_13068_12_1_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_wait_pkg_v1.ALL;
USE work.ccs_out_wait_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;
USE work.BLOCK_1R1W_RBW_pkg.ALL;


ENTITY UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_4_14_12_13068_1_13068_12_1_gen
    IS
  PORT(
    clken : OUT STD_LOGIC;
    q : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    re : OUT STD_LOGIC;
    radr : OUT STD_LOGIC_VECTOR (13 DOWNTO 0);
    we : OUT STD_LOGIC;
    d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
    wadr : OUT STD_LOGIC_VECTOR (13 DOWNTO 0);
    clken_d : IN STD_LOGIC;
    d_d : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    q_d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
    radr_d : IN STD_LOGIC_VECTOR (13 DOWNTO 0);
    re_d : IN STD_LOGIC;
    wadr_d : IN STD_LOGIC_VECTOR (13 DOWNTO 0);
    we_d : IN STD_LOGIC;
    writeA_w_ram_ir_internal_WMASK_B_d : IN STD_LOGIC;
    readA_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC
  );
END UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_4_14_12_13068_1_13068_12_1_gen;

ARCHITECTURE v4 OF UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_4_14_12_13068_1_13068_12_1_gen
    IS
  -- Default Constants

BEGIN
  clken <= (clken_d);
  q_d <= q;
  re <= (readA_r_ram_ir_internal_RMASK_B_d);
  radr <= (radr_d);
  we <= (writeA_w_ram_ir_internal_WMASK_B_d);
  d <= (d_d);
  wadr <= (wadr_d);
END v4;

-- ------------------------------------------------------------------
--  Design Unit:    UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_3_15_12_32768_1_32768_12_1_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_wait_pkg_v1.ALL;
USE work.ccs_out_wait_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;
USE work.BLOCK_1R1W_RBW_pkg.ALL;


ENTITY UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_3_15_12_32768_1_32768_12_1_gen
    IS
  PORT(
    clken : OUT STD_LOGIC;
    q : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    re : OUT STD_LOGIC;
    radr : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
    we : OUT STD_LOGIC;
    d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
    wadr : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
    clken_d : IN STD_LOGIC;
    d_d : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    q_d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
    radr_d : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
    re_d : IN STD_LOGIC;
    wadr_d : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
    we_d : IN STD_LOGIC;
    writeA_w_ram_ir_internal_WMASK_B_d : IN STD_LOGIC;
    readA_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC
  );
END UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_3_15_12_32768_1_32768_12_1_gen;

ARCHITECTURE v4 OF UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_3_15_12_32768_1_32768_12_1_gen
    IS
  -- Default Constants

BEGIN
  clken <= (clken_d);
  q_d <= q;
  re <= (readA_r_ram_ir_internal_RMASK_B_d);
  radr <= (radr_d);
  we <= (writeA_w_ram_ir_internal_WMASK_B_d);
  d <= (d_d);
  wadr <= (wadr_d);
END v4;

-- ------------------------------------------------------------------
--  Design Unit:    UNET_IP_main_run_run_fsm
--  FSM Module
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_wait_pkg_v1.ALL;
USE work.ccs_out_wait_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;
USE work.BLOCK_1R1W_RBW_pkg.ALL;


ENTITY UNET_IP_main_run_run_fsm IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    run_wen : IN STD_LOGIC;
    fsm_output : OUT STD_LOGIC_VECTOR (59 DOWNTO 0);
    for_C_1_tr0 : IN STD_LOGIC;
    for_1_for_for_C_0_tr0 : IN STD_LOGIC;
    for_1_for_C_0_tr0 : IN STD_LOGIC;
    for_1_C_0_tr0 : IN STD_LOGIC;
    for_2_for_for_for_for_for_C_0_tr0 : IN STD_LOGIC;
    for_2_for_for_for_for_C_0_tr0 : IN STD_LOGIC;
    for_2_for_for_for_C_1_tr0 : IN STD_LOGIC;
    for_2_for_for_C_0_tr0 : IN STD_LOGIC;
    for_2_for_C_0_tr0 : IN STD_LOGIC;
    for_2_C_0_tr0 : IN STD_LOGIC;
    for_3_for_C_0_tr0 : IN STD_LOGIC;
    for_3_for_1_C_0_tr0 : IN STD_LOGIC;
    for_3_for_2_C_10_tr0 : IN STD_LOGIC;
    for_3_C_0_tr0 : IN STD_LOGIC;
    for_4_for_for_C_0_tr0 : IN STD_LOGIC;
    for_4_for_C_0_tr0 : IN STD_LOGIC;
    for_4_C_0_tr0 : IN STD_LOGIC;
    for_5_for_for_for_for_for_C_0_tr0 : IN STD_LOGIC;
    for_5_for_for_for_for_C_0_tr0 : IN STD_LOGIC;
    for_5_for_for_for_C_1_tr0 : IN STD_LOGIC;
    for_5_for_for_C_0_tr0 : IN STD_LOGIC;
    for_5_for_C_0_tr0 : IN STD_LOGIC;
    for_5_C_0_tr0 : IN STD_LOGIC;
    for_6_for_C_0_tr0 : IN STD_LOGIC;
    for_6_for_1_C_0_tr0 : IN STD_LOGIC;
    for_6_for_2_C_10_tr0 : IN STD_LOGIC;
    for_6_C_0_tr0 : IN STD_LOGIC;
    for_7_for_for_for_for_C_0_tr0 : IN STD_LOGIC;
    for_7_for_for_for_for_C_0_tr1 : IN STD_LOGIC;
    for_7_for_for_C_1_tr0 : IN STD_LOGIC;
    for_7_for_C_0_tr0 : IN STD_LOGIC;
    for_7_C_0_tr0 : IN STD_LOGIC;
    for_8_C_2_tr0 : IN STD_LOGIC
  );
END UNET_IP_main_run_run_fsm;

ARCHITECTURE v4 OF UNET_IP_main_run_run_fsm IS
  -- Default Constants

  -- FSM State Type Declaration for UNET_IP_main_run_run_fsm_1
  TYPE UNET_IP_main_run_run_fsm_1_ST IS (main_C_0, for_C_0, for_C_1, for_1_for_for_C_0,
      for_1_for_C_0, for_1_C_0, for_2_for_for_for_for_for_C_0, for_2_for_for_for_for_C_0,
      for_2_for_for_for_C_0, for_2_for_for_for_C_1, for_2_for_for_C_0, for_2_for_C_0,
      for_2_C_0, for_3_for_C_0, for_3_for_1_C_0, for_3_for_2_C_0, for_3_for_2_C_1,
      for_3_for_2_C_2, for_3_for_2_C_3, for_3_for_2_C_4, for_3_for_2_C_5, for_3_for_2_C_6,
      for_3_for_2_C_7, for_3_for_2_C_8, for_3_for_2_C_9, for_3_for_2_C_10, for_3_C_0,
      for_4_for_for_C_0, for_4_for_C_0, for_4_C_0, for_5_for_for_for_for_for_C_0,
      for_5_for_for_for_for_C_0, for_5_for_for_for_C_0, for_5_for_for_for_C_1, for_5_for_for_C_0,
      for_5_for_C_0, for_5_C_0, for_6_for_C_0, for_6_for_1_C_0, for_6_for_2_C_0,
      for_6_for_2_C_1, for_6_for_2_C_2, for_6_for_2_C_3, for_6_for_2_C_4, for_6_for_2_C_5,
      for_6_for_2_C_6, for_6_for_2_C_7, for_6_for_2_C_8, for_6_for_2_C_9, for_6_for_2_C_10,
      for_6_C_0, for_7_for_for_for_for_C_0, for_7_for_for_for_C_0, for_7_for_for_C_0,
      for_7_for_for_C_1, for_7_for_C_0, for_7_C_0, for_8_C_0, for_8_C_1, for_8_C_2);

  SIGNAL state_var : UNET_IP_main_run_run_fsm_1_ST;
  SIGNAL state_var_NS : UNET_IP_main_run_run_fsm_1_ST;

BEGIN
  UNET_IP_main_run_run_fsm_1 : PROCESS (for_C_1_tr0, for_1_for_for_C_0_tr0, for_1_for_C_0_tr0,
      for_1_C_0_tr0, for_2_for_for_for_for_for_C_0_tr0, for_2_for_for_for_for_C_0_tr0,
      for_2_for_for_for_C_1_tr0, for_2_for_for_C_0_tr0, for_2_for_C_0_tr0, for_2_C_0_tr0,
      for_3_for_C_0_tr0, for_3_for_1_C_0_tr0, for_3_for_2_C_10_tr0, for_3_C_0_tr0,
      for_4_for_for_C_0_tr0, for_4_for_C_0_tr0, for_4_C_0_tr0, for_5_for_for_for_for_for_C_0_tr0,
      for_5_for_for_for_for_C_0_tr0, for_5_for_for_for_C_1_tr0, for_5_for_for_C_0_tr0,
      for_5_for_C_0_tr0, for_5_C_0_tr0, for_6_for_C_0_tr0, for_6_for_1_C_0_tr0, for_6_for_2_C_10_tr0,
      for_6_C_0_tr0, for_7_for_for_for_for_C_0_tr0, for_7_for_for_for_for_C_0_tr1,
      for_7_for_for_C_1_tr0, for_7_for_C_0_tr0, for_7_C_0_tr0, for_8_C_2_tr0, state_var)
  BEGIN
    CASE state_var IS
      WHEN for_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000000000000000000000000000000000000010");
        state_var_NS <= for_C_1;
      WHEN for_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000000000000000000000000000000000000100");
        IF ( for_C_1_tr0 = '1' ) THEN
          state_var_NS <= for_1_for_for_C_0;
        ELSE
          state_var_NS <= for_C_0;
        END IF;
      WHEN for_1_for_for_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000000000000000000000000000000000001000");
        IF ( for_1_for_for_C_0_tr0 = '1' ) THEN
          state_var_NS <= for_1_for_C_0;
        ELSE
          state_var_NS <= for_1_for_for_C_0;
        END IF;
      WHEN for_1_for_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000000000000000000000000000000000010000");
        IF ( for_1_for_C_0_tr0 = '1' ) THEN
          state_var_NS <= for_1_C_0;
        ELSE
          state_var_NS <= for_1_for_for_C_0;
        END IF;
      WHEN for_1_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000000000000000000000000000000000100000");
        IF ( for_1_C_0_tr0 = '1' ) THEN
          state_var_NS <= for_2_for_for_for_for_for_C_0;
        ELSE
          state_var_NS <= for_1_for_for_C_0;
        END IF;
      WHEN for_2_for_for_for_for_for_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000000000000000000000000000000001000000");
        IF ( for_2_for_for_for_for_for_C_0_tr0 = '1' ) THEN
          state_var_NS <= for_2_for_for_for_for_C_0;
        ELSE
          state_var_NS <= for_2_for_for_for_for_for_C_0;
        END IF;
      WHEN for_2_for_for_for_for_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000000000000000000000000000000010000000");
        IF ( for_2_for_for_for_for_C_0_tr0 = '1' ) THEN
          state_var_NS <= for_2_for_for_for_C_0;
        ELSE
          state_var_NS <= for_2_for_for_for_for_for_C_0;
        END IF;
      WHEN for_2_for_for_for_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000000000000000000000000000000100000000");
        state_var_NS <= for_2_for_for_for_C_1;
      WHEN for_2_for_for_for_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000000000000000000000000000001000000000");
        IF ( for_2_for_for_for_C_1_tr0 = '1' ) THEN
          state_var_NS <= for_2_for_for_C_0;
        ELSE
          state_var_NS <= for_2_for_for_for_for_for_C_0;
        END IF;
      WHEN for_2_for_for_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000000000000000000000000000010000000000");
        IF ( for_2_for_for_C_0_tr0 = '1' ) THEN
          state_var_NS <= for_2_for_C_0;
        ELSE
          state_var_NS <= for_2_for_for_for_for_for_C_0;
        END IF;
      WHEN for_2_for_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000000000000000000000000000100000000000");
        IF ( for_2_for_C_0_tr0 = '1' ) THEN
          state_var_NS <= for_2_C_0;
        ELSE
          state_var_NS <= for_2_for_for_for_for_for_C_0;
        END IF;
      WHEN for_2_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000000000000000000000000001000000000000");
        IF ( for_2_C_0_tr0 = '1' ) THEN
          state_var_NS <= for_3_for_C_0;
        ELSE
          state_var_NS <= for_2_for_for_for_for_for_C_0;
        END IF;
      WHEN for_3_for_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000000000000000000000000010000000000000");
        IF ( for_3_for_C_0_tr0 = '1' ) THEN
          state_var_NS <= for_3_for_1_C_0;
        ELSE
          state_var_NS <= for_3_for_C_0;
        END IF;
      WHEN for_3_for_1_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000000000000000000000000100000000000000");
        IF ( for_3_for_1_C_0_tr0 = '1' ) THEN
          state_var_NS <= for_3_for_2_C_0;
        ELSE
          state_var_NS <= for_3_for_1_C_0;
        END IF;
      WHEN for_3_for_2_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000000000000000000000001000000000000000");
        state_var_NS <= for_3_for_2_C_1;
      WHEN for_3_for_2_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000000000000000000000010000000000000000");
        state_var_NS <= for_3_for_2_C_2;
      WHEN for_3_for_2_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000000000000000000000100000000000000000");
        state_var_NS <= for_3_for_2_C_3;
      WHEN for_3_for_2_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000000000000000000001000000000000000000");
        state_var_NS <= for_3_for_2_C_4;
      WHEN for_3_for_2_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000000000000000000010000000000000000000");
        state_var_NS <= for_3_for_2_C_5;
      WHEN for_3_for_2_C_5 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000000000000000000100000000000000000000");
        state_var_NS <= for_3_for_2_C_6;
      WHEN for_3_for_2_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000000000000000001000000000000000000000");
        state_var_NS <= for_3_for_2_C_7;
      WHEN for_3_for_2_C_7 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000000000000000010000000000000000000000");
        state_var_NS <= for_3_for_2_C_8;
      WHEN for_3_for_2_C_8 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000000000000000100000000000000000000000");
        state_var_NS <= for_3_for_2_C_9;
      WHEN for_3_for_2_C_9 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000000000000001000000000000000000000000");
        state_var_NS <= for_3_for_2_C_10;
      WHEN for_3_for_2_C_10 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000000000000010000000000000000000000000");
        IF ( for_3_for_2_C_10_tr0 = '1' ) THEN
          state_var_NS <= for_3_C_0;
        ELSE
          state_var_NS <= for_3_for_2_C_0;
        END IF;
      WHEN for_3_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000000000000100000000000000000000000000");
        IF ( for_3_C_0_tr0 = '1' ) THEN
          state_var_NS <= for_4_for_for_C_0;
        ELSE
          state_var_NS <= for_3_for_C_0;
        END IF;
      WHEN for_4_for_for_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000000000001000000000000000000000000000");
        IF ( for_4_for_for_C_0_tr0 = '1' ) THEN
          state_var_NS <= for_4_for_C_0;
        ELSE
          state_var_NS <= for_4_for_for_C_0;
        END IF;
      WHEN for_4_for_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000000000010000000000000000000000000000");
        IF ( for_4_for_C_0_tr0 = '1' ) THEN
          state_var_NS <= for_4_C_0;
        ELSE
          state_var_NS <= for_4_for_for_C_0;
        END IF;
      WHEN for_4_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000000000100000000000000000000000000000");
        IF ( for_4_C_0_tr0 = '1' ) THEN
          state_var_NS <= for_5_for_for_for_for_for_C_0;
        ELSE
          state_var_NS <= for_4_for_for_C_0;
        END IF;
      WHEN for_5_for_for_for_for_for_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000000001000000000000000000000000000000");
        IF ( for_5_for_for_for_for_for_C_0_tr0 = '1' ) THEN
          state_var_NS <= for_5_for_for_for_for_C_0;
        ELSE
          state_var_NS <= for_5_for_for_for_for_for_C_0;
        END IF;
      WHEN for_5_for_for_for_for_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000000010000000000000000000000000000000");
        IF ( for_5_for_for_for_for_C_0_tr0 = '1' ) THEN
          state_var_NS <= for_5_for_for_for_C_0;
        ELSE
          state_var_NS <= for_5_for_for_for_for_for_C_0;
        END IF;
      WHEN for_5_for_for_for_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000000100000000000000000000000000000000");
        state_var_NS <= for_5_for_for_for_C_1;
      WHEN for_5_for_for_for_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000001000000000000000000000000000000000");
        IF ( for_5_for_for_for_C_1_tr0 = '1' ) THEN
          state_var_NS <= for_5_for_for_C_0;
        ELSE
          state_var_NS <= for_5_for_for_for_for_for_C_0;
        END IF;
      WHEN for_5_for_for_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000010000000000000000000000000000000000");
        IF ( for_5_for_for_C_0_tr0 = '1' ) THEN
          state_var_NS <= for_5_for_C_0;
        ELSE
          state_var_NS <= for_5_for_for_for_for_for_C_0;
        END IF;
      WHEN for_5_for_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000100000000000000000000000000000000000");
        IF ( for_5_for_C_0_tr0 = '1' ) THEN
          state_var_NS <= for_5_C_0;
        ELSE
          state_var_NS <= for_5_for_for_for_for_for_C_0;
        END IF;
      WHEN for_5_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000001000000000000000000000000000000000000");
        IF ( for_5_C_0_tr0 = '1' ) THEN
          state_var_NS <= for_6_for_C_0;
        ELSE
          state_var_NS <= for_5_for_for_for_for_for_C_0;
        END IF;
      WHEN for_6_for_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000010000000000000000000000000000000000000");
        IF ( for_6_for_C_0_tr0 = '1' ) THEN
          state_var_NS <= for_6_for_1_C_0;
        ELSE
          state_var_NS <= for_6_for_C_0;
        END IF;
      WHEN for_6_for_1_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000100000000000000000000000000000000000000");
        IF ( for_6_for_1_C_0_tr0 = '1' ) THEN
          state_var_NS <= for_6_for_2_C_0;
        ELSE
          state_var_NS <= for_6_for_1_C_0;
        END IF;
      WHEN for_6_for_2_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000001000000000000000000000000000000000000000");
        state_var_NS <= for_6_for_2_C_1;
      WHEN for_6_for_2_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000010000000000000000000000000000000000000000");
        state_var_NS <= for_6_for_2_C_2;
      WHEN for_6_for_2_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000100000000000000000000000000000000000000000");
        state_var_NS <= for_6_for_2_C_3;
      WHEN for_6_for_2_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000001000000000000000000000000000000000000000000");
        state_var_NS <= for_6_for_2_C_4;
      WHEN for_6_for_2_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000010000000000000000000000000000000000000000000");
        state_var_NS <= for_6_for_2_C_5;
      WHEN for_6_for_2_C_5 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000100000000000000000000000000000000000000000000");
        state_var_NS <= for_6_for_2_C_6;
      WHEN for_6_for_2_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000001000000000000000000000000000000000000000000000");
        state_var_NS <= for_6_for_2_C_7;
      WHEN for_6_for_2_C_7 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000010000000000000000000000000000000000000000000000");
        state_var_NS <= for_6_for_2_C_8;
      WHEN for_6_for_2_C_8 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000100000000000000000000000000000000000000000000000");
        state_var_NS <= for_6_for_2_C_9;
      WHEN for_6_for_2_C_9 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000001000000000000000000000000000000000000000000000000");
        state_var_NS <= for_6_for_2_C_10;
      WHEN for_6_for_2_C_10 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000010000000000000000000000000000000000000000000000000");
        IF ( for_6_for_2_C_10_tr0 = '1' ) THEN
          state_var_NS <= for_6_C_0;
        ELSE
          state_var_NS <= for_6_for_2_C_0;
        END IF;
      WHEN for_6_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000100000000000000000000000000000000000000000000000000");
        IF ( for_6_C_0_tr0 = '1' ) THEN
          state_var_NS <= for_7_for_for_for_for_C_0;
        ELSE
          state_var_NS <= for_6_for_C_0;
        END IF;
      WHEN for_7_for_for_for_for_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000001000000000000000000000000000000000000000000000000000");
        IF ( for_7_for_for_for_for_C_0_tr0 = '1' ) THEN
          state_var_NS <= for_7_for_for_C_0;
        ELSIF ( for_7_for_for_for_for_C_0_tr1 = '1' ) THEN
          state_var_NS <= for_7_for_for_for_for_C_0;
        ELSE
          state_var_NS <= for_7_for_for_for_C_0;
        END IF;
      WHEN for_7_for_for_for_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000010000000000000000000000000000000000000000000000000000");
        state_var_NS <= for_7_for_for_for_for_C_0;
      WHEN for_7_for_for_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000100000000000000000000000000000000000000000000000000000");
        state_var_NS <= for_7_for_for_C_1;
      WHEN for_7_for_for_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000001000000000000000000000000000000000000000000000000000000");
        IF ( for_7_for_for_C_1_tr0 = '1' ) THEN
          state_var_NS <= for_7_for_C_0;
        ELSE
          state_var_NS <= for_7_for_for_for_for_C_0;
        END IF;
      WHEN for_7_for_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000010000000000000000000000000000000000000000000000000000000");
        IF ( for_7_for_C_0_tr0 = '1' ) THEN
          state_var_NS <= for_7_C_0;
        ELSE
          state_var_NS <= for_7_for_for_for_for_C_0;
        END IF;
      WHEN for_7_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "000100000000000000000000000000000000000000000000000000000000");
        IF ( for_7_C_0_tr0 = '1' ) THEN
          state_var_NS <= for_8_C_0;
        ELSE
          state_var_NS <= for_7_for_for_for_for_C_0;
        END IF;
      WHEN for_8_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "001000000000000000000000000000000000000000000000000000000000");
        state_var_NS <= for_8_C_1;
      WHEN for_8_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "010000000000000000000000000000000000000000000000000000000000");
        state_var_NS <= for_8_C_2;
      WHEN for_8_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "100000000000000000000000000000000000000000000000000000000000");
        IF ( for_8_C_2_tr0 = '1' ) THEN
          state_var_NS <= main_C_0;
        ELSE
          state_var_NS <= for_8_C_0;
        END IF;
      -- main_C_0
      WHEN OTHERS =>
        fsm_output <= STD_LOGIC_VECTOR'( "000000000000000000000000000000000000000000000000000000000001");
        state_var_NS <= for_C_0;
    END CASE;
  END PROCESS UNET_IP_main_run_run_fsm_1;

  UNET_IP_main_run_run_fsm_1_REG : PROCESS (clk)
  BEGIN
    IF clk'event AND ( clk = '1' ) THEN
      IF ( rst = '1' ) THEN
        state_var <= main_C_0;
      ELSE
        IF ( run_wen = '1' ) THEN
          state_var <= state_var_NS;
        END IF;
      END IF;
    END IF;
  END PROCESS UNET_IP_main_run_run_fsm_1_REG;

END v4;

-- ------------------------------------------------------------------
--  Design Unit:    UNET_IP_main_run_staller
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_wait_pkg_v1.ALL;
USE work.ccs_out_wait_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;
USE work.BLOCK_1R1W_RBW_pkg.ALL;


ENTITY UNET_IP_main_run_staller IS
  PORT(
    run_wen : OUT STD_LOGIC;
    input_rsci_wen_comp : IN STD_LOGIC;
    output_rsci_wen_comp : IN STD_LOGIC
  );
END UNET_IP_main_run_staller;

ARCHITECTURE v4 OF UNET_IP_main_run_staller IS
  -- Default Constants

BEGIN
  run_wen <= input_rsci_wen_comp AND output_rsci_wen_comp;
END v4;

-- ------------------------------------------------------------------
--  Design Unit:    UNET_IP_main_run_output_rsci_output_wait_ctrl
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_wait_pkg_v1.ALL;
USE work.ccs_out_wait_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;
USE work.BLOCK_1R1W_RBW_pkg.ALL;


ENTITY UNET_IP_main_run_output_rsci_output_wait_ctrl IS
  PORT(
    output_rsci_iswt0 : IN STD_LOGIC;
    output_rsci_biwt : OUT STD_LOGIC;
    output_rsci_irdy : IN STD_LOGIC
  );
END UNET_IP_main_run_output_rsci_output_wait_ctrl;

ARCHITECTURE v4 OF UNET_IP_main_run_output_rsci_output_wait_ctrl IS
  -- Default Constants

BEGIN
  output_rsci_biwt <= output_rsci_iswt0 AND output_rsci_irdy;
END v4;

-- ------------------------------------------------------------------
--  Design Unit:    UNET_IP_main_run_input_rsci_input_wait_ctrl
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_wait_pkg_v1.ALL;
USE work.ccs_out_wait_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;
USE work.BLOCK_1R1W_RBW_pkg.ALL;


ENTITY UNET_IP_main_run_input_rsci_input_wait_ctrl IS
  PORT(
    input_rsci_iswt0 : IN STD_LOGIC;
    input_rsci_biwt : OUT STD_LOGIC;
    input_rsci_ivld : IN STD_LOGIC
  );
END UNET_IP_main_run_input_rsci_input_wait_ctrl;

ARCHITECTURE v4 OF UNET_IP_main_run_input_rsci_input_wait_ctrl IS
  -- Default Constants

BEGIN
  input_rsci_biwt <= input_rsci_iswt0 AND input_rsci_ivld;
END v4;

-- ------------------------------------------------------------------
--  Design Unit:    UNET_IP_main_run_output_rsci
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_wait_pkg_v1.ALL;
USE work.ccs_out_wait_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;
USE work.BLOCK_1R1W_RBW_pkg.ALL;


ENTITY UNET_IP_main_run_output_rsci IS
  PORT(
    output_rsc_dat : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
    output_rsc_vld : OUT STD_LOGIC;
    output_rsc_rdy : IN STD_LOGIC;
    output_rsci_oswt : IN STD_LOGIC;
    output_rsci_wen_comp : OUT STD_LOGIC;
    output_rsci_idat : IN STD_LOGIC_VECTOR (11 DOWNTO 0)
  );
END UNET_IP_main_run_output_rsci;

ARCHITECTURE v4 OF UNET_IP_main_run_output_rsci IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL output_rsci_biwt : STD_LOGIC;
  SIGNAL output_rsci_irdy : STD_LOGIC;

  SIGNAL output_rsci_idat_1 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL output_rsci_dat : STD_LOGIC_VECTOR (11 DOWNTO 0);

  COMPONENT UNET_IP_main_run_output_rsci_output_wait_ctrl
    PORT(
      output_rsci_iswt0 : IN STD_LOGIC;
      output_rsci_biwt : OUT STD_LOGIC;
      output_rsci_irdy : IN STD_LOGIC
    );
  END COMPONENT;
BEGIN
  output_rsci : work.ccs_out_wait_pkg_v1.ccs_out_wait_v1
    GENERIC MAP(
      rscid => 2,
      width => 12
      )
    PORT MAP(
      irdy => output_rsci_irdy,
      ivld => output_rsci_oswt,
      idat => output_rsci_idat_1,
      rdy => output_rsc_rdy,
      vld => output_rsc_vld,
      dat => output_rsci_dat
    );
  output_rsci_idat_1 <= output_rsci_idat;
  output_rsc_dat <= output_rsci_dat;

  UNET_IP_main_run_output_rsci_output_wait_ctrl_inst : UNET_IP_main_run_output_rsci_output_wait_ctrl
    PORT MAP(
      output_rsci_iswt0 => output_rsci_oswt,
      output_rsci_biwt => output_rsci_biwt,
      output_rsci_irdy => output_rsci_irdy
    );
  output_rsci_wen_comp <= (NOT output_rsci_oswt) OR output_rsci_biwt;
END v4;

-- ------------------------------------------------------------------
--  Design Unit:    UNET_IP_main_run_input_rsci
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_wait_pkg_v1.ALL;
USE work.ccs_out_wait_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;
USE work.BLOCK_1R1W_RBW_pkg.ALL;


ENTITY UNET_IP_main_run_input_rsci IS
  PORT(
    input_rsc_dat : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    input_rsc_vld : IN STD_LOGIC;
    input_rsc_rdy : OUT STD_LOGIC;
    input_rsci_oswt : IN STD_LOGIC;
    input_rsci_wen_comp : OUT STD_LOGIC;
    input_rsci_idat_mxwt : OUT STD_LOGIC_VECTOR (11 DOWNTO 0)
  );
END UNET_IP_main_run_input_rsci;

ARCHITECTURE v4 OF UNET_IP_main_run_input_rsci IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL input_rsci_biwt : STD_LOGIC;
  SIGNAL input_rsci_ivld : STD_LOGIC;
  SIGNAL input_rsci_idat : STD_LOGIC_VECTOR (11 DOWNTO 0);

  SIGNAL input_rsci_dat : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL input_rsci_idat_1 : STD_LOGIC_VECTOR (11 DOWNTO 0);

  COMPONENT UNET_IP_main_run_input_rsci_input_wait_ctrl
    PORT(
      input_rsci_iswt0 : IN STD_LOGIC;
      input_rsci_biwt : OUT STD_LOGIC;
      input_rsci_ivld : IN STD_LOGIC
    );
  END COMPONENT;
BEGIN
  input_rsci : work.ccs_in_wait_pkg_v1.ccs_in_wait_v1
    GENERIC MAP(
      rscid => 1,
      width => 12
      )
    PORT MAP(
      rdy => input_rsc_rdy,
      vld => input_rsc_vld,
      dat => input_rsci_dat,
      irdy => input_rsci_oswt,
      ivld => input_rsci_ivld,
      idat => input_rsci_idat_1
    );
  input_rsci_dat <= input_rsc_dat;
  input_rsci_idat <= input_rsci_idat_1;

  UNET_IP_main_run_input_rsci_input_wait_ctrl_inst : UNET_IP_main_run_input_rsci_input_wait_ctrl
    PORT MAP(
      input_rsci_iswt0 => input_rsci_oswt,
      input_rsci_biwt => input_rsci_biwt,
      input_rsci_ivld => input_rsci_ivld
    );
  input_rsci_idat_mxwt <= input_rsci_idat;
  input_rsci_wen_comp <= (NOT input_rsci_oswt) OR input_rsci_biwt;
END v4;

-- ------------------------------------------------------------------
--  Design Unit:    UNET_IP_main_run
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_wait_pkg_v1.ALL;
USE work.ccs_out_wait_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;
USE work.BLOCK_1R1W_RBW_pkg.ALL;


ENTITY UNET_IP_main_run IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    input_rsc_dat : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    input_rsc_vld : IN STD_LOGIC;
    input_rsc_rdy : OUT STD_LOGIC;
    output_rsc_dat : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
    output_rsc_vld : OUT STD_LOGIC;
    output_rsc_rdy : IN STD_LOGIC;
    buf1_rsci_clken_d : OUT STD_LOGIC;
    buf1_rsci_d_d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
    buf1_rsci_q_d : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    buf1_rsci_radr_d : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
    buf1_rsci_wadr_d : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
    padded_input_rsci_q_d : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    padded_input_rsci_radr_d : OUT STD_LOGIC_VECTOR (13 DOWNTO 0);
    padded_input_rsci_wadr_d : OUT STD_LOGIC_VECTOR (13 DOWNTO 0);
    buf2_rsci_d_d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
    buf2_rsci_q_d : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    buf2_rsci_radr_d : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
    buf2_rsci_wadr_d : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
    enc1_rsci_d_d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
    enc1_rsci_q_d : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    enc1_rsci_radr_d : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
    enc1_rsci_wadr_d : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
    buf1_rsci_re_d_pff : OUT STD_LOGIC;
    buf1_rsci_we_d_pff : OUT STD_LOGIC;
    padded_input_rsci_re_d_pff : OUT STD_LOGIC;
    padded_input_rsci_we_d_pff : OUT STD_LOGIC;
    buf2_rsci_re_d_pff : OUT STD_LOGIC;
    buf2_rsci_we_d_pff : OUT STD_LOGIC;
    enc1_rsci_re_d_pff : OUT STD_LOGIC;
    enc1_rsci_we_d_pff : OUT STD_LOGIC
  );
END UNET_IP_main_run;

ARCHITECTURE v4 OF UNET_IP_main_run IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL run_wen : STD_LOGIC;
  SIGNAL input_rsci_wen_comp : STD_LOGIC;
  SIGNAL input_rsci_idat_mxwt : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL output_rsci_wen_comp : STD_LOGIC;
  SIGNAL output_rsci_idat : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL for_3_for_2_div_cmp_z : STD_LOGIC_VECTOR (18 DOWNTO 0);
  SIGNAL for_3_for_2_div_cmp_a_18_6 : STD_LOGIC_VECTOR (12 DOWNTO 0);
  SIGNAL fsm_output : STD_LOGIC_VECTOR (59 DOWNTO 0);
  SIGNAL for_5_for_for_for_for_xor_tmp : STD_LOGIC;
  SIGNAL for_2_for_for_2_for_xnor_tmp : STD_LOGIC;
  SIGNAL or_dcpl_4 : STD_LOGIC;
  SIGNAL and_dcpl_2 : STD_LOGIC;
  SIGNAL and_dcpl_3 : STD_LOGIC;
  SIGNAL or_dcpl_94 : STD_LOGIC;
  SIGNAL or_dcpl_108 : STD_LOGIC;
  SIGNAL or_dcpl_109 : STD_LOGIC;
  SIGNAL or_dcpl_115 : STD_LOGIC;
  SIGNAL or_dcpl_122 : STD_LOGIC;
  SIGNAL or_dcpl_128 : STD_LOGIC;
  SIGNAL or_dcpl_130 : STD_LOGIC;
  SIGNAL or_dcpl_143 : STD_LOGIC;
  SIGNAL or_dcpl_151 : STD_LOGIC;
  SIGNAL or_dcpl_157 : STD_LOGIC;
  SIGNAL or_dcpl_159 : STD_LOGIC;
  SIGNAL or_dcpl_163 : STD_LOGIC;
  SIGNAL or_dcpl_168 : STD_LOGIC;
  SIGNAL or_dcpl_169 : STD_LOGIC;
  SIGNAL or_dcpl_170 : STD_LOGIC;
  SIGNAL or_dcpl_173 : STD_LOGIC;
  SIGNAL or_dcpl_216 : STD_LOGIC;
  SIGNAL or_dcpl_219 : STD_LOGIC;
  SIGNAL or_dcpl_223 : STD_LOGIC;
  SIGNAL or_dcpl_228 : STD_LOGIC;
  SIGNAL or_dcpl_231 : STD_LOGIC;
  SIGNAL or_dcpl_232 : STD_LOGIC;
  SIGNAL or_dcpl_239 : STD_LOGIC;
  SIGNAL or_dcpl_277 : STD_LOGIC;
  SIGNAL or_dcpl_278 : STD_LOGIC;
  SIGNAL or_tmp_64 : STD_LOGIC;
  SIGNAL or_tmp_134 : STD_LOGIC;
  SIGNAL and_410_cse : STD_LOGIC;
  SIGNAL and_400_cse : STD_LOGIC;
  SIGNAL and_399_cse : STD_LOGIC;
  SIGNAL and_409_cse : STD_LOGIC;
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp : STD_LOGIC;
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm
      : STD_LOGIC;
  SIGNAL i_12_5_0_sva_2 : STD_LOGIC_VECTOR (5 DOWNTO 0);
  SIGNAL var_tmp_33_6_sva : STD_LOGIC_VECTOR (27 DOWNTO 0);
  SIGNAL out_c_3_3_0_sva_2 : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL for_2_for_for_for_slc_for_2_for_for_for_acc_6_itm : STD_LOGIC;
  SIGNAL out_c_2_3_0_sva_2 : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL i_2_6_0_sva_2 : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL var_tmp_33_6_1_sva : STD_LOGIC_VECTOR (27 DOWNTO 0);
  SIGNAL for_2_for_for_for_for_for_stage_0_2 : STD_LOGIC;
  SIGNAL for_2_for_for_for_for_for_stage_0_3 : STD_LOGIC;
  SIGNAL for_1_for_for_stage_0_2 : STD_LOGIC;
  SIGNAL for_7_for_for_for_for_land_lpi_6_dfm_st_1 : STD_LOGIC;
  SIGNAL y_asn_1_itm_2 : STD_LOGIC;
  SIGNAL for_2_for_for_for_for_for_stage_0_4 : STD_LOGIC;
  SIGNAL y_asn_1_itm_3 : STD_LOGIC;
  SIGNAL for_6_for_2_acc_9_psp_1_sva : STD_LOGIC_VECTOR (18 DOWNTO 0);
  SIGNAL for_6_for_2_mul_1_psp_1_sva_5_0 : STD_LOGIC_VECTOR (5 DOWNTO 0);
  SIGNAL for_3_for_2_acc_9_psp_1_sva : STD_LOGIC_VECTOR (18 DOWNTO 0);
  SIGNAL for_3_for_2_mul_1_psp_1_sva_5_0 : STD_LOGIC_VECTOR (5 DOWNTO 0);
  SIGNAL i_10_12_0_sva_11_0 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL y_1_1_0_sva_0 : STD_LOGIC;
  SIGNAL y_1_1_0_sva_1 : STD_LOGIC;
  SIGNAL reg_var_tmp_33_6_1_ftd : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL reg_var_tmp_33_6_1_1_ftd : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_9_5
      : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_4_0
      : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL reg_output_rsci_iswt0_cse : STD_LOGIC;
  SIGNAL reg_input_rsci_iswt0_cse : STD_LOGIC;
  SIGNAL or_79_cse : STD_LOGIC;
  SIGNAL or_cse : STD_LOGIC;
  SIGNAL nor_5_cse : STD_LOGIC;
  SIGNAL i_and_2_ssc : STD_LOGIC;
  SIGNAL i_11_12_0_sva_1_12 : STD_LOGIC;
  SIGNAL i_11_12_0_sva_1_11_0 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL for_5_for_for_for_for_for_xor_cse : STD_LOGIC;
  SIGNAL out_c_3_3_0_sva_2_0 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL or_329_ssc : STD_LOGIC;
  SIGNAL for_3_for_2_div_cmp_b_13_11 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL for_3_for_2_div_cmp_b_10_0 : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL for_1_for_for_or_1_cse : STD_LOGIC;
  SIGNAL or_242_cse : STD_LOGIC;
  SIGNAL j_j_nor_cse : STD_LOGIC;
  SIGNAL for_1_for_for_or_cse : STD_LOGIC;
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_and_itm
      : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL i_3_6_0_sva : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL out_c_2_3_0_sva_2_0 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL for_2_for_for_for_for_for_acc_itm_1_13_6 : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm
      : STD_LOGIC_VECTOR (5 DOWNTO 0);
  SIGNAL for_5_for_for_for_for_for_acc_25_itm_1_13_6 : STD_LOGIC_VECTOR (7 DOWNTO
      0);
  SIGNAL for_5_for_for_for_for_for_mul_itm_1_8_6 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL for_5_for_for_for_for_for_mul_itm_1_2_0 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL temp_11_0_1_sva_1 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL temp_11_0_sva_1 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL i_1_13_0_sva : STD_LOGIC_VECTOR (13 DOWNTO 0);
  SIGNAL or_480_itm : STD_LOGIC;
  SIGNAL or_481_itm : STD_LOGIC;
  SIGNAL z_out_1 : STD_LOGIC_VECTOR (5 DOWNTO 0);
  SIGNAL z_out_2 : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL z_out_3 : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL z_out_4 : STD_LOGIC_VECTOR (12 DOWNTO 0);
  SIGNAL data_out_out : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL z_out_7 : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL z_out_9 : STD_LOGIC_VECTOR (20 DOWNTO 0);
  SIGNAL z_out_10 : STD_LOGIC_VECTOR (31 DOWNTO 0);
  SIGNAL rtn_out : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL z_out_11 : STD_LOGIC_VECTOR (23 DOWNTO 0);
  SIGNAL z_out_12 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL z_out_14 : STD_LOGIC_VECTOR (13 DOWNTO 0);
  SIGNAL in_c_1_1_0_sva : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL temp_11_0_1_lpi_7 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_24_12_sva
      : STD_LOGIC_VECTOR (12 DOWNTO 0);
  SIGNAL temp_11_0_lpi_7 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL for_5_for_for_for_for_for_acc_7_sdt_sva_1_9_6 : STD_LOGIC_VECTOR (3 DOWNTO
      0);
  SIGNAL for_5_for_for_for_for_for_acc_7_sdt_sva_1_5_2 : STD_LOGIC_VECTOR (3 DOWNTO
      0);
  SIGNAL for_2_for_for_for_for_for_acc_7_itm_1_7_0 : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_and_itm_mx0w0
      : STD_LOGIC_VECTOR (13 DOWNTO 0);
  SIGNAL for_1_for_for_stage_0_2_mx0w2 : STD_LOGIC;
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp_mx0c0
      : STD_LOGIC;
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp_mx0c3
      : STD_LOGIC;
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm_mx0c0
      : STD_LOGIC;
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm_mx0c1
      : STD_LOGIC;
  SIGNAL in_c_1_1_0_sva_mx0c0 : STD_LOGIC;
  SIGNAL out_c_1_1_0_sva_2 : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL for_1_for_for_acc_14_psp_1 : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL temp_11_0_1_sva_1_mx1w0 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL out_c_2_3_0_sva_2_0_mx0c1 : STD_LOGIC;
  SIGNAL i_3_6_0_sva_mx0c0 : STD_LOGIC;
  SIGNAL i_3_6_0_sva_mx0c1 : STD_LOGIC;
  SIGNAL i_3_6_0_sva_2 : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL x_1_sva_1_0_mx0c0 : STD_LOGIC;
  SIGNAL for_7_for_for_for_for_land_lpi_6_dfm_st_1_mx0w4 : STD_LOGIC;
  SIGNAL i_10_12_0_sva_11_0_mx0c1 : STD_LOGIC;
  SIGNAL i_10_12_0_sva_11_0_mx0c3 : STD_LOGIC;
  SIGNAL for_2_for_for_for_for_for_acc_21_sdt_3_0_1 : STD_LOGIC_VECTOR (3 DOWNTO
      0);
  SIGNAL var_tmp_33_6_1_sva_1_mx1w0 : STD_LOGIC_VECTOR (27 DOWNTO 0);
  SIGNAL out_c_3_3_0_sva_2_0_mx0c1 : STD_LOGIC;
  SIGNAL for_3_for_2_mul_1_psp_1_sva_2 : STD_LOGIC_VECTOR (24 DOWNTO 0);
  SIGNAL for_3_for_2_and_cse_1 : STD_LOGIC;
  SIGNAL for_3_for_2_and_2_cse_1 : STD_LOGIC;
  SIGNAL for_3_for_2_and_3_cse_1 : STD_LOGIC;
  SIGNAL for_3_for_2_mul_1_psp_1_sva_3 : STD_LOGIC;
  SIGNAL temp_11_0_sva_1_mx1w0 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL for_5_for_for_for_for_for_acc_23_sdt_1 : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL for_5_for_for_for_for_for_acc_sdt_1 : STD_LOGIC_VECTOR (5 DOWNTO 0);
  SIGNAL for_5_for_for_for_for_for_acc_19_sdt_1 : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL var_tmp_33_6_sva_1_mx1w0 : STD_LOGIC_VECTOR (27 DOWNTO 0);
  SIGNAL for_6_for_2_mul_1_psp_1_sva_1 : STD_LOGIC_VECTOR (24 DOWNTO 0);
  SIGNAL for_3_for_2_asn_itm_18_13 : STD_LOGIC_VECTOR (5 DOWNTO 0);
  SIGNAL for_3_for_2_asn_itm_12_0 : STD_LOGIC_VECTOR (12 DOWNTO 0);
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mul_psp_sva_13_11
      : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mul_psp_sva_10_0
      : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL reg_j_2_ftd : STD_LOGIC;
  SIGNAL reg_j_2_ftd_1 : STD_LOGIC_VECTOR (5 DOWNTO 0);
  SIGNAL or_288_tmp : STD_LOGIC;
  SIGNAL for_2_for_for_for_for_for_acc_17_sdt_1_8_1 : STD_LOGIC_VECTOR (7 DOWNTO
      0);
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_or_3_cse
      : STD_LOGIC;
  SIGNAL reg_for_1_for_for_acc_1_itm_1_cse : STD_LOGIC_VECTOR (13 DOWNTO 0);
  SIGNAL reg_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_qr_cse
      : STD_LOGIC_VECTOR (13 DOWNTO 0);
  SIGNAL for_1_for_for_or_3_cse : STD_LOGIC;
  SIGNAL or_203_cse : STD_LOGIC;
  SIGNAL operator_22_0_false_AC_TRN_AC_WRAP_mux_cse : STD_LOGIC_VECTOR (8 DOWNTO
      0);
  SIGNAL reg_for_2_for_for_for_for_for_mul_itm_1_cse : STD_LOGIC_VECTOR (1 DOWNTO
      0);
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_normalized_fixed_temp_or_cse
      : STD_LOGIC;
  SIGNAL i_or_7_cse : STD_LOGIC;
  SIGNAL or_601_itm : STD_LOGIC;
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_itm_35_11_1
      : STD_LOGIC_VECTOR (24 DOWNTO 0);
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_temp_mul_itm_35_11_1
      : STD_LOGIC_VECTOR (24 DOWNTO 0);
  SIGNAL for_2_for_for_acc_3_itm_6_1 : STD_LOGIC;
  SIGNAL x_and_ssc : STD_LOGIC;
  SIGNAL reg_x_1_sva_1_0_ftd : STD_LOGIC;
  SIGNAL reg_x_1_sva_1_0_ftd_1 : STD_LOGIC;
  SIGNAL for_5_for_for_for_for_for_acc_15_sdt : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_and_2_cse
      : STD_LOGIC;
  SIGNAL z_out_8_32 : STD_LOGIC;
  SIGNAL or_324_cse : STD_LOGIC;
  SIGNAL for_1_for_for_for_1_for_for_and_2_atp : STD_LOGIC;

  SIGNAL i_i_mux_1_nl : STD_LOGIC_VECTOR (13 DOWNTO 0);
  SIGNAL or_325_nl : STD_LOGIC;
  SIGNAL nor_63_nl : STD_LOGIC;
  SIGNAL operator_20_false_mux1h_nl : STD_LOGIC;
  SIGNAL operator_20_false_acc_1_nl : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_and_1_nl
      : STD_LOGIC;
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_and_1_nl
      : STD_LOGIC;
  SIGNAL or_442_nl : STD_LOGIC;
  SIGNAL for_1_for_for_mux_8_nl : STD_LOGIC;
  SIGNAL for_1_for_for_acc_17_nl : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL for_1_for_for_mux1h_42_nl : STD_LOGIC;
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_and_1_nl
      : STD_LOGIC;
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_and_2_nl
      : STD_LOGIC;
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_and_4_nl
      : STD_LOGIC;
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux1h_6_nl
      : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux1h_25_nl
      : STD_LOGIC;
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_not_nl
      : STD_LOGIC;
  SIGNAL in_c_mux_nl : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL in_c_not_nl : STD_LOGIC;
  SIGNAL j_j_mux_nl : STD_LOGIC;
  SIGNAL for_1_for_for_1_for_and_nl : STD_LOGIC_VECTOR (5 DOWNTO 0);
  SIGNAL for_1_for_mux_nl : STD_LOGIC_VECTOR (5 DOWNTO 0);
  SIGNAL for_7_for_for_acc_3_nl : STD_LOGIC_VECTOR (5 DOWNTO 0);
  SIGNAL j_or_nl : STD_LOGIC;
  SIGNAL or_478_nl : STD_LOGIC;
  SIGNAL temp_temp_mux1h_nl : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL temp_temp_nor_nl : STD_LOGIC;
  SIGNAL temp_and_3_nl : STD_LOGIC;
  SIGNAL nor_66_nl : STD_LOGIC;
  SIGNAL j_and_nl : STD_LOGIC;
  SIGNAL j_or_1_nl : STD_LOGIC;
  SIGNAL y_mux_nl : STD_LOGIC;
  SIGNAL for_1_for_for_mux_9_nl : STD_LOGIC;
  SIGNAL for_1_for_for_mux1h_44_nl : STD_LOGIC;
  SIGNAL or_510_nl : STD_LOGIC;
  SIGNAL for_2_for_for_for_for_for_acc_28_nl : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL for_2_for_for_for_for_for_acc_27_nl : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL for_2_for_for_for_for_for_mul_7_nl : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_mux1h_16_nl : STD_LOGIC_VECTOR
      (4 DOWNTO 0);
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qif_acc_nl : STD_LOGIC_VECTOR
      (4 DOWNTO 0);
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qif_acc_nl : STD_LOGIC_VECTOR
      (4 DOWNTO 0);
  SIGNAL or_515_nl : STD_LOGIC;
  SIGNAL nor_69_nl : STD_LOGIC;
  SIGNAL for_7_for_for_for_for_else_acc_4_nl : STD_LOGIC_VECTOR (12 DOWNTO 0);
  SIGNAL i_mux1h_19_nl : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL i_or_8_nl : STD_LOGIC;
  SIGNAL i_and_4_nl : STD_LOGIC;
  SIGNAL i_and_5_nl : STD_LOGIC;
  SIGNAL nor_70_nl : STD_LOGIC;
  SIGNAL for_2_for_for_for_for_for_asn_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_1_4_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_and_nl
      : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_mux_nl
      : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL nand_17_nl : STD_LOGIC;
  SIGNAL nor_71_nl : STD_LOGIC;
  SIGNAL for_2_for_for_for_acc_13_nl : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL var_tmp_mux_nl : STD_LOGIC_VECTOR (27 DOWNTO 0);
  SIGNAL for_3_for_1_acc_4_nl : STD_LOGIC_VECTOR (12 DOWNTO 0);
  SIGNAL or_544_nl : STD_LOGIC;
  SIGNAL for_2_for_for_for_for_2_for_for_for_and_1_nl : STD_LOGIC_VECTOR (11 DOWNTO
      0);
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_nor_nl
      : STD_LOGIC;
  SIGNAL for_3_for_2_or_1_nl : STD_LOGIC;
  SIGNAL temp_temp_mux1h_1_nl : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL temp_temp_nor_1_nl : STD_LOGIC;
  SIGNAL temp_and_5_nl : STD_LOGIC;
  SIGNAL not_220_nl : STD_LOGIC;
  SIGNAL for_5_for_for_for_for_for_acc_36_nl : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL for_5_for_for_for_for_for_acc_37_nl : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL var_tmp_mux_3_nl : STD_LOGIC_VECTOR (27 DOWNTO 0);
  SIGNAL for_2_for_for_for_for_for_acc_26_nl : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL for_2_for_for_for_for_for_acc_19_nl : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_nl
      : STD_LOGIC_VECTOR (35 DOWNTO 0);
  SIGNAL for_5_for_for_for_for_for_acc_22_nl : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL for_5_for_for_for_for_for_acc_30_nl : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL for_5_for_for_for_for_for_acc_38_nl : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL for_5_for_for_for_for_for_acc_27_nl : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_temp_mul_nl
      : STD_LOGIC_VECTOR (35 DOWNTO 0);
  SIGNAL for_2_for_for_acc_3_nl : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL for_3_for_2_for_3_for_2_and_nl : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL for_for_and_nl : STD_LOGIC;
  SIGNAL for_mux1h_11_nl : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL for_for_mux_nl : STD_LOGIC_VECTOR (5 DOWNTO 0);
  SIGNAL for_for_mux_1_nl : STD_LOGIC_VECTOR (5 DOWNTO 0);
  SIGNAL for_for_and_1_nl : STD_LOGIC;
  SIGNAL for_for_and_2_nl : STD_LOGIC;
  SIGNAL for_mux_1_nl : STD_LOGIC;
  SIGNAL for_mux1h_1_nl : STD_LOGIC;
  SIGNAL for_mux1h_14_nl : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL for_mux1h_15_nl : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL for_mux1h_16_nl : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL for_2_for_for_for_for_for_acc_30_nl : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL for_2_for_for_for_for_for_mux_12_nl : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL for_2_for_for_for_for_for_for_2_for_for_for_for_for_and_3_nl : STD_LOGIC;
  SIGNAL for_2_for_for_for_for_for_for_2_for_for_for_for_for_and_4_nl : STD_LOGIC;
  SIGNAL for_2_for_for_for_for_2_for_for_for_mux_2_nl : STD_LOGIC_VECTOR (11 DOWNTO
      0);
  SIGNAL or_379_nl : STD_LOGIC;
  SIGNAL for_2_for_for_for_acc_nl : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL for_2_for_for_for_mux_6_nl : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL for_2_for_for_for_for_2_for_for_for_and_4_nl : STD_LOGIC;
  SIGNAL for_2_for_for_for_for_2_for_for_for_and_5_nl : STD_LOGIC;
  SIGNAL for_2_for_for_for_for_2_for_for_for_or_1_nl : STD_LOGIC;
  SIGNAL for_3_for_mux_3_nl : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL operator_40_20_false_AC_TRN_AC_WRAP_acc_nl : STD_LOGIC_VECTOR (32 DOWNTO
      0);
  SIGNAL operator_40_20_false_AC_TRN_AC_WRAP_mux_4_nl : STD_LOGIC_VECTOR (18 DOWNTO
      0);
  SIGNAL operator_40_20_false_AC_TRN_AC_WRAP_mux_5_nl : STD_LOGIC_VECTOR (5 DOWNTO
      0);
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_and_1_nl
      : STD_LOGIC;
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux_3_nl
      : STD_LOGIC;
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux1h_6_nl
      : STD_LOGIC;
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux1h_7_nl
      : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux1h_8_nl
      : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux1h_9_nl
      : STD_LOGIC_VECTOR (5 DOWNTO 0);
  SIGNAL for_1_for_for_mul_nl : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL for_1_for_for_mux_11_nl : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL for_3_for_mux_4_nl : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL for_3_for_2_div_cmp_a : STD_LOGIC_VECTOR (18 DOWNTO 0);
  SIGNAL for_3_for_2_div_cmp_b : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL for_3_for_2_div_cmp_z_1 : STD_LOGIC_VECTOR (18 DOWNTO 0);

  SIGNAL for_2_for_for_for_for_for_read_rom_UNET_IP_filters_pretrain_rom_map_1_rg_addr
      : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL for_2_for_for_for_for_for_read_rom_UNET_IP_filters_pretrain_rom_map_1_rg_data_out
      : STD_LOGIC_VECTOR (4 DOWNTO 0);

  SIGNAL operator_22_0_false_AC_TRN_AC_WRAP_1_lshift_rg_a : STD_LOGIC_VECTOR (8 DOWNTO
      0);
  SIGNAL operator_22_0_false_AC_TRN_AC_WRAP_1_lshift_rg_s : STD_LOGIC_VECTOR (4 DOWNTO
      0);
  SIGNAL operator_22_0_false_AC_TRN_AC_WRAP_1_lshift_rg_z : STD_LOGIC_VECTOR (20
      DOWNTO 0);

  SIGNAL operator_32_8_false_AC_TRN_AC_WRAP_1_lshift_rg_a : STD_LOGIC_VECTOR (24
      DOWNTO 0);
  SIGNAL operator_32_8_false_AC_TRN_AC_WRAP_1_lshift_rg_s : STD_LOGIC_VECTOR (4 DOWNTO
      0);
  SIGNAL operator_32_8_false_AC_TRN_AC_WRAP_1_lshift_rg_z : STD_LOGIC_VECTOR (31
      DOWNTO 0);

  COMPONENT leading_sign_22_0
    PORT (
      mantissa : IN STD_LOGIC_VECTOR(21 DOWNTO 0);
      rtn : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
    );
  END COMPONENT;
  SIGNAL leading_sign_22_0_rg_mantissa : STD_LOGIC_VECTOR (21 DOWNTO 0);
  SIGNAL leading_sign_22_0_rg_rtn : STD_LOGIC_VECTOR (4 DOWNTO 0);

  COMPONENT UNET_IP_main_run_input_rsci
    PORT(
      input_rsc_dat : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      input_rsc_vld : IN STD_LOGIC;
      input_rsc_rdy : OUT STD_LOGIC;
      input_rsci_oswt : IN STD_LOGIC;
      input_rsci_wen_comp : OUT STD_LOGIC;
      input_rsci_idat_mxwt : OUT STD_LOGIC_VECTOR (11 DOWNTO 0)
    );
  END COMPONENT;
  SIGNAL UNET_IP_main_run_input_rsci_inst_input_rsc_dat : STD_LOGIC_VECTOR (11 DOWNTO
      0);
  SIGNAL UNET_IP_main_run_input_rsci_inst_input_rsci_idat_mxwt : STD_LOGIC_VECTOR
      (11 DOWNTO 0);

  COMPONENT UNET_IP_main_run_output_rsci
    PORT(
      output_rsc_dat : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
      output_rsc_vld : OUT STD_LOGIC;
      output_rsc_rdy : IN STD_LOGIC;
      output_rsci_oswt : IN STD_LOGIC;
      output_rsci_wen_comp : OUT STD_LOGIC;
      output_rsci_idat : IN STD_LOGIC_VECTOR (11 DOWNTO 0)
    );
  END COMPONENT;
  SIGNAL UNET_IP_main_run_output_rsci_inst_output_rsc_dat : STD_LOGIC_VECTOR (11
      DOWNTO 0);
  SIGNAL UNET_IP_main_run_output_rsci_inst_output_rsci_idat : STD_LOGIC_VECTOR (11
      DOWNTO 0);

  COMPONENT UNET_IP_main_run_staller
    PORT(
      run_wen : OUT STD_LOGIC;
      input_rsci_wen_comp : IN STD_LOGIC;
      output_rsci_wen_comp : IN STD_LOGIC
    );
  END COMPONENT;
  COMPONENT UNET_IP_main_run_run_fsm
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      run_wen : IN STD_LOGIC;
      fsm_output : OUT STD_LOGIC_VECTOR (59 DOWNTO 0);
      for_C_1_tr0 : IN STD_LOGIC;
      for_1_for_for_C_0_tr0 : IN STD_LOGIC;
      for_1_for_C_0_tr0 : IN STD_LOGIC;
      for_1_C_0_tr0 : IN STD_LOGIC;
      for_2_for_for_for_for_for_C_0_tr0 : IN STD_LOGIC;
      for_2_for_for_for_for_C_0_tr0 : IN STD_LOGIC;
      for_2_for_for_for_C_1_tr0 : IN STD_LOGIC;
      for_2_for_for_C_0_tr0 : IN STD_LOGIC;
      for_2_for_C_0_tr0 : IN STD_LOGIC;
      for_2_C_0_tr0 : IN STD_LOGIC;
      for_3_for_C_0_tr0 : IN STD_LOGIC;
      for_3_for_1_C_0_tr0 : IN STD_LOGIC;
      for_3_for_2_C_10_tr0 : IN STD_LOGIC;
      for_3_C_0_tr0 : IN STD_LOGIC;
      for_4_for_for_C_0_tr0 : IN STD_LOGIC;
      for_4_for_C_0_tr0 : IN STD_LOGIC;
      for_4_C_0_tr0 : IN STD_LOGIC;
      for_5_for_for_for_for_for_C_0_tr0 : IN STD_LOGIC;
      for_5_for_for_for_for_C_0_tr0 : IN STD_LOGIC;
      for_5_for_for_for_C_1_tr0 : IN STD_LOGIC;
      for_5_for_for_C_0_tr0 : IN STD_LOGIC;
      for_5_for_C_0_tr0 : IN STD_LOGIC;
      for_5_C_0_tr0 : IN STD_LOGIC;
      for_6_for_C_0_tr0 : IN STD_LOGIC;
      for_6_for_1_C_0_tr0 : IN STD_LOGIC;
      for_6_for_2_C_10_tr0 : IN STD_LOGIC;
      for_6_C_0_tr0 : IN STD_LOGIC;
      for_7_for_for_for_for_C_0_tr0 : IN STD_LOGIC;
      for_7_for_for_for_for_C_0_tr1 : IN STD_LOGIC;
      for_7_for_for_C_1_tr0 : IN STD_LOGIC;
      for_7_for_C_0_tr0 : IN STD_LOGIC;
      for_7_C_0_tr0 : IN STD_LOGIC;
      for_8_C_2_tr0 : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL UNET_IP_main_run_run_fsm_inst_fsm_output : STD_LOGIC_VECTOR (59 DOWNTO 0);
  SIGNAL UNET_IP_main_run_run_fsm_inst_for_C_1_tr0 : STD_LOGIC;
  SIGNAL UNET_IP_main_run_run_fsm_inst_for_1_for_C_0_tr0 : STD_LOGIC;
  SIGNAL UNET_IP_main_run_run_fsm_inst_for_2_for_for_for_C_1_tr0 : STD_LOGIC;
  SIGNAL UNET_IP_main_run_run_fsm_inst_for_2_for_for_C_0_tr0 : STD_LOGIC;
  SIGNAL UNET_IP_main_run_run_fsm_inst_for_2_C_0_tr0 : STD_LOGIC;
  SIGNAL UNET_IP_main_run_run_fsm_inst_for_3_for_C_0_tr0 : STD_LOGIC;
  SIGNAL UNET_IP_main_run_run_fsm_inst_for_3_C_0_tr0 : STD_LOGIC;
  SIGNAL UNET_IP_main_run_run_fsm_inst_for_4_for_C_0_tr0 : STD_LOGIC;
  SIGNAL UNET_IP_main_run_run_fsm_inst_for_4_C_0_tr0 : STD_LOGIC;
  SIGNAL UNET_IP_main_run_run_fsm_inst_for_5_for_for_for_C_1_tr0 : STD_LOGIC;
  SIGNAL UNET_IP_main_run_run_fsm_inst_for_5_for_for_C_0_tr0 : STD_LOGIC;
  SIGNAL UNET_IP_main_run_run_fsm_inst_for_5_for_C_0_tr0 : STD_LOGIC;
  SIGNAL UNET_IP_main_run_run_fsm_inst_for_5_C_0_tr0 : STD_LOGIC;
  SIGNAL UNET_IP_main_run_run_fsm_inst_for_6_for_C_0_tr0 : STD_LOGIC;
  SIGNAL UNET_IP_main_run_run_fsm_inst_for_6_C_0_tr0 : STD_LOGIC;
  SIGNAL UNET_IP_main_run_run_fsm_inst_for_7_for_for_for_for_C_0_tr0 : STD_LOGIC;
  SIGNAL UNET_IP_main_run_run_fsm_inst_for_7_for_for_C_1_tr0 : STD_LOGIC;
  SIGNAL UNET_IP_main_run_run_fsm_inst_for_7_for_C_0_tr0 : STD_LOGIC;
  SIGNAL UNET_IP_main_run_run_fsm_inst_for_7_C_0_tr0 : STD_LOGIC;
  SIGNAL UNET_IP_main_run_run_fsm_inst_for_8_C_2_tr0 : STD_LOGIC;

  FUNCTION CONV_SL_1_1(input_val:BOOLEAN)
  RETURN STD_LOGIC IS
  BEGIN
    IF input_val THEN RETURN '1';ELSE RETURN '0';END IF;
  END;

  FUNCTION MUX1HOT_s_1_3_2(input_2 : STD_LOGIC;
  input_1 : STD_LOGIC;
  input_0 : STD_LOGIC;
  sel : STD_LOGIC_VECTOR(2 DOWNTO 0))
  RETURN STD_LOGIC IS
    VARIABLE result : STD_LOGIC;
    VARIABLE tmp : STD_LOGIC;

    BEGIN
      tmp := sel(0);
      result := input_0 and tmp;
      tmp := sel(1);
      result := result or ( input_1 and tmp);
      tmp := sel(2);
      result := result or ( input_2 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_s_1_4_2(input_3 : STD_LOGIC;
  input_2 : STD_LOGIC;
  input_1 : STD_LOGIC;
  input_0 : STD_LOGIC;
  sel : STD_LOGIC_VECTOR(3 DOWNTO 0))
  RETURN STD_LOGIC IS
    VARIABLE result : STD_LOGIC;
    VARIABLE tmp : STD_LOGIC;

    BEGIN
      tmp := sel(0);
      result := input_0 and tmp;
      tmp := sel(1);
      result := result or ( input_1 and tmp);
      tmp := sel(2);
      result := result or ( input_2 and tmp);
      tmp := sel(3);
      result := result or ( input_3 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_s_1_6_2(input_5 : STD_LOGIC;
  input_4 : STD_LOGIC;
  input_3 : STD_LOGIC;
  input_2 : STD_LOGIC;
  input_1 : STD_LOGIC;
  input_0 : STD_LOGIC;
  sel : STD_LOGIC_VECTOR(5 DOWNTO 0))
  RETURN STD_LOGIC IS
    VARIABLE result : STD_LOGIC;
    VARIABLE tmp : STD_LOGIC;

    BEGIN
      tmp := sel(0);
      result := input_0 and tmp;
      tmp := sel(1);
      result := result or ( input_1 and tmp);
      tmp := sel(2);
      result := result or ( input_2 and tmp);
      tmp := sel(3);
      result := result or ( input_3 and tmp);
      tmp := sel(4);
      result := result or ( input_4 and tmp);
      tmp := sel(5);
      result := result or ( input_5 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_11_3_2(input_2 : STD_LOGIC_VECTOR(10 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(10 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(10 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(2 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(10 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(10 DOWNTO 0);

    BEGIN
      tmp := (OTHERS=>sel(0));
      result := input_0 and tmp;
      tmp := (OTHERS=>sel( 1));
      result := result or ( input_1 and tmp);
      tmp := (OTHERS=>sel( 2));
      result := result or ( input_2 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_12_3_2(input_2 : STD_LOGIC_VECTOR(11 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(11 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(11 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(2 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(11 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(11 DOWNTO 0);

    BEGIN
      tmp := (OTHERS=>sel(0));
      result := input_0 and tmp;
      tmp := (OTHERS=>sel( 1));
      result := result or ( input_1 and tmp);
      tmp := (OTHERS=>sel( 2));
      result := result or ( input_2 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_12_5_2(input_4 : STD_LOGIC_VECTOR(11 DOWNTO 0);
  input_3 : STD_LOGIC_VECTOR(11 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(11 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(11 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(11 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(4 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(11 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(11 DOWNTO 0);

    BEGIN
      tmp := (OTHERS=>sel(0));
      result := input_0 and tmp;
      tmp := (OTHERS=>sel( 1));
      result := result or ( input_1 and tmp);
      tmp := (OTHERS=>sel( 2));
      result := result or ( input_2 and tmp);
      tmp := (OTHERS=>sel( 3));
      result := result or ( input_3 and tmp);
      tmp := (OTHERS=>sel( 4));
      result := result or ( input_4 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_13_3_2(input_2 : STD_LOGIC_VECTOR(12 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(12 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(12 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(2 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(12 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(12 DOWNTO 0);

    BEGIN
      tmp := (OTHERS=>sel(0));
      result := input_0 and tmp;
      tmp := (OTHERS=>sel( 1));
      result := result or ( input_1 and tmp);
      tmp := (OTHERS=>sel( 2));
      result := result or ( input_2 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_2_3_2(input_2 : STD_LOGIC_VECTOR(1 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(1 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(1 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(2 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(1 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(1 DOWNTO 0);

    BEGIN
      tmp := (OTHERS=>sel(0));
      result := input_0 and tmp;
      tmp := (OTHERS=>sel( 1));
      result := result or ( input_1 and tmp);
      tmp := (OTHERS=>sel( 2));
      result := result or ( input_2 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_5_3_2(input_2 : STD_LOGIC_VECTOR(4 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(4 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(4 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(2 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(4 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(4 DOWNTO 0);

    BEGIN
      tmp := (OTHERS=>sel(0));
      result := input_0 and tmp;
      tmp := (OTHERS=>sel( 1));
      result := result or ( input_1 and tmp);
      tmp := (OTHERS=>sel( 2));
      result := result or ( input_2 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_5_4_2(input_3 : STD_LOGIC_VECTOR(4 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(4 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(4 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(4 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(3 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(4 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(4 DOWNTO 0);

    BEGIN
      tmp := (OTHERS=>sel(0));
      result := input_0 and tmp;
      tmp := (OTHERS=>sel( 1));
      result := result or ( input_1 and tmp);
      tmp := (OTHERS=>sel( 2));
      result := result or ( input_2 and tmp);
      tmp := (OTHERS=>sel( 3));
      result := result or ( input_3 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_5_5_2(input_4 : STD_LOGIC_VECTOR(4 DOWNTO 0);
  input_3 : STD_LOGIC_VECTOR(4 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(4 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(4 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(4 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(4 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(4 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(4 DOWNTO 0);

    BEGIN
      tmp := (OTHERS=>sel(0));
      result := input_0 and tmp;
      tmp := (OTHERS=>sel( 1));
      result := result or ( input_1 and tmp);
      tmp := (OTHERS=>sel( 2));
      result := result or ( input_2 and tmp);
      tmp := (OTHERS=>sel( 3));
      result := result or ( input_3 and tmp);
      tmp := (OTHERS=>sel( 4));
      result := result or ( input_4 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_6_3_2(input_2 : STD_LOGIC_VECTOR(5 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(5 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(5 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(2 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(5 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(5 DOWNTO 0);

    BEGIN
      tmp := (OTHERS=>sel(0));
      result := input_0 and tmp;
      tmp := (OTHERS=>sel( 1));
      result := result or ( input_1 and tmp);
      tmp := (OTHERS=>sel( 2));
      result := result or ( input_2 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_7_3_2(input_2 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(2 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(6 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(6 DOWNTO 0);

    BEGIN
      tmp := (OTHERS=>sel(0));
      result := input_0 and tmp;
      tmp := (OTHERS=>sel( 1));
      result := result or ( input_1 and tmp);
      tmp := (OTHERS=>sel( 2));
      result := result or ( input_2 and tmp);
    RETURN result;
  END;

  FUNCTION MUX1HOT_v_7_4_2(input_3 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(3 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(6 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(6 DOWNTO 0);

    BEGIN
      tmp := (OTHERS=>sel(0));
      result := input_0 and tmp;
      tmp := (OTHERS=>sel( 1));
      result := result or ( input_1 and tmp);
      tmp := (OTHERS=>sel( 2));
      result := result or ( input_2 and tmp);
      tmp := (OTHERS=>sel( 3));
      result := result or ( input_3 and tmp);
    RETURN result;
  END;

  FUNCTION MUX_s_1_2_2(input_0 : STD_LOGIC;
  input_1 : STD_LOGIC;
  sel : STD_LOGIC)
  RETURN STD_LOGIC IS
    VARIABLE result : STD_LOGIC;

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_10_4_2(input_0 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_3 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(1 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(9 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN "00" =>
          result := input_0;
        WHEN "01" =>
          result := input_1;
        WHEN "10" =>
          result := input_2;
        WHEN others =>
          result := input_3;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_11_2_2(input_0 : STD_LOGIC_VECTOR(10 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(10 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(10 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_12_2_2(input_0 : STD_LOGIC_VECTOR(11 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(11 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(11 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_13_2_2(input_0 : STD_LOGIC_VECTOR(12 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(12 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(12 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_14_2_2(input_0 : STD_LOGIC_VECTOR(13 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(13 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(13 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_19_2_2(input_0 : STD_LOGIC_VECTOR(18 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(18 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(18 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_28_2_2(input_0 : STD_LOGIC_VECTOR(27 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(27 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(27 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_2_2_2(input_0 : STD_LOGIC_VECTOR(1 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(1 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(1 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_3_2_2(input_0 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(2 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_5_2_2(input_0 : STD_LOGIC_VECTOR(4 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(4 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(4 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_6_2_2(input_0 : STD_LOGIC_VECTOR(5 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(5 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(5 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_6_4_2(input_0 : STD_LOGIC_VECTOR(5 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(5 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(5 DOWNTO 0);
  input_3 : STD_LOGIC_VECTOR(5 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(1 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(5 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN "00" =>
          result := input_0;
        WHEN "01" =>
          result := input_1;
        WHEN "10" =>
          result := input_2;
        WHEN others =>
          result := input_3;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_8_2_2(input_0 : STD_LOGIC_VECTOR(7 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(7 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(7 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_9_2_2(input_0 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(8 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(8 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

BEGIN
  for_3_for_2_div_cmp : work.mgc_comps.mgc_div
    GENERIC MAP(
      width_a => 19,
      width_b => 15,
      signd => 1
      )
    PORT MAP(
      a => for_3_for_2_div_cmp_a,
      b => for_3_for_2_div_cmp_b,
      z => for_3_for_2_div_cmp_z_1
    );
  for_3_for_2_div_cmp_a <= for_3_for_2_div_cmp_a_18_6 & STD_LOGIC_VECTOR'( "000000");
  for_3_for_2_div_cmp_b <= '0' & for_3_for_2_div_cmp_b_13_11 & for_3_for_2_div_cmp_b_10_0;
  for_3_for_2_div_cmp_z <= for_3_for_2_div_cmp_z_1;

  for_2_for_for_for_for_for_read_rom_UNET_IP_filters_pretrain_rom_map_1_rg : work.unet_ip_mainmgc_rom_17_792_5_1_pkg.UNET_IP_mainmgc_rom_17_792_5_1
    PORT MAP(
      addr => for_2_for_for_for_for_for_read_rom_UNET_IP_filters_pretrain_rom_map_1_rg_addr,
      data_out => for_2_for_for_for_for_for_read_rom_UNET_IP_filters_pretrain_rom_map_1_rg_data_out
    );
  for_2_for_for_for_for_for_read_rom_UNET_IP_filters_pretrain_rom_map_1_rg_addr <=
      (MUX_v_2_2_2(STD_LOGIC_VECTOR'("00"), (for_5_for_for_for_for_for_acc_15_sdt(6
      DOWNTO 5)), (fsm_output(30)))) & (MUX_v_5_2_2((for_2_for_for_for_for_for_acc_7_itm_1_7_0(7
      DOWNTO 3)), (for_5_for_for_for_for_for_acc_15_sdt(4 DOWNTO 0)), fsm_output(30)))
      & (MUX_s_1_2_2((for_2_for_for_for_for_for_acc_7_itm_1_7_0(2)), (for_5_for_for_for_for_for_acc_7_sdt_sva_1_5_2(0)),
      fsm_output(30))) & (MUX_v_2_2_2((for_2_for_for_for_for_for_acc_7_itm_1_7_0(1
      DOWNTO 0)), in_c_1_1_0_sva, fsm_output(30)));
  data_out_out <= for_2_for_for_for_for_for_read_rom_UNET_IP_filters_pretrain_rom_map_1_rg_data_out;

  operator_22_0_false_AC_TRN_AC_WRAP_1_lshift_rg : work.mgc_shift_comps_v5.mgc_shift_l_v5
    GENERIC MAP(
      width_a => 9,
      signd_a => 0,
      width_s => 5,
      width_z => 21
      )
    PORT MAP(
      a => operator_22_0_false_AC_TRN_AC_WRAP_1_lshift_rg_a,
      s => operator_22_0_false_AC_TRN_AC_WRAP_1_lshift_rg_s,
      z => operator_22_0_false_AC_TRN_AC_WRAP_1_lshift_rg_z
    );
  operator_22_0_false_AC_TRN_AC_WRAP_1_lshift_rg_a <= operator_22_0_false_AC_TRN_AC_WRAP_mux_cse;
  operator_22_0_false_AC_TRN_AC_WRAP_1_lshift_rg_s <= rtn_out;
  z_out_9 <= operator_22_0_false_AC_TRN_AC_WRAP_1_lshift_rg_z;

  operator_32_8_false_AC_TRN_AC_WRAP_1_lshift_rg : work.mgc_shift_comps_v5.mgc_shift_bl_v5
    GENERIC MAP(
      width_a => 25,
      signd_a => 0,
      width_s => 5,
      width_z => 32
      )
    PORT MAP(
      a => operator_32_8_false_AC_TRN_AC_WRAP_1_lshift_rg_a,
      s => operator_32_8_false_AC_TRN_AC_WRAP_1_lshift_rg_s,
      z => operator_32_8_false_AC_TRN_AC_WRAP_1_lshift_rg_z
    );
  operator_32_8_false_AC_TRN_AC_WRAP_1_lshift_rg_a <= (MUX1HOT_v_13_3_2(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_24_12_sva,
      (ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_itm_35_11_1(24
      DOWNTO 12)), (ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_temp_mul_itm_35_11_1(24
      DOWNTO 12)), STD_LOGIC_VECTOR'( (NOT ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm)
      & ((NOT (fsm_output(41))) AND ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm)
      & ((fsm_output(41)) AND ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm))))
      & (MUX1HOT_v_11_3_2(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mul_psp_sva_10_0,
      (ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_itm_35_11_1(11
      DOWNTO 1)), (ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_temp_mul_itm_35_11_1(11
      DOWNTO 1)), STD_LOGIC_VECTOR'( (NOT ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm)
      & ((NOT (fsm_output(41))) AND ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm)
      & ((fsm_output(41)) AND ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm))))
      & (MUX_s_1_2_2(((ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_itm_35_11_1(0))
      AND ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm),
      ((ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_temp_mul_itm_35_11_1(0))
      AND ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm),
      fsm_output(41)));
  operator_32_8_false_AC_TRN_AC_WRAP_1_lshift_rg_s <= ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_and_itm;
  z_out_10 <= operator_32_8_false_AC_TRN_AC_WRAP_1_lshift_rg_z;

  leading_sign_22_0_rg : leading_sign_22_0
    PORT MAP(
      mantissa => leading_sign_22_0_rg_mantissa,
      rtn => leading_sign_22_0_rg_rtn
    );
  leading_sign_22_0_rg_mantissa <= STD_LOGIC_VECTOR(UNSIGNED'( "0000000000000") &
      UNSIGNED(operator_22_0_false_AC_TRN_AC_WRAP_mux_cse));
  rtn_out <= leading_sign_22_0_rg_rtn;

  UNET_IP_main_run_input_rsci_inst : UNET_IP_main_run_input_rsci
    PORT MAP(
      input_rsc_dat => UNET_IP_main_run_input_rsci_inst_input_rsc_dat,
      input_rsc_vld => input_rsc_vld,
      input_rsc_rdy => input_rsc_rdy,
      input_rsci_oswt => reg_input_rsci_iswt0_cse,
      input_rsci_wen_comp => input_rsci_wen_comp,
      input_rsci_idat_mxwt => UNET_IP_main_run_input_rsci_inst_input_rsci_idat_mxwt
    );
  UNET_IP_main_run_input_rsci_inst_input_rsc_dat <= input_rsc_dat;
  input_rsci_idat_mxwt <= UNET_IP_main_run_input_rsci_inst_input_rsci_idat_mxwt;

  UNET_IP_main_run_output_rsci_inst : UNET_IP_main_run_output_rsci
    PORT MAP(
      output_rsc_dat => UNET_IP_main_run_output_rsci_inst_output_rsc_dat,
      output_rsc_vld => output_rsc_vld,
      output_rsc_rdy => output_rsc_rdy,
      output_rsci_oswt => reg_output_rsci_iswt0_cse,
      output_rsci_wen_comp => output_rsci_wen_comp,
      output_rsci_idat => UNET_IP_main_run_output_rsci_inst_output_rsci_idat
    );
  output_rsc_dat <= UNET_IP_main_run_output_rsci_inst_output_rsc_dat;
  UNET_IP_main_run_output_rsci_inst_output_rsci_idat <= output_rsci_idat;

  UNET_IP_main_run_staller_inst : UNET_IP_main_run_staller
    PORT MAP(
      run_wen => run_wen,
      input_rsci_wen_comp => input_rsci_wen_comp,
      output_rsci_wen_comp => output_rsci_wen_comp
    );
  UNET_IP_main_run_run_fsm_inst : UNET_IP_main_run_run_fsm
    PORT MAP(
      clk => clk,
      rst => rst,
      run_wen => run_wen,
      fsm_output => UNET_IP_main_run_run_fsm_inst_fsm_output,
      for_C_1_tr0 => UNET_IP_main_run_run_fsm_inst_for_C_1_tr0,
      for_1_for_for_C_0_tr0 => and_dcpl_2,
      for_1_for_C_0_tr0 => UNET_IP_main_run_run_fsm_inst_for_1_for_C_0_tr0,
      for_1_C_0_tr0 => for_2_for_for_2_for_xnor_tmp,
      for_2_for_for_for_for_for_C_0_tr0 => and_dcpl_3,
      for_2_for_for_for_for_C_0_tr0 => for_5_for_for_for_for_xor_tmp,
      for_2_for_for_for_C_1_tr0 => UNET_IP_main_run_run_fsm_inst_for_2_for_for_for_C_1_tr0,
      for_2_for_for_C_0_tr0 => UNET_IP_main_run_run_fsm_inst_for_2_for_for_C_0_tr0,
      for_2_for_C_0_tr0 => for_2_for_for_2_for_xnor_tmp,
      for_2_C_0_tr0 => UNET_IP_main_run_run_fsm_inst_for_2_C_0_tr0,
      for_3_for_C_0_tr0 => UNET_IP_main_run_run_fsm_inst_for_3_for_C_0_tr0,
      for_3_for_1_C_0_tr0 => nor_5_cse,
      for_3_for_2_C_10_tr0 => i_11_12_0_sva_1_12,
      for_3_C_0_tr0 => UNET_IP_main_run_run_fsm_inst_for_3_C_0_tr0,
      for_4_for_for_C_0_tr0 => and_dcpl_2,
      for_4_for_C_0_tr0 => UNET_IP_main_run_run_fsm_inst_for_4_for_C_0_tr0,
      for_4_C_0_tr0 => UNET_IP_main_run_run_fsm_inst_for_4_C_0_tr0,
      for_5_for_for_for_for_for_C_0_tr0 => and_dcpl_3,
      for_5_for_for_for_for_C_0_tr0 => for_5_for_for_for_for_xor_tmp,
      for_5_for_for_for_C_1_tr0 => UNET_IP_main_run_run_fsm_inst_for_5_for_for_for_C_1_tr0,
      for_5_for_for_C_0_tr0 => UNET_IP_main_run_run_fsm_inst_for_5_for_for_C_0_tr0,
      for_5_for_C_0_tr0 => UNET_IP_main_run_run_fsm_inst_for_5_for_C_0_tr0,
      for_5_C_0_tr0 => UNET_IP_main_run_run_fsm_inst_for_5_C_0_tr0,
      for_6_for_C_0_tr0 => UNET_IP_main_run_run_fsm_inst_for_6_for_C_0_tr0,
      for_6_for_1_C_0_tr0 => nor_5_cse,
      for_6_for_2_C_10_tr0 => i_11_12_0_sva_1_12,
      for_6_C_0_tr0 => UNET_IP_main_run_run_fsm_inst_for_6_C_0_tr0,
      for_7_for_for_for_for_C_0_tr0 => UNET_IP_main_run_run_fsm_inst_for_7_for_for_for_for_C_0_tr0,
      for_7_for_for_for_for_C_0_tr1 => ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp,
      for_7_for_for_C_1_tr0 => UNET_IP_main_run_run_fsm_inst_for_7_for_for_C_1_tr0,
      for_7_for_C_0_tr0 => UNET_IP_main_run_run_fsm_inst_for_7_for_C_0_tr0,
      for_7_C_0_tr0 => UNET_IP_main_run_run_fsm_inst_for_7_C_0_tr0,
      for_8_C_2_tr0 => UNET_IP_main_run_run_fsm_inst_for_8_C_2_tr0
    );
  fsm_output <= UNET_IP_main_run_run_fsm_inst_fsm_output;
  UNET_IP_main_run_run_fsm_inst_for_C_1_tr0 <= NOT ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm;
  UNET_IP_main_run_run_fsm_inst_for_1_for_C_0_tr0 <= i_2_6_0_sva_2(6);
  UNET_IP_main_run_run_fsm_inst_for_2_for_for_for_C_1_tr0 <= NOT for_2_for_for_for_slc_for_2_for_for_for_acc_6_itm;
  UNET_IP_main_run_run_fsm_inst_for_2_for_for_C_0_tr0 <= NOT for_2_for_for_acc_3_itm_6_1;
  UNET_IP_main_run_run_fsm_inst_for_2_C_0_tr0 <= out_c_2_3_0_sva_2(3);
  UNET_IP_main_run_run_fsm_inst_for_3_for_C_0_tr0 <= NOT ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp;
  UNET_IP_main_run_run_fsm_inst_for_3_C_0_tr0 <= out_c_3_3_0_sva_2(3);
  UNET_IP_main_run_run_fsm_inst_for_4_for_C_0_tr0 <= i_2_6_0_sva_2(6);
  UNET_IP_main_run_run_fsm_inst_for_4_C_0_tr0 <= out_c_2_3_0_sva_2(3);
  UNET_IP_main_run_run_fsm_inst_for_5_for_for_for_C_1_tr0 <= NOT for_2_for_for_for_slc_for_2_for_for_for_acc_6_itm;
  UNET_IP_main_run_run_fsm_inst_for_5_for_for_C_0_tr0 <= NOT for_2_for_for_acc_3_itm_6_1;
  UNET_IP_main_run_run_fsm_inst_for_5_for_C_0_tr0 <= out_c_2_3_0_sva_2(3);
  UNET_IP_main_run_run_fsm_inst_for_5_C_0_tr0 <= out_c_3_3_0_sva_2(3);
  UNET_IP_main_run_run_fsm_inst_for_6_for_C_0_tr0 <= NOT ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp;
  UNET_IP_main_run_run_fsm_inst_for_6_C_0_tr0 <= out_c_3_3_0_sva_2(3);
  UNET_IP_main_run_run_fsm_inst_for_7_for_for_for_for_C_0_tr0 <= (NOT ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp)
      AND ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm;
  UNET_IP_main_run_run_fsm_inst_for_7_for_for_C_1_tr0 <= reg_j_2_ftd_1(5);
  UNET_IP_main_run_run_fsm_inst_for_7_for_C_0_tr0 <= i_12_5_0_sva_2(5);
  UNET_IP_main_run_run_fsm_inst_for_7_C_0_tr0 <= out_c_3_3_0_sva_2(3);
  UNET_IP_main_run_run_fsm_inst_for_8_C_2_tr0 <= NOT ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm;

  buf1_rsci_clken_d <= run_wen;
  or_329_ssc <= or_dcpl_130 OR (fsm_output(21)) OR or_dcpl_128 OR (fsm_output(45));
  or_324_cse <= (fsm_output(1)) OR (fsm_output(57));
  for_1_for_for_or_1_cse <= (fsm_output(6)) OR (fsm_output(30));
  for_1_for_for_or_cse <= (fsm_output(3)) OR (fsm_output(27));
  for_1_for_for_or_3_cse <= (fsm_output(14)) OR (fsm_output(38));
  ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_or_3_cse
      <= (fsm_output(15)) OR (fsm_output(39));
  or_480_itm <= or_dcpl_216 OR (fsm_output(33)) OR (fsm_output(9)) OR (fsm_output(6))
      OR (fsm_output(30));
  or_481_itm <= or_dcpl_168 OR (fsm_output(35)) OR or_dcpl_219 OR (fsm_output(12))
      OR and_409_cse OR and_410_cse;
  or_242_cse <= (NOT for_2_for_for_for_for_for_stage_0_4) OR y_asn_1_itm_3;
  j_j_nor_cse <= NOT(CONV_SL_1_1(out_c_3_3_0_sva_2_0(1 DOWNTO 0)/=STD_LOGIC_VECTOR'("00")));
  x_and_ssc <= run_wen AND (x_1_sva_1_0_mx0c0 OR (fsm_output(7)) OR (fsm_output(31)));
  for_5_for_for_for_for_for_xor_cse <= y_1_1_0_sva_0 XOR y_1_1_0_sva_1;
  for_7_for_for_for_for_else_acc_4_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(CONV_SIGNED(SIGNED(i_10_12_0_sva_11_0),
      12), 13) - CONV_SIGNED(CONV_SIGNED(SIGNED(enc1_rsci_q_d), 12), 13), 13));
  or_288_tmp <= (NOT((for_7_for_for_for_for_else_acc_4_nl(12)) OR for_2_for_for_for_for_for_stage_0_4))
      OR (NOT((NOT(ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp
      AND for_2_for_for_for_for_for_stage_0_3)) AND for_1_for_for_stage_0_2));
  i_or_7_cse <= CONV_SL_1_1(fsm_output(38 DOWNTO 37)/=STD_LOGIC_VECTOR'("00"));
  i_and_2_ssc <= run_wen AND (CONV_SL_1_1(fsm_output(14 DOWNTO 13)/=STD_LOGIC_VECTOR'("00"))
      OR ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_or_3_cse);
  or_79_cse <= CONV_SL_1_1(reg_var_tmp_33_6_1_1_ftd/=STD_LOGIC_VECTOR'("000000000"));
  or_cse <= CONV_SL_1_1(reg_var_tmp_33_6_1_ftd/=STD_LOGIC_VECTOR'("000000000"));
  ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_normalized_fixed_temp_or_cse <=
      (fsm_output(18)) OR (fsm_output(42));
  ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_and_2_cse
      <= run_wen AND (NOT(or_dcpl_130 OR or_dcpl_128));
  or_203_cse <= (fsm_output(16)) OR (fsm_output(40));
  ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_and_itm_mx0w0
      <= MUX_v_14_2_2(STD_LOGIC_VECTOR'("00000000000000"), reg_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_qr_cse,
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp);
  for_1_for_for_stage_0_2_mx0w2 <= ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp
      AND (NOT(for_1_for_for_stage_0_2 AND for_5_for_for_for_for_for_xor_cse));
  out_c_1_1_0_sva_2 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(in_c_1_1_0_sva) +
      UNSIGNED'( "01"), 2));
  for_1_for_for_acc_14_psp_1 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED('1'
      & (reg_j_2_ftd_1(5 DOWNTO 1))), 6), 7) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm),
      6), 7), 7));
  i_2_6_0_sva_2 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm),
      6), 7) + UNSIGNED'( "0000001"), 7));
  temp_11_0_1_sva_1_mx1w0 <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(temp_11_0_1_lpi_7)
      + CONV_SIGNED(CONV_SIGNED(SIGNED(z_out_11(15 DOWNTO 6)), 10), 12), 12));
  i_3_6_0_sva_2 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(i_3_6_0_sva) + UNSIGNED'(
      "0000001"), 7));
  for_7_for_for_for_for_land_lpi_6_dfm_st_1_mx0w4 <= NOT(for_2_for_for_for_for_for_stage_0_2
      OR ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm);
  for_2_for_for_for_for_for_acc_17_sdt_1_8_1 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_SIGNED(SIGNED(z_out_3(7
      DOWNTO 1)), 7), 8) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(i_3_6_0_sva), 7),
      8), 8));
  for_2_for_for_for_for_for_acc_26_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED'( reg_x_1_sva_1_0_ftd
      & reg_x_1_sva_1_0_ftd_1) + CONV_SIGNED(CONV_SIGNED(CONV_SIGNED(reg_x_1_sva_1_0_ftd,
      1), 1), 2), 2));
  for_2_for_for_for_for_for_acc_19_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(CONV_SIGNED(SIGNED'(
      y_1_1_0_sva_1 & y_1_1_0_sva_0), 2), 3) + CONV_SIGNED(CONV_UNSIGNED(UNSIGNED(in_c_1_1_0_sva),
      2), 3), 3));
  for_2_for_for_for_for_for_acc_21_sdt_3_0_1 <= STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(CONV_SIGNED(SIGNED(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(for_2_for_for_for_for_for_acc_26_nl),
      2)) & reg_x_1_sva_1_0_ftd_1), 3), 4) + CONV_SIGNED(SIGNED(for_2_for_for_for_for_for_acc_19_nl),
      4), 4));
  var_tmp_33_6_1_sva_1_mx1w0 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(var_tmp_33_6_1_sva)
      + CONV_UNSIGNED(CONV_SIGNED(SIGNED(z_out_11), 24), 28), 28));
  out_c_2_3_0_sva_2 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(out_c_2_3_0_sva_2_0),
      3), 4) + UNSIGNED'( "0001"), 4));
  ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_nl
      <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED'( UNSIGNED'( "1011010100001") *
      UNSIGNED(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_24_12_sva
      & ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mul_psp_sva_10_0)),
      36));
  ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_itm_35_11_1
      <= ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_nl(35
      DOWNTO 11);
  for_3_for_2_mul_1_psp_1_sva_2 <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED'( CONV_SIGNED(CONV_UNSIGNED(UNSIGNED'(
      (NOT for_3_for_2_mul_1_psp_1_sva_3) & for_3_for_2_mul_1_psp_1_sva_3 & for_3_for_2_mul_1_psp_1_sva_3
      & for_3_for_2_mul_1_psp_1_sva_3 & for_3_for_2_mul_1_psp_1_sva_3 & for_3_for_2_mul_1_psp_1_sva_3
      & for_3_for_2_mul_1_psp_1_sva_3), 7), 8) * SIGNED(for_3_for_2_asn_itm_18_13
      & for_3_for_2_asn_itm_12_0)), 25));
  for_3_for_2_and_cse_1 <= CONV_SL_1_1(out_c_3_3_0_sva_2_0=STD_LOGIC_VECTOR'("001"));
  for_3_for_2_and_2_cse_1 <= (out_c_3_3_0_sva_2_0(2)) AND j_j_nor_cse;
  for_3_for_2_and_3_cse_1 <= CONV_SL_1_1(out_c_3_3_0_sva_2_0=STD_LOGIC_VECTOR'("110"));
  for_3_for_2_mul_1_psp_1_sva_3 <= for_3_for_2_and_cse_1 OR (CONV_SL_1_1(out_c_3_3_0_sva_2_0=STD_LOGIC_VECTOR'("011")))
      OR for_3_for_2_and_2_cse_1 OR for_3_for_2_and_3_cse_1 OR (CONV_SL_1_1(out_c_3_3_0_sva_2_0=STD_LOGIC_VECTOR'("111")));
  out_c_3_3_0_sva_2 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(out_c_3_3_0_sva_2_0),
      3), 4) + UNSIGNED'( "0001"), 4));
  temp_11_0_sva_1_mx1w0 <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(temp_11_0_lpi_7) +
      CONV_SIGNED(CONV_SIGNED(SIGNED(z_out_11(15 DOWNTO 6)), 10), 12), 12));
  for_5_for_for_for_for_for_acc_30_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(CONV_SIGNED(SIGNED'(
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm & reg_x_1_sva_1_0_ftd
      & reg_x_1_sva_1_0_ftd_1), 3), 4) + CONV_SIGNED(CONV_SIGNED(CONV_SIGNED(y_1_1_0_sva_1,
      1), 1), 4), 4));
  for_5_for_for_for_for_for_acc_22_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(CONV_UNSIGNED(UNSIGNED(reg_j_2_ftd
      & reg_j_2_ftd_1), 7), 8) + CONV_SIGNED(CONV_SIGNED(SIGNED(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(for_5_for_for_for_for_for_acc_30_nl),
      4)) & y_1_1_0_sva_0), 5), 8), 8));
  for_5_for_for_for_for_for_acc_23_sdt_1 <= STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(SIGNED(for_5_for_for_for_for_for_acc_22_nl),
      9) + CONV_SIGNED(CONV_UNSIGNED(UNSIGNED(i_3_6_0_sva & '0'), 8), 9), 9));
  for_5_for_for_for_for_for_acc_38_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(CONV_UNSIGNED(UNSIGNED(out_c_3_3_0_sva_2_0),
      3), 5) + CONV_SIGNED(CONV_SIGNED(SIGNED(for_5_for_for_for_for_for_acc_19_sdt_1(4
      DOWNTO 3)), 2), 5), 5));
  for_5_for_for_for_for_for_acc_sdt_1 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(for_5_for_for_for_for_for_acc_38_nl),
      5)) & (for_5_for_for_for_for_for_acc_19_sdt_1(2))) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(out_c_2_3_0_sva_2_0
      & '1'), 4), 6), 6));
  for_5_for_for_for_for_for_acc_27_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(CONV_SIGNED(SIGNED'(
      reg_x_1_sva_1_0_ftd & reg_x_1_sva_1_0_ftd_1), 2), 4) + CONV_SIGNED(CONV_UNSIGNED(UNSIGNED(out_c_2_3_0_sva_2_0(2
      DOWNTO 1)), 2), 4), 4));
  for_5_for_for_for_for_for_acc_19_sdt_1 <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(for_5_for_for_for_for_for_acc_27_nl),
      4)) & (out_c_2_3_0_sva_2_0(0))) + CONV_SIGNED(CONV_SIGNED(SIGNED'( reg_x_1_sva_1_0_ftd
      & reg_x_1_sva_1_0_ftd_1), 2), 5) + CONV_SIGNED(CONV_SIGNED(SIGNED'( y_1_1_0_sva_1
      & y_1_1_0_sva_0), 2), 5), 5));
  var_tmp_33_6_sva_1_mx1w0 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(var_tmp_33_6_sva)
      + CONV_UNSIGNED(CONV_SIGNED(SIGNED(z_out_11), 24), 28), 28));
  ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_temp_mul_nl
      <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED'( UNSIGNED'( "1011010100001") *
      UNSIGNED(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_24_12_sva
      & ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mul_psp_sva_10_0)),
      36));
  ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_temp_mul_itm_35_11_1
      <= ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_temp_mul_nl(35
      DOWNTO 11);
  for_6_for_2_mul_1_psp_1_sva_1 <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED'( CONV_SIGNED(CONV_UNSIGNED(UNSIGNED(i_3_6_0_sva),
      7), 8) * SIGNED(for_3_for_2_asn_itm_18_13 & for_3_for_2_asn_itm_12_0)), 25));
  i_12_5_0_sva_2 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_and_itm),
      5), 6) + UNSIGNED'( "000001"), 6));
  for_2_for_for_acc_3_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(i_3_6_0_sva_2) +
      SIGNED'( "0111111"), 7));
  for_2_for_for_acc_3_itm_6_1 <= for_2_for_for_acc_3_nl(6);
  for_5_for_for_for_for_xor_tmp <= reg_x_1_sva_1_0_ftd_1 XOR reg_x_1_sva_1_0_ftd;
  for_2_for_for_2_for_xnor_tmp <= NOT((out_c_1_1_0_sva_2(0)) XOR (out_c_1_1_0_sva_2(1)));
  or_dcpl_4 <= (fsm_output(13)) OR (fsm_output(37));
  and_dcpl_2 <= NOT(ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp
      OR for_1_for_for_stage_0_2);
  and_dcpl_3 <= and_dcpl_2 AND (NOT(for_2_for_for_for_for_for_stage_0_3 OR for_2_for_for_for_for_for_stage_0_2));
  nor_5_cse <= NOT(ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp
      OR for_2_for_for_for_for_for_stage_0_2);
  or_dcpl_94 <= CONV_SL_1_1(fsm_output(39 DOWNTO 38)/=STD_LOGIC_VECTOR'("00"));
  or_dcpl_108 <= (fsm_output(49)) OR (fsm_output(46));
  or_dcpl_109 <= (fsm_output(41)) OR (fsm_output(43));
  or_dcpl_115 <= (fsm_output(17)) OR (fsm_output(19));
  or_dcpl_122 <= (fsm_output(26)) OR (fsm_output(12));
  or_dcpl_128 <= CONV_SL_1_1(fsm_output(44 DOWNTO 43)/=STD_LOGIC_VECTOR'("00"));
  or_dcpl_130 <= CONV_SL_1_1(fsm_output(20 DOWNTO 19)/=STD_LOGIC_VECTOR'("00"));
  or_dcpl_143 <= (fsm_output(36)) OR (fsm_output(29));
  or_dcpl_151 <= (fsm_output(56)) OR (fsm_output(50));
  or_dcpl_157 <= CONV_SL_1_1(fsm_output(56 DOWNTO 55)/=STD_LOGIC_VECTOR'("00"));
  or_dcpl_159 <= (fsm_output(54)) OR (fsm_output(28)) OR (fsm_output(4));
  or_dcpl_163 <= CONV_SL_1_1(fsm_output(35 DOWNTO 34)/=STD_LOGIC_VECTOR'("00"));
  or_dcpl_168 <= CONV_SL_1_1(fsm_output(11 DOWNTO 10)/=STD_LOGIC_VECTOR'("00"));
  or_dcpl_169 <= or_dcpl_168 OR (fsm_output(31));
  or_dcpl_170 <= or_dcpl_169 OR (fsm_output(7)) OR (fsm_output(33)) OR (fsm_output(9));
  or_dcpl_173 <= (fsm_output(50)) OR (fsm_output(5));
  or_dcpl_216 <= (fsm_output(31)) OR (fsm_output(7));
  or_dcpl_219 <= (fsm_output(34)) OR (fsm_output(36));
  or_dcpl_223 <= (fsm_output(12)) OR (fsm_output(5));
  or_dcpl_228 <= (fsm_output(36)) OR (fsm_output(26));
  or_dcpl_231 <= (fsm_output(29)) OR (fsm_output(12));
  or_dcpl_232 <= or_dcpl_231 OR (fsm_output(5));
  or_dcpl_239 <= (fsm_output(9)) OR (fsm_output(35));
  or_dcpl_277 <= (NOT for_2_for_for_for_for_for_stage_0_3) OR for_7_for_for_for_for_land_lpi_6_dfm_st_1;
  or_dcpl_278 <= (fsm_output(36)) OR (fsm_output(50));
  or_tmp_64 <= (fsm_output(8)) OR (fsm_output(32));
  or_tmp_134 <= CONV_SL_1_1(fsm_output(35 DOWNTO 33)/=STD_LOGIC_VECTOR'("000")) OR
      or_dcpl_143;
  and_400_cse <= ((out_c_1_1_0_sva_2(0)) XOR (out_c_1_1_0_sva_2(1))) AND (fsm_output(5));
  and_399_cse <= (NOT (out_c_2_3_0_sva_2(3))) AND (fsm_output(29));
  and_410_cse <= for_2_for_for_2_for_xnor_tmp AND (fsm_output(5));
  and_409_cse <= (out_c_2_3_0_sva_2(3)) AND (fsm_output(29));
  ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp_mx0c0 <= or_dcpl_159
      OR or_dcpl_169 OR (fsm_output(7)) OR (fsm_output(55)) OR (fsm_output(56)) OR
      (fsm_output(33)) OR (fsm_output(9)) OR or_dcpl_163 OR (fsm_output(52)) OR or_dcpl_143
      OR (fsm_output(2)) OR (fsm_output(26)) OR (fsm_output(12)) OR or_dcpl_173 OR
      ((NOT ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp)
      AND or_dcpl_4);
  ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp_mx0c3 <= ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp
      AND (z_out_4(12)) AND or_dcpl_4;
  ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm_mx0c0
      <= (fsm_output(29)) OR (fsm_output(2)) OR (fsm_output(26)) OR (fsm_output(5));
  ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm_mx0c1
      <= (fsm_output(28)) OR (fsm_output(4));
  in_c_1_1_0_sva_mx0c0 <= and_410_cse OR (fsm_output(2)) OR (fsm_output(12));
  out_c_2_3_0_sva_2_0_mx0c1 <= (fsm_output(35)) OR (fsm_output(12)) OR and_399_cse;
  i_3_6_0_sva_mx0c0 <= (fsm_output(11)) OR (fsm_output(35)) OR (fsm_output(36)) OR
      or_dcpl_232;
  i_3_6_0_sva_mx0c1 <= (fsm_output(10)) OR (fsm_output(34));
  x_1_sva_1_0_mx0c0 <= or_dcpl_168 OR (fsm_output(33)) OR or_dcpl_239 OR or_dcpl_219
      OR (fsm_output(29)) OR or_dcpl_223;
  i_10_12_0_sva_11_0_mx0c1 <= or_dcpl_228 OR (fsm_output(12)) OR (fsm_output(50))
      OR (fsm_output(14));
  i_10_12_0_sva_11_0_mx0c3 <= (fsm_output(49)) OR (fsm_output(25));
  out_c_3_3_0_sva_2_0_mx0c1 <= (fsm_output(56)) OR (fsm_output(26)) OR ((NOT (out_c_3_3_0_sva_2(3)))
      AND or_dcpl_278);
  for_3_for_2_for_3_for_2_and_nl <= MUX_v_12_2_2(STD_LOGIC_VECTOR'("000000000000"),
      (for_3_for_2_acc_9_psp_1_sva(11 DOWNTO 0)), z_out_8_32);
  buf1_rsci_d_d <= MUX1HOT_v_12_3_2(input_rsci_idat_mxwt, for_3_for_2_for_3_for_2_and_nl,
      i_10_12_0_sva_11_0, STD_LOGIC_VECTOR'( (fsm_output(1)) & (fsm_output(24)) &
      (fsm_output(53))));
  for_for_and_nl <= (out_c_2_3_0_sva_2_0(2)) AND (fsm_output(27));
  for_mux1h_11_nl <= MUX1HOT_v_2_3_2(in_c_1_1_0_sva, (out_c_2_3_0_sva_2_0(1 DOWNTO
      0)), (i_1_13_0_sva(13 DOWNTO 12)), STD_LOGIC_VECTOR'( (fsm_output(3)) & (fsm_output(27))
      & (fsm_output(57))));
  for_for_mux_nl <= MUX_v_6_2_2(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm,
      (i_1_13_0_sva(11 DOWNTO 6)), fsm_output(57));
  for_for_mux_1_nl <= MUX_v_6_2_2(reg_j_2_ftd_1, (i_1_13_0_sva(5 DOWNTO 0)), fsm_output(57));
  buf1_rsci_radr_d <= for_for_and_nl & for_mux1h_11_nl & for_for_mux_nl & for_for_mux_1_nl;
  buf1_rsci_re_d_pff <= (ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp
      AND for_1_for_for_or_cse) OR (fsm_output(57));
  for_for_and_1_nl <= (out_c_3_3_0_sva_2_0(2)) AND (NOT((fsm_output(1)) OR (fsm_output(53))));
  for_mux_1_nl <= MUX_s_1_2_2((i_1_13_0_sva(13)), (out_c_3_3_0_sva_2_0(1)), fsm_output(24));
  for_for_and_2_nl <= for_mux_1_nl AND (NOT (fsm_output(53)));
  for_mux1h_1_nl <= MUX1HOT_s_1_3_2((i_1_13_0_sva(12)), (out_c_3_3_0_sva_2_0(0)),
      (out_c_3_3_0_sva_2_0(2)), STD_LOGIC_VECTOR'( (fsm_output(1)) & (fsm_output(24))
      & (fsm_output(53))));
  for_mux1h_14_nl <= MUX1HOT_v_2_3_2((i_1_13_0_sva(11 DOWNTO 10)), (i_10_12_0_sva_11_0(11
      DOWNTO 10)), (out_c_3_3_0_sva_2_0(1 DOWNTO 0)), STD_LOGIC_VECTOR'( (fsm_output(1))
      & (fsm_output(24)) & (fsm_output(53))));
  for_mux1h_15_nl <= MUX1HOT_v_5_3_2((i_1_13_0_sva(9 DOWNTO 5)), (i_10_12_0_sva_11_0(9
      DOWNTO 5)), ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_and_itm,
      STD_LOGIC_VECTOR'( (fsm_output(1)) & (fsm_output(24)) & (fsm_output(53))));
  for_mux1h_16_nl <= MUX1HOT_v_5_3_2((i_1_13_0_sva(4 DOWNTO 0)), (i_10_12_0_sva_11_0(4
      DOWNTO 0)), ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_4_0,
      STD_LOGIC_VECTOR'( (fsm_output(1)) & (fsm_output(24)) & (fsm_output(53))));
  buf1_rsci_wadr_d <= for_for_and_1_nl & for_for_and_2_nl & for_mux1h_1_nl & for_mux1h_14_nl
      & for_mux1h_15_nl & for_mux1h_16_nl;
  buf1_rsci_we_d_pff <= (fsm_output(1)) OR (fsm_output(24)) OR (fsm_output(53));
  for_2_for_for_for_for_for_mux_12_nl <= MUX_v_8_2_2(for_2_for_for_for_for_for_acc_itm_1_13_6,
      for_5_for_for_for_for_for_acc_25_itm_1_13_6, fsm_output(30));
  for_2_for_for_for_for_for_for_2_for_for_for_for_for_and_3_nl <= (for_5_for_for_for_for_for_mul_itm_1_8_6(2))
      AND (fsm_output(30));
  for_2_for_for_for_for_for_for_2_for_for_for_for_for_and_4_nl <= (for_5_for_for_for_for_for_mul_itm_1_2_0(2))
      AND (fsm_output(30));
  for_2_for_for_for_for_for_acc_30_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(for_2_for_for_for_for_for_mux_12_nl
      & (ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm(5
      DOWNTO 2))) + UNSIGNED(reg_for_2_for_for_for_for_for_mul_itm_1_cse & '0' &
      for_2_for_for_for_for_for_for_2_for_for_for_for_for_and_3_nl & (for_5_for_for_for_for_for_mul_itm_1_8_6(1
      DOWNTO 0)) & STD_LOGIC_VECTOR'( "000") & for_2_for_for_for_for_for_for_2_for_for_for_for_for_and_4_nl
      & (for_5_for_for_for_for_for_mul_itm_1_2_0(1 DOWNTO 0))), 12));
  padded_input_rsci_radr_d <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(for_2_for_for_for_for_for_acc_30_nl),
      12)) & (ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm(1
      DOWNTO 0));
  padded_input_rsci_re_d_pff <= for_2_for_for_for_for_for_stage_0_2 AND for_1_for_for_or_1_cse;
  padded_input_rsci_wadr_d <= reg_for_1_for_for_acc_1_itm_1_cse;
  padded_input_rsci_we_d_pff <= for_1_for_for_stage_0_2 AND for_1_for_for_or_cse;
  buf2_rsci_d_d <= MUX_v_12_2_2(temp_11_0_1_sva_1, temp_11_0_sva_1, fsm_output(32));
  or_379_nl <= or_dcpl_4 OR (fsm_output(15)) OR or_dcpl_94;
  for_2_for_for_for_for_2_for_for_for_mux_2_nl <= MUX_v_12_2_2(i_11_12_0_sva_1_11_0,
      i_10_12_0_sva_11_0, or_379_nl);
  buf2_rsci_radr_d <= out_c_3_3_0_sva_2_0 & for_2_for_for_for_for_2_for_for_for_mux_2_nl;
  buf2_rsci_re_d_pff <= ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_or_3_cse
      OR (ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp AND
      (or_dcpl_4 OR for_1_for_for_or_3_cse));
  for_2_for_for_for_mux_6_nl <= MUX_v_3_2_2(out_c_2_3_0_sva_2_0, out_c_3_3_0_sva_2_0,
      fsm_output(32));
  for_2_for_for_for_acc_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_SIGNED(SIGNED((NOT
      (i_3_6_0_sva(6))) & (i_3_6_0_sva(5 DOWNTO 0))), 7), 9) + UNSIGNED(for_2_for_for_for_mux_6_nl
      & STD_LOGIC_VECTOR'( "111111")), 9));
  buf2_rsci_wadr_d <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(for_2_for_for_for_acc_nl),
      9)) & (z_out_7(5 DOWNTO 0));
  buf2_rsci_we_d_pff <= or_tmp_64;
  enc1_rsci_d_d <= MUX_v_12_2_2(STD_LOGIC_VECTOR'("000000000000"), (for_6_for_2_acc_9_psp_1_sva(11
      DOWNTO 0)), z_out_8_32);
  enc1_rsci_radr_d <= out_c_3_3_0_sva_2_0 & ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_and_itm
      & ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm &
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_4_0
      & for_2_for_for_for_for_for_stage_0_2;
  enc1_rsci_re_d_pff <= ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp
      AND (fsm_output(51));
  enc1_rsci_wadr_d <= out_c_3_3_0_sva_2_0 & i_10_12_0_sva_11_0;
  enc1_rsci_we_d_pff <= fsm_output(48);
  operator_22_0_false_AC_TRN_AC_WRAP_mux_cse <= MUX_v_9_2_2(reg_var_tmp_33_6_1_1_ftd,
      reg_var_tmp_33_6_1_ftd, fsm_output(39));
  for_5_for_for_for_for_for_acc_15_sdt <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(for_5_for_for_for_for_for_acc_7_sdt_sva_1_9_6
      & (for_5_for_for_for_for_for_acc_7_sdt_sva_1_5_2(3 DOWNTO 1))) + UNSIGNED'(
      "0011011"), 7));
  or_601_itm <= (fsm_output(30)) OR (fsm_output(27));
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        output_rsci_idat <= STD_LOGIC_VECTOR'( "000000000000");
      ELSIF ( (run_wen AND (fsm_output(58))) = '1' ) THEN
        output_rsci_idat <= buf1_rsci_q_d;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        i_1_13_0_sva <= STD_LOGIC_VECTOR'( "00000000000000");
        for_3_for_2_div_cmp_b_13_11 <= STD_LOGIC_VECTOR'( "000");
        for_3_for_2_div_cmp_b_10_0 <= STD_LOGIC_VECTOR'( "00000000000");
        for_3_for_2_div_cmp_a_18_6 <= STD_LOGIC_VECTOR'( "0000000000000");
        reg_output_rsci_iswt0_cse <= '0';
        reg_input_rsci_iswt0_cse <= '0';
        ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm <=
            '0';
        for_1_for_for_stage_0_2 <= '0';
        reg_for_1_for_for_acc_1_itm_1_cse <= STD_LOGIC_VECTOR'( "00000000000000");
        reg_j_2_ftd <= '0';
        y_asn_1_itm_3 <= '0';
        temp_11_0_1_lpi_7 <= STD_LOGIC_VECTOR'( "000000000000");
        y_1_1_0_sva_0 <= '0';
        y_1_1_0_sva_1 <= '0';
        for_2_for_for_for_for_for_stage_0_2 <= '0';
        for_2_for_for_for_for_for_stage_0_3 <= '0';
        for_2_for_for_for_for_for_stage_0_4 <= '0';
        for_2_for_for_for_for_for_acc_itm_1_13_6 <= STD_LOGIC_VECTOR'( "00000000");
        reg_for_2_for_for_for_for_for_mul_itm_1_cse <= STD_LOGIC_VECTOR'( "00");
        y_asn_1_itm_2 <= '0';
        for_2_for_for_for_for_for_acc_7_itm_1_7_0 <= STD_LOGIC_VECTOR'( "00000000");
        ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_and_itm
            <= STD_LOGIC_VECTOR'( "00000");
        for_7_for_for_for_for_land_lpi_6_dfm_st_1 <= '0';
        ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_9_5
            <= STD_LOGIC_VECTOR'( "00000");
        ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_4_0
            <= STD_LOGIC_VECTOR'( "00000");
        for_2_for_for_for_slc_for_2_for_for_for_acc_6_itm <= '0';
        for_3_for_2_asn_itm_18_13 <= STD_LOGIC_VECTOR'( "000000");
        ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_24_12_sva
            <= STD_LOGIC_VECTOR'( "0000000000000");
        reg_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_qr_cse
            <= STD_LOGIC_VECTOR'( "00000000000000");
        for_3_for_2_acc_9_psp_1_sva <= STD_LOGIC_VECTOR'( "0000000000000000000");
        for_3_for_2_mul_1_psp_1_sva_5_0 <= STD_LOGIC_VECTOR'( "000000");
        temp_11_0_lpi_7 <= STD_LOGIC_VECTOR'( "000000000000");
        for_5_for_for_for_for_for_acc_25_itm_1_13_6 <= STD_LOGIC_VECTOR'( "00000000");
        for_5_for_for_for_for_for_mul_itm_1_8_6 <= STD_LOGIC_VECTOR'( "000");
        for_5_for_for_for_for_for_mul_itm_1_2_0 <= STD_LOGIC_VECTOR'( "000");
        for_5_for_for_for_for_for_acc_7_sdt_sva_1_9_6 <= STD_LOGIC_VECTOR'( "0000");
        for_5_for_for_for_for_for_acc_7_sdt_sva_1_5_2 <= STD_LOGIC_VECTOR'( "0000");
        for_6_for_2_acc_9_psp_1_sva <= STD_LOGIC_VECTOR'( "0000000000000000000");
        for_6_for_2_mul_1_psp_1_sva_5_0 <= STD_LOGIC_VECTOR'( "000000");
      ELSIF ( run_wen = '1' ) THEN
        i_1_13_0_sva <= MUX_v_14_2_2(STD_LOGIC_VECTOR'("00000000000000"), i_i_mux_1_nl,
            nor_63_nl);
        for_3_for_2_div_cmp_b_13_11 <= MUX_v_3_2_2((ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_and_itm_mx0w0(13
            DOWNTO 11)), ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mul_psp_sva_13_11,
            or_329_ssc);
        for_3_for_2_div_cmp_b_10_0 <= MUX_v_11_2_2((ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_and_itm_mx0w0(10
            DOWNTO 0)), ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mul_psp_sva_10_0,
            or_329_ssc);
        for_3_for_2_div_cmp_a_18_6 <= for_3_for_2_asn_itm_12_0;
        reg_output_rsci_iswt0_cse <= fsm_output(58);
        reg_input_rsci_iswt0_cse <= NOT((NOT((fsm_output(0)) OR (fsm_output(2))))
            OR ((NOT ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm)
            AND (fsm_output(2))));
        ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm <=
            (operator_20_false_mux1h_nl AND (NOT (fsm_output(31))) AND (NOT(CONV_SL_1_1(fsm_output(55
            DOWNTO 54)/=STD_LOGIC_VECTOR'("00")) OR or_dcpl_151))) OR or_tmp_134
            OR ((NOT((fsm_output(58)) OR (fsm_output(1)) OR (fsm_output(54)))) AND
            (NOT((fsm_output(31)) OR (fsm_output(55)))) AND (NOT((fsm_output(56))
            OR (fsm_output(33)) OR (fsm_output(35)))) AND (NOT((fsm_output(34)) OR
            (fsm_output(57)))) AND (NOT((fsm_output(16)) OR (fsm_output(40)) OR (fsm_output(36))))
            AND (NOT((fsm_output(29)) OR (fsm_output(51)))) AND (NOT((fsm_output(30))
            OR (fsm_output(15)))) AND (NOT((fsm_output(39)) OR (fsm_output(50)))));
        for_1_for_for_stage_0_2 <= (for_1_for_for_mux_8_nl OR or_dcpl_170 OR or_dcpl_163
            OR (fsm_output(13)) OR (fsm_output(37)) OR (fsm_output(51)) OR and_409_cse
            OR and_410_cse OR ((NOT (out_c_2_3_0_sva_2(3))) AND (fsm_output(12)))
            OR ((NOT (out_c_3_3_0_sva_2(3))) AND (fsm_output(36)))) AND (NOT(or_dcpl_159
            OR or_dcpl_157 OR (fsm_output(52)) OR (fsm_output(2)) OR (fsm_output(26))
            OR (fsm_output(50)) OR and_399_cse OR and_400_cse OR ((out_c_2_3_0_sva_2(3))
            AND (fsm_output(12))) OR ((out_c_3_3_0_sva_2(3)) AND (fsm_output(36)))));
        reg_for_1_for_for_acc_1_itm_1_cse <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(z_out_12
            & STD_LOGIC_VECTOR'( "11")) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(for_1_for_for_acc_17_nl),
            7)) & (for_1_for_for_acc_14_psp_1(4 DOWNTO 0)) & (reg_j_2_ftd_1(0))),
            13), 14), 14));
        reg_j_2_ftd <= j_j_mux_nl AND (NOT or_481_itm);
        y_asn_1_itm_3 <= y_asn_1_itm_2;
        temp_11_0_1_lpi_7 <= MUX_v_12_2_2(STD_LOGIC_VECTOR'("000000000000"), temp_temp_mux1h_nl,
            nor_66_nl);
        y_1_1_0_sva_0 <= y_mux_nl OR (NOT for_1_for_for_or_1_cse);
        y_1_1_0_sva_1 <= NOT((NOT(y_1_1_0_sva_1 AND (NOT for_1_for_for_stage_0_2)))
            AND for_1_for_for_or_1_cse);
        for_2_for_for_for_for_for_stage_0_2 <= (for_1_for_for_mux_9_nl OR (fsm_output(51)))
            AND (NOT((fsm_output(54)) OR (fsm_output(11)) OR (fsm_output(10)) OR
            or_dcpl_216 OR or_dcpl_157 OR (fsm_output(33)) OR or_dcpl_239 OR (fsm_output(34))
            OR (fsm_output(52)) OR (fsm_output(13)) OR (fsm_output(37)) OR (fsm_output(36))
            OR or_dcpl_231 OR or_dcpl_173));
        for_2_for_for_for_for_for_stage_0_3 <= for_2_for_for_for_for_for_stage_0_2
            AND ((fsm_output(6)) OR (fsm_output(51)) OR (fsm_output(30)) OR for_1_for_for_or_3_cse);
        for_2_for_for_for_for_for_stage_0_4 <= for_1_for_for_mux1h_44_nl AND (NOT(or_dcpl_170
            OR or_dcpl_163 OR (fsm_output(36)) OR or_dcpl_232));
        for_2_for_for_for_for_for_acc_itm_1_13_6 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(SIGNED(for_2_for_for_for_for_for_acc_28_nl),
            8) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(i_3_6_0_sva), 7), 8), 8));
        reg_for_2_for_for_for_for_for_mul_itm_1_cse <= z_out_12(11 DOWNTO 10);
        y_asn_1_itm_2 <= for_7_for_for_for_for_land_lpi_6_dfm_st_1;
        for_2_for_for_for_for_for_acc_7_itm_1_7_0 <= STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(CONV_SIGNED(SIGNED(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(for_2_for_for_for_for_for_acc_27_nl),
            4)) & (for_2_for_for_for_for_for_acc_21_sdt_3_0_1(1 DOWNTO 0))), 6),
            8) + CONV_SIGNED(UNSIGNED(for_2_for_for_for_for_for_mul_7_nl), 8), 8));
        ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_and_itm
            <= MUX_v_5_2_2(STD_LOGIC_VECTOR'("00000"), ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_mux1h_16_nl,
            nor_69_nl);
        for_7_for_for_for_for_land_lpi_6_dfm_st_1 <= MUX1HOT_s_1_3_2(for_5_for_for_for_for_for_xor_cse,
            for_2_for_for_for_for_for_stage_0_4, for_7_for_for_for_for_land_lpi_6_dfm_st_1_mx0w4,
            STD_LOGIC_VECTOR'( for_1_for_for_or_1_cse & for_1_for_for_or_3_cse &
            (fsm_output(51))));
        ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_9_5
            <= z_out_2(9 DOWNTO 5);
        ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_4_0
            <= MUX1HOT_v_5_3_2(for_2_for_for_for_for_for_asn_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_1_4_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_and_nl,
            (z_out_2(4 DOWNTO 0)), ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_and_itm,
            STD_LOGIC_VECTOR'( nor_71_nl & ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_or_3_cse
            & for_1_for_for_or_1_cse));
        for_2_for_for_for_slc_for_2_for_for_for_acc_6_itm <= for_2_for_for_for_acc_13_nl(6);
        for_3_for_2_asn_itm_18_13 <= for_3_for_2_div_cmp_z(18 DOWNTO 13);
        ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_24_12_sva
            <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(z_out_11(19
            DOWNTO 11)), 9), 13) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED('1' & ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_9_5
            & ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_4_0
            & '1'), 12), 13), 13));
        reg_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_qr_cse
            <= z_out_10(31 DOWNTO 18);
        for_3_for_2_acc_9_psp_1_sva <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(for_3_for_2_mul_1_psp_1_sva_2(24
            DOWNTO 6)) + CONV_SIGNED(CONV_SIGNED(for_3_for_2_or_1_nl, 1), 19), 19));
        for_3_for_2_mul_1_psp_1_sva_5_0 <= for_3_for_2_mul_1_psp_1_sva_2(5 DOWNTO
            0);
        temp_11_0_lpi_7 <= MUX_v_12_2_2(STD_LOGIC_VECTOR'("000000000000"), temp_temp_mux1h_1_nl,
            not_220_nl);
        for_5_for_for_for_for_for_acc_25_itm_1_13_6 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(SIGNED(for_5_for_for_for_for_for_acc_36_nl),
            8) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(i_3_6_0_sva), 7), 8), 8));
        for_5_for_for_for_for_for_mul_itm_1_8_6 <= z_out_12(8 DOWNTO 6);
        for_5_for_for_for_for_for_mul_itm_1_2_0 <= z_out_12(2 DOWNTO 0);
        for_5_for_for_for_for_for_acc_7_sdt_sva_1_9_6 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_SIGNED(SIGNED(for_5_for_for_for_for_for_acc_sdt_1(5
            DOWNTO 4)), 2), 4) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(out_c_3_3_0_sva_2_0),
            3), 4), 4));
        for_5_for_for_for_for_for_acc_7_sdt_sva_1_5_2 <= for_5_for_for_for_for_for_acc_sdt_1(3
            DOWNTO 0);
        for_6_for_2_acc_9_psp_1_sva <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(for_6_for_2_mul_1_psp_1_sva_1(24
            DOWNTO 6)) + CONV_SIGNED(CONV_SIGNED(CONV_SIGNED(for_3_for_2_and_3_cse_1,
            1), 1), 19), 19));
        for_6_for_2_mul_1_psp_1_sva_5_0 <= for_6_for_2_mul_1_psp_1_sva_1(5 DOWNTO
            0);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp <= '0';
      ELSIF ( (run_wen AND (ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp_mx0c0
          OR (fsm_output(3)) OR (fsm_output(6)) OR ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp_mx0c3
          OR (fsm_output(14)) OR (fsm_output(15)) OR (fsm_output(27)) OR (fsm_output(30))
          OR (fsm_output(38)) OR (fsm_output(39)) OR (fsm_output(51)))) = '1' ) THEN
        ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp <= NOT((NOT(for_1_for_for_mux1h_42_nl
            OR ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp_mx0c0))
            OR ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp_mx0c3);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm
            <= STD_LOGIC_VECTOR'( "000000");
      ELSIF ( (run_wen AND (ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm_mx0c0
          OR ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm_mx0c1
          OR (fsm_output(6)) OR (fsm_output(15)) OR (fsm_output(30)) OR (fsm_output(39))))
          = '1' ) THEN
        ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm
            <= MUX_v_6_2_2(STD_LOGIC_VECTOR'("000000"), (ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux1h_6_nl
            & ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux1h_25_nl),
            ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_not_nl);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        in_c_1_1_0_sva <= STD_LOGIC_VECTOR'( "00");
      ELSIF ( (run_wen AND (in_c_1_1_0_sva_mx0c0 OR (fsm_output(11)) OR and_400_cse
          OR (fsm_output(30)))) = '1' ) THEN
        in_c_1_1_0_sva <= MUX_v_2_2_2(STD_LOGIC_VECTOR'("00"), in_c_mux_nl, in_c_not_nl);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        reg_j_2_ftd_1 <= STD_LOGIC_VECTOR'( "000000");
      ELSIF ( (run_wen AND (NOT or_480_itm)) = '1' ) THEN
        reg_j_2_ftd_1 <= MUX1HOT_v_6_3_2(for_1_for_for_1_for_and_nl, (z_out_3(5 DOWNTO
            0)), STD_LOGIC_VECTOR'( "000001"), STD_LOGIC_VECTOR'( or_478_nl & or_tmp_64
            & or_481_itm));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        temp_11_0_1_sva_1 <= STD_LOGIC_VECTOR'( "000000000000");
      ELSIF ( (run_wen AND (NOT (fsm_output(7))) AND for_2_for_for_for_for_for_stage_0_4)
          = '1' ) THEN
        temp_11_0_1_sva_1 <= temp_11_0_1_sva_1_mx1w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        out_c_2_3_0_sva_2_0 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (run_wen AND (and_409_cse OR or_dcpl_228 OR (fsm_output(5)) OR out_c_2_3_0_sva_2_0_mx0c1))
          = '1' ) THEN
        out_c_2_3_0_sva_2_0 <= MUX_v_3_2_2(STD_LOGIC_VECTOR'("000"), (out_c_2_3_0_sva_2(2
            DOWNTO 0)), out_c_2_3_0_sva_2_0_mx0c1);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        i_3_6_0_sva <= STD_LOGIC_VECTOR'( "0000000");
      ELSIF ( (run_wen AND (i_3_6_0_sva_mx0c0 OR i_3_6_0_sva_mx0c1 OR (fsm_output(39))))
          = '1' ) THEN
        i_3_6_0_sva <= MUX1HOT_v_7_4_2(STD_LOGIC_VECTOR'( "0000001"), i_3_6_0_sva_2,
            STD_LOGIC_VECTOR'( "1000000"), STD_LOGIC_VECTOR'( "0111111"), STD_LOGIC_VECTOR'(
            i_3_6_0_sva_mx0c0 & i_3_6_0_sva_mx0c1 & j_and_nl & j_or_1_nl));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        reg_x_1_sva_1_0_ftd <= '0';
        reg_x_1_sva_1_0_ftd_1 <= '0';
      ELSIF ( x_and_ssc = '1' ) THEN
        reg_x_1_sva_1_0_ftd <= x_1_sva_1_0_mx0c0;
        reg_x_1_sva_1_0_ftd_1 <= (NOT reg_x_1_sva_1_0_ftd_1) OR x_1_sva_1_0_mx0c0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        i_10_12_0_sva_11_0 <= STD_LOGIC_VECTOR'( "000000000000");
      ELSIF ( (run_wen AND (for_1_for_for_or_1_cse OR i_10_12_0_sva_11_0_mx0c1 OR
          (fsm_output(13)) OR i_10_12_0_sva_11_0_mx0c3 OR (fsm_output(37)) OR (fsm_output(38))
          OR (fsm_output(51)))) = '1' ) THEN
        i_10_12_0_sva_11_0 <= MUX_v_12_2_2(STD_LOGIC_VECTOR'("000000000000"), i_mux1h_19_nl,
            nor_70_nl);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        var_tmp_33_6_1_sva <= STD_LOGIC_VECTOR'( "0000000000000000000000000000");
      ELSIF ( (run_wen AND (or_dcpl_122 OR (fsm_output(14)))) = '1' ) THEN
        var_tmp_33_6_1_sva <= MUX_v_28_2_2(STD_LOGIC_VECTOR'("0000000000000000000000000000"),
            var_tmp_mux_nl, (fsm_output(14)));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        out_c_3_3_0_sva_2_0 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (run_wen AND (or_dcpl_231 OR ((out_c_3_3_0_sva_2(3)) AND or_dcpl_278)
          OR out_c_3_3_0_sva_2_0_mx0c1)) = '1' ) THEN
        out_c_3_3_0_sva_2_0 <= MUX_v_3_2_2(STD_LOGIC_VECTOR'("000"), (out_c_3_3_0_sva_2(2
            DOWNTO 0)), out_c_3_3_0_sva_2_0_mx0c1);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        for_3_for_2_asn_itm_12_0 <= STD_LOGIC_VECTOR'( "0000000000000");
      ELSIF ( (run_wen AND (NOT(or_dcpl_115 OR (fsm_output(20)) OR (fsm_output(44))
          OR or_dcpl_109 OR (fsm_output(18)) OR (fsm_output(42))))) = '1' ) THEN
        for_3_for_2_asn_itm_12_0 <= MUX_v_13_2_2(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(for_3_for_1_acc_4_nl),
            13)), (for_3_for_2_div_cmp_z(12 DOWNTO 0)), or_544_nl);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        i_11_12_0_sva_1_12 <= '0';
        i_11_12_0_sva_1_11_0 <= STD_LOGIC_VECTOR'( "000000000000");
      ELSIF ( i_and_2_ssc = '1' ) THEN
        i_11_12_0_sva_1_12 <= z_out_4(12);
        i_11_12_0_sva_1_11_0 <= MUX_v_12_2_2(for_2_for_for_for_for_2_for_for_for_and_1_nl,
            (z_out_4(11 DOWNTO 0)), ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_or_3_cse);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mul_psp_sva_13_11
            <= STD_LOGIC_VECTOR'( "000");
        ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mul_psp_sva_10_0
            <= STD_LOGIC_VECTOR'( "00000000000");
      ELSIF ( ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_and_2_cse
          = '1' ) THEN
        ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mul_psp_sva_13_11
            <= MUX_v_3_2_2((z_out_9(20 DOWNTO 18)), (ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_and_itm_mx0w0(13
            DOWNTO 11)), ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_normalized_fixed_temp_or_cse);
        ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mul_psp_sva_10_0
            <= MUX1HOT_v_11_3_2((z_out_9(17 DOWNTO 7)), (ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_and_itm_mx0w0(10
            DOWNTO 0)), (z_out_11(10 DOWNTO 0)), STD_LOGIC_VECTOR'( ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_nor_nl
            & ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_normalized_fixed_temp_or_cse
            & or_203_cse));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        temp_11_0_sva_1 <= STD_LOGIC_VECTOR'( "000000000000");
      ELSIF ( (run_wen AND (NOT (fsm_output(31))) AND for_2_for_for_for_for_for_stage_0_4)
          = '1' ) THEN
        temp_11_0_sva_1 <= temp_11_0_sva_1_mx1w0;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        var_tmp_33_6_sva <= STD_LOGIC_VECTOR'( "0000000000000000000000000000");
      ELSIF ( (run_wen AND ((fsm_output(38)) OR or_dcpl_278)) = '1' ) THEN
        var_tmp_33_6_sva <= MUX_v_28_2_2(STD_LOGIC_VECTOR'("0000000000000000000000000000"),
            var_tmp_mux_3_nl, (fsm_output(38)));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        reg_var_tmp_33_6_1_1_ftd <= STD_LOGIC_VECTOR'( "000000000");
      ELSIF ( (run_wen AND for_2_for_for_for_for_for_stage_0_3 AND (NOT(or_dcpl_115
          OR (fsm_output(20)) OR (fsm_output(23)) OR (fsm_output(22)) OR (fsm_output(21))
          OR (fsm_output(25)) OR (fsm_output(18)) OR (fsm_output(24)) OR (fsm_output(16))
          OR (fsm_output(15))))) = '1' ) THEN
        reg_var_tmp_33_6_1_1_ftd <= var_tmp_33_6_1_sva_1_mx1w0(27 DOWNTO 19);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        reg_var_tmp_33_6_1_ftd <= STD_LOGIC_VECTOR'( "000000000");
      ELSIF ( (run_wen AND for_2_for_for_for_for_for_stage_0_3 AND (NOT((fsm_output(44))
          OR (fsm_output(41)) OR (fsm_output(43)) OR or_dcpl_108 OR (fsm_output(47))
          OR (fsm_output(45)) OR (fsm_output(48)) OR (fsm_output(42)) OR (fsm_output(40))
          OR (fsm_output(39))))) = '1' ) THEN
        reg_var_tmp_33_6_1_ftd <= var_tmp_33_6_sva_1_mx1w0(27 DOWNTO 19);
      END IF;
    END IF;
  END PROCESS;
  or_325_nl <= or_dcpl_115 OR (fsm_output(20)) OR (fsm_output(23)) OR (fsm_output(22))
      OR (fsm_output(21)) OR (fsm_output(44)) OR or_dcpl_109 OR or_dcpl_108 OR (fsm_output(47))
      OR (fsm_output(45)) OR (fsm_output(25)) OR (fsm_output(59)) OR (fsm_output(48))
      OR (fsm_output(58)) OR (fsm_output(18)) OR (fsm_output(42)) OR (fsm_output(24))
      OR (fsm_output(16)) OR (fsm_output(40)) OR (fsm_output(2)) OR (fsm_output(15))
      OR or_dcpl_94 OR (fsm_output(14)) OR ((NOT((NOT(ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp
      AND for_2_for_for_for_for_for_stage_0_4)) AND for_1_for_for_stage_0_2)) AND
      or_dcpl_4);
  i_i_mux_1_nl <= MUX_v_14_2_2(z_out_14, i_1_13_0_sva, or_325_nl);
  nor_63_nl <= NOT((fsm_output(0)) OR (fsm_output(56)) OR (fsm_output(36)) OR or_dcpl_122
      OR (fsm_output(50)));
  operator_20_false_acc_1_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED('1' & (z_out_14(13
      DOWNTO 12))) + SIGNED'( "001"), 3));
  ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_and_1_nl
      <= (NOT (rtn_out(0))) AND or_79_cse;
  ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_and_1_nl
      <= (NOT (rtn_out(0))) AND or_cse;
  or_442_nl <= (fsm_output(58)) OR (fsm_output(16)) OR (fsm_output(40)) OR (fsm_output(51))
      OR (fsm_output(30));
  operator_20_false_mux1h_nl <= MUX1HOT_s_1_4_2((operator_20_false_acc_1_nl(2)),
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_and_1_nl,
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm, ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_and_1_nl,
      STD_LOGIC_VECTOR'( or_324_cse & (fsm_output(15)) & or_442_nl & (fsm_output(39))));
  for_1_for_for_mux_8_nl <= MUX_s_1_2_2(ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp,
      for_1_for_for_stage_0_2_mx0w2, for_1_for_for_or_1_cse);
  for_1_for_for_acc_17_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm),
      6), 7) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(for_1_for_for_acc_14_psp_1(6
      DOWNTO 5)), 2), 7), 7));
  j_j_mux_nl <= MUX_s_1_2_2((z_out_3(6)), reg_j_2_ftd, or_480_itm);
  temp_temp_nor_nl <= NOT(or_242_cse OR (fsm_output(7)));
  temp_and_3_nl <= or_242_cse AND (NOT (fsm_output(7)));
  temp_temp_mux1h_nl <= MUX1HOT_v_12_3_2(temp_11_0_1_sva_1_mx1w0, temp_11_0_1_lpi_7,
      temp_11_0_1_sva_1, STD_LOGIC_VECTOR'( temp_temp_nor_nl & temp_and_3_nl & (fsm_output(7))));
  nor_66_nl <= NOT(or_dcpl_168 OR (fsm_output(9)) OR or_dcpl_223);
  y_mux_nl <= MUX_s_1_2_2(y_1_1_0_sva_0, (NOT y_1_1_0_sva_0), for_1_for_for_stage_0_2);
  for_1_for_for_mux_9_nl <= MUX_s_1_2_2(for_1_for_for_stage_0_2, ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp,
      for_1_for_for_or_3_cse);
  or_510_nl <= or_dcpl_4 OR (fsm_output(38));
  for_1_for_for_mux1h_44_nl <= MUX1HOT_s_1_4_2(for_2_for_for_for_for_for_stage_0_3,
      (z_out_4(12)), (z_out_4(12)), for_7_for_for_for_for_land_lpi_6_dfm_st_1_mx0w4,
      STD_LOGIC_VECTOR'( for_1_for_for_or_1_cse & or_510_nl & (fsm_output(14)) &
      (fsm_output(51))));
  for_2_for_for_for_for_for_acc_28_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(CONV_SIGNED(SIGNED(for_2_for_for_for_for_for_acc_17_sdt_1_8_1(7
      DOWNTO 5)), 3), 4) + CONV_SIGNED(CONV_SIGNED(SIGNED'( reg_x_1_sva_1_0_ftd &
      reg_x_1_sva_1_0_ftd_1), 2), 4), 4));
  for_2_for_for_for_for_for_acc_27_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(CONV_SIGNED(SIGNED(for_2_for_for_for_for_for_acc_21_sdt_3_0_1(3
      DOWNTO 2)), 2), 4) + CONV_SIGNED(CONV_UNSIGNED(UNSIGNED(in_c_1_1_0_sva & '1'),
      3), 4), 4));
  for_2_for_for_for_for_for_mul_7_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED'(
      UNSIGNED(out_c_2_3_0_sva_2_0) * UNSIGNED'( "11011")), 8));
  ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qif_acc_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED('1'
      & (NOT (rtn_out(4 DOWNTO 1)))) + UNSIGNED'( "01001"), 5));
  ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qif_acc_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED('1'
      & (NOT (rtn_out(4 DOWNTO 1)))) + UNSIGNED'( "01001"), 5));
  or_515_nl <= (fsm_output(54)) OR (fsm_output(16)) OR (fsm_output(40)) OR (fsm_output(52))
      OR (fsm_output(51)) OR (fsm_output(53));
  ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_mux1h_16_nl <= MUX1HOT_v_5_5_2(data_out_out,
      STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qif_acc_nl),
      5)), ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_and_itm,
      STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qif_acc_nl),
      5)), (i_12_5_0_sva_2(4 DOWNTO 0)), STD_LOGIC_VECTOR'( for_1_for_for_or_1_cse
      & (fsm_output(15)) & or_515_nl & (fsm_output(39)) & (fsm_output(55))));
  nor_69_nl <= NOT(or_dcpl_151 OR ((NOT or_79_cse) AND (fsm_output(15))) OR ((NOT
      or_cse) AND (fsm_output(39))));
  ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_mux_nl
      <= MUX_v_5_2_2(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_4_0,
      (reg_j_2_ftd_1(4 DOWNTO 0)), fsm_output(54));
  nand_17_nl <= NOT((NOT((fsm_output(54)) OR (fsm_output(6)))) AND (NOT(CONV_SL_1_1(fsm_output(52
      DOWNTO 51)/=STD_LOGIC_VECTOR'("00")))));
  for_2_for_for_for_for_for_asn_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_1_4_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_and_nl
      <= MUX_v_5_2_2(STD_LOGIC_VECTOR'("00000"), ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_mux_nl,
      nand_17_nl);
  nor_71_nl <= NOT(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_or_3_cse
      OR for_1_for_for_or_1_cse);
  for_2_for_for_for_acc_13_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(z_out_3(6 DOWNTO
      0)) + SIGNED'( "0111111"), 7));
  for_3_for_2_or_1_nl <= (NOT(CONV_SL_1_1(out_c_3_3_0_sva_2_0/=STD_LOGIC_VECTOR'("000"))))
      OR for_3_for_2_and_cse_1 OR for_3_for_2_and_2_cse_1 OR for_3_for_2_and_3_cse_1;
  temp_temp_nor_1_nl <= NOT(or_242_cse OR (fsm_output(31)));
  temp_and_5_nl <= or_242_cse AND (NOT (fsm_output(31)));
  temp_temp_mux1h_1_nl <= MUX1HOT_v_12_3_2(temp_11_0_sva_1_mx1w0, temp_11_0_lpi_7,
      temp_11_0_sva_1, STD_LOGIC_VECTOR'( temp_temp_nor_1_nl & temp_and_5_nl & (fsm_output(31))));
  not_220_nl <= NOT or_tmp_134;
  for_5_for_for_for_for_for_acc_37_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(CONV_SIGNED(CONV_SIGNED(for_5_for_for_for_for_for_acc_23_sdt_1(8),
      1), 1), 2) + CONV_SIGNED(CONV_UNSIGNED(CONV_UNSIGNED(NOT ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm,
      1), 1), 2), 2));
  for_5_for_for_for_for_for_acc_36_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(for_5_for_for_for_for_for_acc_37_nl),
      2)) & (for_5_for_for_for_for_for_acc_23_sdt_1(7 DOWNTO 6))) + CONV_SIGNED(CONV_SIGNED(SIGNED'(
      '1' & reg_x_1_sva_1_0_ftd & reg_x_1_sva_1_0_ftd_1), 3), 4), 4));
  ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_and_1_nl
      <= ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp AND
      (NOT (z_out_7(6)));
  ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_and_2_nl
      <= ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp AND
      (NOT (z_out_4(12)));
  ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_and_4_nl
      <= ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp AND
      (NOT for_2_for_for_for_for_for_stage_0_2);
  for_1_for_for_mux1h_42_nl <= MUX1HOT_s_1_6_2(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_and_1_nl,
      for_1_for_for_stage_0_2_mx0w2, ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_and_2_nl,
      or_79_cse, or_cse, ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_and_4_nl,
      STD_LOGIC_VECTOR'( for_1_for_for_or_cse & for_1_for_for_or_1_cse & for_1_for_for_or_3_cse
      & (fsm_output(15)) & (fsm_output(39)) & (fsm_output(51))));
  ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux1h_6_nl
      <= MUX1HOT_v_5_4_2((i_2_6_0_sva_2(5 DOWNTO 1)), (for_2_for_for_for_for_for_acc_17_sdt_1_8_1(4
      DOWNTO 0)), (z_out_1(5 DOWNTO 1)), (for_5_for_for_for_for_for_acc_23_sdt_1(5
      DOWNTO 1)), STD_LOGIC_VECTOR'( ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm_mx0c1
      & (fsm_output(6)) & ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_or_3_cse
      & (fsm_output(30))));
  ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux1h_25_nl
      <= MUX1HOT_s_1_4_2((i_2_6_0_sva_2(0)), (z_out_3(0)), (z_out_1(0)), (for_5_for_for_for_for_for_acc_23_sdt_1(0)),
      STD_LOGIC_VECTOR'( ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm_mx0c1
      & (fsm_output(6)) & ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_or_3_cse
      & (fsm_output(30))));
  ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_not_nl
      <= NOT ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm_mx0c0;
  in_c_mux_nl <= MUX_v_2_2_2(out_c_1_1_0_sva_2, (for_5_for_for_for_for_for_acc_19_sdt_1(1
      DOWNTO 0)), fsm_output(30));
  in_c_not_nl <= NOT in_c_1_1_0_sva_mx0c0;
  for_7_for_for_acc_3_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_4_0),
      5), 6) + UNSIGNED'( "000001"), 6));
  for_1_for_mux_nl <= MUX_v_6_2_2((z_out_7(5 DOWNTO 0)), STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(for_7_for_for_acc_3_nl),
      6)), fsm_output(53));
  j_or_nl <= (fsm_output(3)) OR (fsm_output(27)) OR (fsm_output(53));
  for_1_for_for_1_for_and_nl <= MUX_v_6_2_2(STD_LOGIC_VECTOR'("000000"), for_1_for_mux_nl,
      j_or_nl);
  or_478_nl <= (fsm_output(3)) OR (fsm_output(28)) OR (fsm_output(27)) OR (fsm_output(4))
      OR (fsm_output(53)) OR (fsm_output(2)) OR (fsm_output(26)) OR and_399_cse OR
      and_400_cse;
  j_and_nl <= j_j_nor_cse AND (fsm_output(39));
  j_or_1_nl <= (CONV_SL_1_1(out_c_3_3_0_sva_2_0(1 DOWNTO 0)=STD_LOGIC_VECTOR'("01"))
      AND (fsm_output(39))) OR (CONV_SL_1_1(out_c_3_3_0_sva_2_0(1 DOWNTO 0)=STD_LOGIC_VECTOR'("10"))
      AND (fsm_output(39))) OR (CONV_SL_1_1(out_c_3_3_0_sva_2_0(1 DOWNTO 0)=STD_LOGIC_VECTOR'("11"))
      AND (fsm_output(39)));
  i_or_8_nl <= (fsm_output(13)) OR i_or_7_cse;
  i_and_4_nl <= (NOT or_288_tmp) AND (fsm_output(51));
  i_and_5_nl <= or_288_tmp AND (fsm_output(51));
  i_mux1h_19_nl <= MUX1HOT_v_12_5_2(padded_input_rsci_q_d, (z_out_4(11 DOWNTO 0)),
      i_11_12_0_sva_1_11_0, enc1_rsci_q_d, i_10_12_0_sva_11_0, STD_LOGIC_VECTOR'(
      for_1_for_for_or_1_cse & i_or_8_nl & i_10_12_0_sva_11_0_mx0c3 & i_and_4_nl
      & i_and_5_nl));
  nor_70_nl <= NOT(i_10_12_0_sva_11_0_mx0c1 OR ((NOT ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp)
      AND i_or_7_cse));
  var_tmp_mux_nl <= MUX_v_28_2_2(var_tmp_33_6_1_sva_1_mx1w0, var_tmp_33_6_1_sva,
      or_dcpl_277);
  for_3_for_1_acc_4_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(CONV_SIGNED(SIGNED(buf2_rsci_q_d),
      12), 13) + CONV_SIGNED(CONV_SIGNED(SIGNED('1' & (NOT (i_1_13_0_sva(13 DOWNTO
      12)))), 3), 13) + SIGNED'( "0000000000001"), 13));
  or_544_nl <= (fsm_output(22)) OR (fsm_output(46));
  for_2_for_for_for_for_2_for_for_for_and_1_nl <= MUX_v_12_2_2(STD_LOGIC_VECTOR'("000000000000"),
      (z_out_4(11 DOWNTO 0)), (fsm_output(14)));
  ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_nor_nl
      <= NOT(ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_normalized_fixed_temp_or_cse
      OR or_203_cse);
  var_tmp_mux_3_nl <= MUX_v_28_2_2(var_tmp_33_6_sva_1_mx1w0, var_tmp_33_6_sva, or_dcpl_277);
  for_2_for_for_for_for_2_for_for_for_and_4_nl <= ((reg_x_1_sva_1_0_ftd_1 AND y_1_1_0_sva_1)
      XOR reg_x_1_sva_1_0_ftd XOR y_1_1_0_sva_1) AND (fsm_output(6));
  for_2_for_for_for_for_2_for_for_for_and_5_nl <= (reg_x_1_sva_1_0_ftd_1 XOR y_1_1_0_sva_1)
      AND (fsm_output(6));
  for_2_for_for_for_for_2_for_for_for_or_1_nl <= y_1_1_0_sva_0 OR (NOT (fsm_output(6)));
  z_out_3 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(reg_j_2_ftd
      & reg_j_2_ftd_1), 7), 8) + CONV_UNSIGNED(CONV_SIGNED(SIGNED'( for_2_for_for_for_for_2_for_for_for_and_4_nl
      & for_2_for_for_for_for_2_for_for_for_and_5_nl & for_2_for_for_for_for_2_for_for_for_or_1_nl),
      3), 8), 8));
  for_3_for_mux_3_nl <= MUX_v_12_2_2(i_10_12_0_sva_11_0, i_11_12_0_sva_1_11_0, fsm_output(14));
  z_out_4 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(for_3_for_mux_3_nl),
      13) + UNSIGNED'( "0000000000001"), 13));
  z_out_7 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(reg_j_2_ftd_1),
      6), 7) + CONV_UNSIGNED(CONV_SIGNED(SIGNED'( or_tmp_64 & '1'), 2), 7), 7));
  operator_40_20_false_AC_TRN_AC_WRAP_mux_4_nl <= MUX_v_19_2_2((NOT for_3_for_2_acc_9_psp_1_sva),
      (NOT for_6_for_2_acc_9_psp_1_sva), fsm_output(48));
  operator_40_20_false_AC_TRN_AC_WRAP_mux_5_nl <= MUX_v_6_2_2((NOT for_3_for_2_mul_1_psp_1_sva_5_0),
      (NOT for_6_for_2_mul_1_psp_1_sva_5_0), fsm_output(48));
  operator_40_20_false_AC_TRN_AC_WRAP_acc_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED('1'
      & STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(operator_40_20_false_AC_TRN_AC_WRAP_mux_4_nl),26))
      & operator_40_20_false_AC_TRN_AC_WRAP_mux_5_nl) + UNSIGNED'( "000000000000000000000000000000001"),
      33));
  z_out_8_32 <= operator_40_20_false_AC_TRN_AC_WRAP_acc_nl(32);
  ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux_3_nl
      <= MUX_s_1_2_2((i_10_12_0_sva_11_0(11)), (for_3_for_2_asn_itm_12_0(12)), for_1_for_for_or_3_cse);
  ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_and_1_nl
      <= ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux_3_nl
      AND (NOT or_203_cse);
  ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux1h_6_nl
      <= MUX1HOT_s_1_3_2((ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mul_psp_sva_13_11(0)),
      (i_10_12_0_sva_11_0(11)), (for_3_for_2_asn_itm_12_0(11)), STD_LOGIC_VECTOR'(
      or_203_cse & for_1_for_for_or_1_cse & for_1_for_for_or_3_cse));
  ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux1h_7_nl
      <= MUX1HOT_v_11_3_2(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mul_psp_sva_10_0,
      (i_10_12_0_sva_11_0(10 DOWNTO 0)), (for_3_for_2_asn_itm_12_0(10 DOWNTO 0)),
      STD_LOGIC_VECTOR'( or_203_cse & for_1_for_for_or_1_cse & for_1_for_for_or_3_cse));
  ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux1h_8_nl
      <= MUX1HOT_v_7_3_2(STD_LOGIC_VECTOR'( "0000010"), STD_LOGIC_VECTOR(CONV_SIGNED(CONV_SIGNED(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_4_0(4),
      1),7)), (for_3_for_2_asn_itm_12_0(12 DOWNTO 6)), STD_LOGIC_VECTOR'( or_203_cse
      & for_1_for_for_or_1_cse & for_1_for_for_or_3_cse));
  ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux1h_9_nl
      <= MUX1HOT_v_6_3_2(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm,
      STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_4_0),6)),
      (for_3_for_2_asn_itm_12_0(5 DOWNTO 0)), STD_LOGIC_VECTOR'( or_203_cse & for_1_for_for_or_1_cse
      & for_1_for_for_or_3_cse));
  z_out_11 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(SIGNED'( SIGNED(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_and_1_nl
      & ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux1h_6_nl
      & ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux1h_7_nl)
      * SIGNED(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux1h_8_nl
      & ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux1h_9_nl)),
      24));
  for_1_for_for_for_1_for_for_and_2_atp <= (out_c_2_3_0_sva_2_0(2)) AND or_601_itm;
  for_1_for_for_mux_11_nl <= MUX_v_2_2_2(in_c_1_1_0_sva, (out_c_2_3_0_sva_2_0(1 DOWNTO
      0)), or_601_itm);
  for_1_for_for_mul_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED'( UNSIGNED(for_1_for_for_mux_11_nl)
      * UNSIGNED'( "10001000001")), 12));
  z_out_12 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(for_1_for_for_mul_nl),
      12) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(for_1_for_for_for_1_for_for_and_2_atp
      & STD_LOGIC_VECTOR'( "00000") & for_1_for_for_for_1_for_for_and_2_atp & STD_LOGIC_VECTOR'(
      "00")), 9), 12), 12));
  for_3_for_mux_4_nl <= MUX_v_12_2_2(buf2_rsci_q_d, STD_LOGIC_VECTOR'( "000000000001"),
      or_324_cse);
  z_out_14 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(i_1_13_0_sva) + CONV_UNSIGNED(SIGNED(for_3_for_mux_4_nl),
      14), 14));
  z_out_1 <= MUX_v_6_4_2(STD_LOGIC_VECTOR'( "101011"), STD_LOGIC_VECTOR'( "011010"),
      STD_LOGIC_VECTOR'( "001110"), STD_LOGIC_VECTOR'( "000100"), z_out_9(20 DOWNTO
      19));
  z_out_2 <= MUX_v_10_4_2(STD_LOGIC_VECTOR'( "0110101001"), STD_LOGIC_VECTOR'( "1001010100"),
      STD_LOGIC_VECTOR'( "1011101110"), STD_LOGIC_VECTOR'( "1101111100"), z_out_9(20
      DOWNTO 19));
END v4;

-- ------------------------------------------------------------------
--  Design Unit:    UNET_IP_main
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_wait_pkg_v1.ALL;
USE work.ccs_out_wait_pkg_v1.ALL;
USE work.mgc_comps.ALL;
USE work.mgc_shift_comps_v5.ALL;
USE work.BLOCK_1R1W_RBW_pkg.ALL;


ENTITY UNET_IP_main IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    input_rsc_dat : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    input_rsc_vld : IN STD_LOGIC;
    input_rsc_rdy : OUT STD_LOGIC;
    output_rsc_dat : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
    output_rsc_vld : OUT STD_LOGIC;
    output_rsc_rdy : IN STD_LOGIC
  );
END UNET_IP_main;

ARCHITECTURE v4 OF UNET_IP_main IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL buf1_rsci_clken_d : STD_LOGIC;
  SIGNAL buf1_rsci_d_d : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL buf1_rsci_q_d : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL buf1_rsci_radr_d : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL buf1_rsci_wadr_d : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL padded_input_rsci_q_d : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL padded_input_rsci_radr_d : STD_LOGIC_VECTOR (13 DOWNTO 0);
  SIGNAL padded_input_rsci_wadr_d : STD_LOGIC_VECTOR (13 DOWNTO 0);
  SIGNAL buf2_rsci_d_d : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL buf2_rsci_q_d : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL buf2_rsci_radr_d : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL buf2_rsci_wadr_d : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL enc1_rsci_d_d : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL enc1_rsci_q_d : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL enc1_rsci_radr_d : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL enc1_rsci_wadr_d : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL buf1_rsc_clken : STD_LOGIC;
  SIGNAL buf1_rsc_q : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL buf1_rsc_re : STD_LOGIC;
  SIGNAL buf1_rsc_radr : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL buf1_rsc_we : STD_LOGIC;
  SIGNAL buf1_rsc_d : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL buf1_rsc_wadr : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL padded_input_rsc_clken : STD_LOGIC;
  SIGNAL padded_input_rsc_q : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL padded_input_rsc_re : STD_LOGIC;
  SIGNAL padded_input_rsc_radr : STD_LOGIC_VECTOR (13 DOWNTO 0);
  SIGNAL padded_input_rsc_we : STD_LOGIC;
  SIGNAL padded_input_rsc_d : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL padded_input_rsc_wadr : STD_LOGIC_VECTOR (13 DOWNTO 0);
  SIGNAL buf2_rsc_clken : STD_LOGIC;
  SIGNAL buf2_rsc_q : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL buf2_rsc_re : STD_LOGIC;
  SIGNAL buf2_rsc_radr : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL buf2_rsc_we : STD_LOGIC;
  SIGNAL buf2_rsc_d : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL buf2_rsc_wadr : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL enc1_rsc_clken : STD_LOGIC;
  SIGNAL enc1_rsc_q : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL enc1_rsc_re : STD_LOGIC;
  SIGNAL enc1_rsc_radr : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL enc1_rsc_we : STD_LOGIC;
  SIGNAL enc1_rsc_d : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL enc1_rsc_wadr : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL buf1_rsci_re_d_iff : STD_LOGIC;
  SIGNAL buf1_rsci_we_d_iff : STD_LOGIC;
  SIGNAL padded_input_rsci_re_d_iff : STD_LOGIC;
  SIGNAL padded_input_rsci_we_d_iff : STD_LOGIC;
  SIGNAL buf2_rsci_re_d_iff : STD_LOGIC;
  SIGNAL buf2_rsci_we_d_iff : STD_LOGIC;
  SIGNAL enc1_rsci_re_d_iff : STD_LOGIC;
  SIGNAL enc1_rsci_we_d_iff : STD_LOGIC;

  SIGNAL buf1_rsc_comp_d : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL buf1_rsc_comp_q : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL buf1_rsc_comp_radr : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL buf1_rsc_comp_wadr : STD_LOGIC_VECTOR (14 DOWNTO 0);

  SIGNAL padded_input_rsc_comp_d : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL padded_input_rsc_comp_q : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL padded_input_rsc_comp_radr : STD_LOGIC_VECTOR (13 DOWNTO 0);
  SIGNAL padded_input_rsc_comp_wadr : STD_LOGIC_VECTOR (13 DOWNTO 0);

  SIGNAL buf2_rsc_comp_d : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL buf2_rsc_comp_q : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL buf2_rsc_comp_radr : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL buf2_rsc_comp_wadr : STD_LOGIC_VECTOR (14 DOWNTO 0);

  SIGNAL enc1_rsc_comp_d : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL enc1_rsc_comp_q : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL enc1_rsc_comp_radr : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL enc1_rsc_comp_wadr : STD_LOGIC_VECTOR (14 DOWNTO 0);

  COMPONENT UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_3_15_12_32768_1_32768_12_1_gen
    PORT(
      clken : OUT STD_LOGIC;
      q : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      re : OUT STD_LOGIC;
      radr : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
      we : OUT STD_LOGIC;
      d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
      wadr : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
      clken_d : IN STD_LOGIC;
      d_d : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      q_d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
      radr_d : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
      re_d : IN STD_LOGIC;
      wadr_d : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
      we_d : IN STD_LOGIC;
      writeA_w_ram_ir_internal_WMASK_B_d : IN STD_LOGIC;
      readA_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL buf1_rsci_q : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL buf1_rsci_radr : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL buf1_rsci_d : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL buf1_rsci_wadr : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL buf1_rsci_d_d_1 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL buf1_rsci_q_d_1 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL buf1_rsci_radr_d_1 : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL buf1_rsci_wadr_d_1 : STD_LOGIC_VECTOR (14 DOWNTO 0);

  COMPONENT UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_4_14_12_13068_1_13068_12_1_gen
    PORT(
      clken : OUT STD_LOGIC;
      q : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      re : OUT STD_LOGIC;
      radr : OUT STD_LOGIC_VECTOR (13 DOWNTO 0);
      we : OUT STD_LOGIC;
      d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
      wadr : OUT STD_LOGIC_VECTOR (13 DOWNTO 0);
      clken_d : IN STD_LOGIC;
      d_d : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      q_d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
      radr_d : IN STD_LOGIC_VECTOR (13 DOWNTO 0);
      re_d : IN STD_LOGIC;
      wadr_d : IN STD_LOGIC_VECTOR (13 DOWNTO 0);
      we_d : IN STD_LOGIC;
      writeA_w_ram_ir_internal_WMASK_B_d : IN STD_LOGIC;
      readA_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL padded_input_rsci_q : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL padded_input_rsci_radr : STD_LOGIC_VECTOR (13 DOWNTO 0);
  SIGNAL padded_input_rsci_d : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL padded_input_rsci_wadr : STD_LOGIC_VECTOR (13 DOWNTO 0);
  SIGNAL padded_input_rsci_d_d : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL padded_input_rsci_q_d_1 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL padded_input_rsci_radr_d_1 : STD_LOGIC_VECTOR (13 DOWNTO 0);
  SIGNAL padded_input_rsci_wadr_d_1 : STD_LOGIC_VECTOR (13 DOWNTO 0);

  COMPONENT UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_5_15_12_32768_1_32768_12_1_gen
    PORT(
      clken : OUT STD_LOGIC;
      q : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      re : OUT STD_LOGIC;
      radr : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
      we : OUT STD_LOGIC;
      d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
      wadr : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
      clken_d : IN STD_LOGIC;
      d_d : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      q_d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
      radr_d : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
      re_d : IN STD_LOGIC;
      wadr_d : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
      we_d : IN STD_LOGIC;
      writeA_w_ram_ir_internal_WMASK_B_d : IN STD_LOGIC;
      readA_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL buf2_rsci_q : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL buf2_rsci_radr : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL buf2_rsci_d : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL buf2_rsci_wadr : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL buf2_rsci_d_d_1 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL buf2_rsci_q_d_1 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL buf2_rsci_radr_d_1 : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL buf2_rsci_wadr_d_1 : STD_LOGIC_VECTOR (14 DOWNTO 0);

  COMPONENT UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_6_15_12_32768_1_32768_12_1_gen
    PORT(
      clken : OUT STD_LOGIC;
      q : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      re : OUT STD_LOGIC;
      radr : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
      we : OUT STD_LOGIC;
      d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
      wadr : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
      clken_d : IN STD_LOGIC;
      d_d : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      q_d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
      radr_d : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
      re_d : IN STD_LOGIC;
      wadr_d : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
      we_d : IN STD_LOGIC;
      writeA_w_ram_ir_internal_WMASK_B_d : IN STD_LOGIC;
      readA_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL enc1_rsci_q : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL enc1_rsci_radr : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL enc1_rsci_d : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL enc1_rsci_wadr : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL enc1_rsci_d_d_1 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL enc1_rsci_q_d_1 : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL enc1_rsci_radr_d_1 : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL enc1_rsci_wadr_d_1 : STD_LOGIC_VECTOR (14 DOWNTO 0);

  COMPONENT UNET_IP_main_run
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      input_rsc_dat : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      input_rsc_vld : IN STD_LOGIC;
      input_rsc_rdy : OUT STD_LOGIC;
      output_rsc_dat : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
      output_rsc_vld : OUT STD_LOGIC;
      output_rsc_rdy : IN STD_LOGIC;
      buf1_rsci_clken_d : OUT STD_LOGIC;
      buf1_rsci_d_d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
      buf1_rsci_q_d : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      buf1_rsci_radr_d : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
      buf1_rsci_wadr_d : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
      padded_input_rsci_q_d : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      padded_input_rsci_radr_d : OUT STD_LOGIC_VECTOR (13 DOWNTO 0);
      padded_input_rsci_wadr_d : OUT STD_LOGIC_VECTOR (13 DOWNTO 0);
      buf2_rsci_d_d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
      buf2_rsci_q_d : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      buf2_rsci_radr_d : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
      buf2_rsci_wadr_d : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
      enc1_rsci_d_d : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
      enc1_rsci_q_d : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      enc1_rsci_radr_d : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
      enc1_rsci_wadr_d : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
      buf1_rsci_re_d_pff : OUT STD_LOGIC;
      buf1_rsci_we_d_pff : OUT STD_LOGIC;
      padded_input_rsci_re_d_pff : OUT STD_LOGIC;
      padded_input_rsci_we_d_pff : OUT STD_LOGIC;
      buf2_rsci_re_d_pff : OUT STD_LOGIC;
      buf2_rsci_we_d_pff : OUT STD_LOGIC;
      enc1_rsci_re_d_pff : OUT STD_LOGIC;
      enc1_rsci_we_d_pff : OUT STD_LOGIC
    );
  END COMPONENT;
  SIGNAL UNET_IP_main_run_inst_input_rsc_dat : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL UNET_IP_main_run_inst_output_rsc_dat : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL UNET_IP_main_run_inst_buf1_rsci_d_d : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL UNET_IP_main_run_inst_buf1_rsci_q_d : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL UNET_IP_main_run_inst_buf1_rsci_radr_d : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL UNET_IP_main_run_inst_buf1_rsci_wadr_d : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL UNET_IP_main_run_inst_padded_input_rsci_q_d : STD_LOGIC_VECTOR (11 DOWNTO
      0);
  SIGNAL UNET_IP_main_run_inst_padded_input_rsci_radr_d : STD_LOGIC_VECTOR (13 DOWNTO
      0);
  SIGNAL UNET_IP_main_run_inst_padded_input_rsci_wadr_d : STD_LOGIC_VECTOR (13 DOWNTO
      0);
  SIGNAL UNET_IP_main_run_inst_buf2_rsci_d_d : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL UNET_IP_main_run_inst_buf2_rsci_q_d : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL UNET_IP_main_run_inst_buf2_rsci_radr_d : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL UNET_IP_main_run_inst_buf2_rsci_wadr_d : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL UNET_IP_main_run_inst_enc1_rsci_d_d : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL UNET_IP_main_run_inst_enc1_rsci_q_d : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL UNET_IP_main_run_inst_enc1_rsci_radr_d : STD_LOGIC_VECTOR (14 DOWNTO 0);
  SIGNAL UNET_IP_main_run_inst_enc1_rsci_wadr_d : STD_LOGIC_VECTOR (14 DOWNTO 0);

BEGIN
  buf1_rsc_comp : work.block_1r1w_rbw_pkg.BLOCK_1R1W_RBW
    GENERIC MAP(
      addr_width => 15,
      data_width => 12,
      depth => 32768,
      latency => 1,
      suppress_sim_read_addr_range_errs => 1
      )
    PORT MAP(
      clk => clk,
      clken => buf1_rsc_clken,
      d => buf1_rsc_comp_d,
      q => buf1_rsc_comp_q,
      radr => buf1_rsc_comp_radr,
      re => buf1_rsc_re,
      wadr => buf1_rsc_comp_wadr,
      we => buf1_rsc_we
    );
  buf1_rsc_comp_d <= buf1_rsc_d;
  buf1_rsc_q <= buf1_rsc_comp_q;
  buf1_rsc_comp_radr <= buf1_rsc_radr;
  buf1_rsc_comp_wadr <= buf1_rsc_wadr;

  padded_input_rsc_comp : work.block_1r1w_rbw_pkg.BLOCK_1R1W_RBW
    GENERIC MAP(
      addr_width => 14,
      data_width => 12,
      depth => 13068,
      latency => 1,
      suppress_sim_read_addr_range_errs => 1
      )
    PORT MAP(
      clk => clk,
      clken => padded_input_rsc_clken,
      d => padded_input_rsc_comp_d,
      q => padded_input_rsc_comp_q,
      radr => padded_input_rsc_comp_radr,
      re => padded_input_rsc_re,
      wadr => padded_input_rsc_comp_wadr,
      we => padded_input_rsc_we
    );
  padded_input_rsc_comp_d <= padded_input_rsc_d;
  padded_input_rsc_q <= padded_input_rsc_comp_q;
  padded_input_rsc_comp_radr <= padded_input_rsc_radr;
  padded_input_rsc_comp_wadr <= padded_input_rsc_wadr;

  buf2_rsc_comp : work.block_1r1w_rbw_pkg.BLOCK_1R1W_RBW
    GENERIC MAP(
      addr_width => 15,
      data_width => 12,
      depth => 32768,
      latency => 1,
      suppress_sim_read_addr_range_errs => 1
      )
    PORT MAP(
      clk => clk,
      clken => buf2_rsc_clken,
      d => buf2_rsc_comp_d,
      q => buf2_rsc_comp_q,
      radr => buf2_rsc_comp_radr,
      re => buf2_rsc_re,
      wadr => buf2_rsc_comp_wadr,
      we => buf2_rsc_we
    );
  buf2_rsc_comp_d <= buf2_rsc_d;
  buf2_rsc_q <= buf2_rsc_comp_q;
  buf2_rsc_comp_radr <= buf2_rsc_radr;
  buf2_rsc_comp_wadr <= buf2_rsc_wadr;

  enc1_rsc_comp : work.block_1r1w_rbw_pkg.BLOCK_1R1W_RBW
    GENERIC MAP(
      addr_width => 15,
      data_width => 12,
      depth => 32768,
      latency => 1,
      suppress_sim_read_addr_range_errs => 1
      )
    PORT MAP(
      clk => clk,
      clken => enc1_rsc_clken,
      d => enc1_rsc_comp_d,
      q => enc1_rsc_comp_q,
      radr => enc1_rsc_comp_radr,
      re => enc1_rsc_re,
      wadr => enc1_rsc_comp_wadr,
      we => enc1_rsc_we
    );
  enc1_rsc_comp_d <= enc1_rsc_d;
  enc1_rsc_q <= enc1_rsc_comp_q;
  enc1_rsc_comp_radr <= enc1_rsc_radr;
  enc1_rsc_comp_wadr <= enc1_rsc_wadr;

  buf1_rsci : UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_3_15_12_32768_1_32768_12_1_gen
    PORT MAP(
      clken => buf1_rsc_clken,
      q => buf1_rsci_q,
      re => buf1_rsc_re,
      radr => buf1_rsci_radr,
      we => buf1_rsc_we,
      d => buf1_rsci_d,
      wadr => buf1_rsci_wadr,
      clken_d => buf1_rsci_clken_d,
      d_d => buf1_rsci_d_d_1,
      q_d => buf1_rsci_q_d_1,
      radr_d => buf1_rsci_radr_d_1,
      re_d => buf1_rsci_re_d_iff,
      wadr_d => buf1_rsci_wadr_d_1,
      we_d => buf1_rsci_we_d_iff,
      writeA_w_ram_ir_internal_WMASK_B_d => buf1_rsci_we_d_iff,
      readA_r_ram_ir_internal_RMASK_B_d => buf1_rsci_re_d_iff
    );
  buf1_rsci_q <= buf1_rsc_q;
  buf1_rsc_radr <= buf1_rsci_radr;
  buf1_rsc_d <= buf1_rsci_d;
  buf1_rsc_wadr <= buf1_rsci_wadr;
  buf1_rsci_d_d_1 <= buf1_rsci_d_d;
  buf1_rsci_q_d <= buf1_rsci_q_d_1;
  buf1_rsci_radr_d_1 <= buf1_rsci_radr_d;
  buf1_rsci_wadr_d_1 <= buf1_rsci_wadr_d;

  padded_input_rsci : UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_4_14_12_13068_1_13068_12_1_gen
    PORT MAP(
      clken => padded_input_rsc_clken,
      q => padded_input_rsci_q,
      re => padded_input_rsc_re,
      radr => padded_input_rsci_radr,
      we => padded_input_rsc_we,
      d => padded_input_rsci_d,
      wadr => padded_input_rsci_wadr,
      clken_d => buf1_rsci_clken_d,
      d_d => padded_input_rsci_d_d,
      q_d => padded_input_rsci_q_d_1,
      radr_d => padded_input_rsci_radr_d_1,
      re_d => padded_input_rsci_re_d_iff,
      wadr_d => padded_input_rsci_wadr_d_1,
      we_d => padded_input_rsci_we_d_iff,
      writeA_w_ram_ir_internal_WMASK_B_d => padded_input_rsci_we_d_iff,
      readA_r_ram_ir_internal_RMASK_B_d => padded_input_rsci_re_d_iff
    );
  padded_input_rsci_q <= padded_input_rsc_q;
  padded_input_rsc_radr <= padded_input_rsci_radr;
  padded_input_rsc_d <= padded_input_rsci_d;
  padded_input_rsc_wadr <= padded_input_rsci_wadr;
  padded_input_rsci_d_d <= buf1_rsci_q_d;
  padded_input_rsci_q_d <= padded_input_rsci_q_d_1;
  padded_input_rsci_radr_d_1 <= padded_input_rsci_radr_d;
  padded_input_rsci_wadr_d_1 <= padded_input_rsci_wadr_d;

  buf2_rsci : UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_5_15_12_32768_1_32768_12_1_gen
    PORT MAP(
      clken => buf2_rsc_clken,
      q => buf2_rsci_q,
      re => buf2_rsc_re,
      radr => buf2_rsci_radr,
      we => buf2_rsc_we,
      d => buf2_rsci_d,
      wadr => buf2_rsci_wadr,
      clken_d => buf1_rsci_clken_d,
      d_d => buf2_rsci_d_d_1,
      q_d => buf2_rsci_q_d_1,
      radr_d => buf2_rsci_radr_d_1,
      re_d => buf2_rsci_re_d_iff,
      wadr_d => buf2_rsci_wadr_d_1,
      we_d => buf2_rsci_we_d_iff,
      writeA_w_ram_ir_internal_WMASK_B_d => buf2_rsci_we_d_iff,
      readA_r_ram_ir_internal_RMASK_B_d => buf2_rsci_re_d_iff
    );
  buf2_rsci_q <= buf2_rsc_q;
  buf2_rsc_radr <= buf2_rsci_radr;
  buf2_rsc_d <= buf2_rsci_d;
  buf2_rsc_wadr <= buf2_rsci_wadr;
  buf2_rsci_d_d_1 <= buf2_rsci_d_d;
  buf2_rsci_q_d <= buf2_rsci_q_d_1;
  buf2_rsci_radr_d_1 <= buf2_rsci_radr_d;
  buf2_rsci_wadr_d_1 <= buf2_rsci_wadr_d;

  enc1_rsci : UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_6_15_12_32768_1_32768_12_1_gen
    PORT MAP(
      clken => enc1_rsc_clken,
      q => enc1_rsci_q,
      re => enc1_rsc_re,
      radr => enc1_rsci_radr,
      we => enc1_rsc_we,
      d => enc1_rsci_d,
      wadr => enc1_rsci_wadr,
      clken_d => buf1_rsci_clken_d,
      d_d => enc1_rsci_d_d_1,
      q_d => enc1_rsci_q_d_1,
      radr_d => enc1_rsci_radr_d_1,
      re_d => enc1_rsci_re_d_iff,
      wadr_d => enc1_rsci_wadr_d_1,
      we_d => enc1_rsci_we_d_iff,
      writeA_w_ram_ir_internal_WMASK_B_d => enc1_rsci_we_d_iff,
      readA_r_ram_ir_internal_RMASK_B_d => enc1_rsci_re_d_iff
    );
  enc1_rsci_q <= enc1_rsc_q;
  enc1_rsc_radr <= enc1_rsci_radr;
  enc1_rsc_d <= enc1_rsci_d;
  enc1_rsc_wadr <= enc1_rsci_wadr;
  enc1_rsci_d_d_1 <= enc1_rsci_d_d;
  enc1_rsci_q_d <= enc1_rsci_q_d_1;
  enc1_rsci_radr_d_1 <= enc1_rsci_radr_d;
  enc1_rsci_wadr_d_1 <= enc1_rsci_wadr_d;

  UNET_IP_main_run_inst : UNET_IP_main_run
    PORT MAP(
      clk => clk,
      rst => rst,
      input_rsc_dat => UNET_IP_main_run_inst_input_rsc_dat,
      input_rsc_vld => input_rsc_vld,
      input_rsc_rdy => input_rsc_rdy,
      output_rsc_dat => UNET_IP_main_run_inst_output_rsc_dat,
      output_rsc_vld => output_rsc_vld,
      output_rsc_rdy => output_rsc_rdy,
      buf1_rsci_clken_d => buf1_rsci_clken_d,
      buf1_rsci_d_d => UNET_IP_main_run_inst_buf1_rsci_d_d,
      buf1_rsci_q_d => UNET_IP_main_run_inst_buf1_rsci_q_d,
      buf1_rsci_radr_d => UNET_IP_main_run_inst_buf1_rsci_radr_d,
      buf1_rsci_wadr_d => UNET_IP_main_run_inst_buf1_rsci_wadr_d,
      padded_input_rsci_q_d => UNET_IP_main_run_inst_padded_input_rsci_q_d,
      padded_input_rsci_radr_d => UNET_IP_main_run_inst_padded_input_rsci_radr_d,
      padded_input_rsci_wadr_d => UNET_IP_main_run_inst_padded_input_rsci_wadr_d,
      buf2_rsci_d_d => UNET_IP_main_run_inst_buf2_rsci_d_d,
      buf2_rsci_q_d => UNET_IP_main_run_inst_buf2_rsci_q_d,
      buf2_rsci_radr_d => UNET_IP_main_run_inst_buf2_rsci_radr_d,
      buf2_rsci_wadr_d => UNET_IP_main_run_inst_buf2_rsci_wadr_d,
      enc1_rsci_d_d => UNET_IP_main_run_inst_enc1_rsci_d_d,
      enc1_rsci_q_d => UNET_IP_main_run_inst_enc1_rsci_q_d,
      enc1_rsci_radr_d => UNET_IP_main_run_inst_enc1_rsci_radr_d,
      enc1_rsci_wadr_d => UNET_IP_main_run_inst_enc1_rsci_wadr_d,
      buf1_rsci_re_d_pff => buf1_rsci_re_d_iff,
      buf1_rsci_we_d_pff => buf1_rsci_we_d_iff,
      padded_input_rsci_re_d_pff => padded_input_rsci_re_d_iff,
      padded_input_rsci_we_d_pff => padded_input_rsci_we_d_iff,
      buf2_rsci_re_d_pff => buf2_rsci_re_d_iff,
      buf2_rsci_we_d_pff => buf2_rsci_we_d_iff,
      enc1_rsci_re_d_pff => enc1_rsci_re_d_iff,
      enc1_rsci_we_d_pff => enc1_rsci_we_d_iff
    );
  UNET_IP_main_run_inst_input_rsc_dat <= input_rsc_dat;
  output_rsc_dat <= UNET_IP_main_run_inst_output_rsc_dat;
  buf1_rsci_d_d <= UNET_IP_main_run_inst_buf1_rsci_d_d;
  UNET_IP_main_run_inst_buf1_rsci_q_d <= buf1_rsci_q_d;
  buf1_rsci_radr_d <= UNET_IP_main_run_inst_buf1_rsci_radr_d;
  buf1_rsci_wadr_d <= UNET_IP_main_run_inst_buf1_rsci_wadr_d;
  UNET_IP_main_run_inst_padded_input_rsci_q_d <= padded_input_rsci_q_d;
  padded_input_rsci_radr_d <= UNET_IP_main_run_inst_padded_input_rsci_radr_d;
  padded_input_rsci_wadr_d <= UNET_IP_main_run_inst_padded_input_rsci_wadr_d;
  buf2_rsci_d_d <= UNET_IP_main_run_inst_buf2_rsci_d_d;
  UNET_IP_main_run_inst_buf2_rsci_q_d <= buf2_rsci_q_d;
  buf2_rsci_radr_d <= UNET_IP_main_run_inst_buf2_rsci_radr_d;
  buf2_rsci_wadr_d <= UNET_IP_main_run_inst_buf2_rsci_wadr_d;
  enc1_rsci_d_d <= UNET_IP_main_run_inst_enc1_rsci_d_d;
  UNET_IP_main_run_inst_enc1_rsci_q_d <= enc1_rsci_q_d;
  enc1_rsci_radr_d <= UNET_IP_main_run_inst_enc1_rsci_radr_d;
  enc1_rsci_wadr_d <= UNET_IP_main_run_inst_enc1_rsci_wadr_d;

END v4;



