----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/09/2019 02:37:27 PM
-- Design Name: 
-- Module Name: myReg - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.NIST_LWAPI_pkg.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- Entity
------------------------------------------------------------
entity myReg is
    generic (b : integer);
    Port(
        clk     : in std_logic;
        rst     : in std_logic;
        en      : in std_logic;
        D_in    : in std_logic_vector(b-1 downto 0);
        D_out   : out std_logic_vector(b-1 downto 0)
    );
end myReg;

-- Architecture
------------------------------------------------------------
architecture Behavioral of myReg is

------------------------------------------------------------
begin

    GEN_proc_Store_SYNC_RST: if (not ASYNC_RSTN) generate
    Store: process(clk)
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                D_out <= (others => '0');
            elsif (en = '1') then
                D_out <= D_in;
            end if;
        end if;
    end process;
	end generate GEN_proc_Store_SYNC_RST;

	GEN_proc_Store_ASYNC_RSTN: if (ASYNC_RSTN) generate
    Store: process(clk, rst)
    begin
        if (rst = '0') then
            D_out <= (others => '0');
        elsif rising_edge(clk) then
            if (en = '1') then
                D_out <= D_in;
            end if;
        end if;
    end process;
    end generate GEN_proc_Store_ASYNC_RSTN;

end Behavioral;
