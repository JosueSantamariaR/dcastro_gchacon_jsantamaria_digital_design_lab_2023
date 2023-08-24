library IEEE;
use IEEE.std_logic_1164.all;

entity Adder_tst is
end entity;

architecture arch of Adder_tst is

    component Adder is
        port (
				a : in std_logic_vector (3 downto 0);
            b : in std_logic_vector (3 downto 0);
				ans : out std_logic_vector (4 downto 0);
            cin : in std_logic
        );
    end component;

    signal testAdder4A, testAdder4B : std_logic_vector (3 downto 0);
	 signal testAdderSum : std_logic_vector (4 downto 0);
    signal testCarryIn : std_logic;

begin

    unit_under_test : Adder port map (
        a => testAdder4A,
        b => testAdder4B,
		  
		  ans => testAdderSum,

        
        cin => testCarryIn
    );

    generate_signals : process
    begin
        testCarryIn <= '0'; testAdder4A <= "0000"; testAdder4B <= "1001"; wait for 40 ns;
        testCarryIn <= '0'; testAdder4A <= "0001"; testAdder4B <= "0011"; wait for 40 ns;
        testCarryIn <= '0'; testAdder4A <= "0010"; testAdder4B <= "0101"; wait for 40 ns;
        testCarryIn <= '0'; testAdder4A <= "0011"; testAdder4B <= "0001"; wait for 40 ns;
        testCarryIn <= '0'; testAdder4A <= "0100"; testAdder4B <= "0001"; wait for 40 ns;
        testCarryIn <= '0'; testAdder4A <= "0101"; testAdder4B <= "0101"; wait for 40 ns;
        testCarryIn <= '0'; testAdder4A <= "0110"; testAdder4B <= "0001"; wait for 40 ns;
        testCarryIn <= '0'; testAdder4A <= "0111"; testAdder4B <= "0001"; wait for 40 ns;
        testCarryIn <= '0'; testAdder4A <= "1000"; testAdder4B <= "1101"; wait for 40 ns;
        testCarryIn <= '0'; testAdder4A <= "1001"; testAdder4B <= "0001"; wait for 40 ns;
        testCarryIn <= '1'; testAdder4A <= "1010"; testAdder4B <= "1000"; wait for 40 ns;
        testCarryIn <= '0'; testAdder4A <= "1011"; testAdder4B <= "0101"; wait for 40 ns;
        testCarryIn <= '0'; testAdder4A <= "1100"; testAdder4B <= "0001"; wait for 40 ns;
        testCarryIn <= '0'; testAdder4A <= "1101"; testAdder4B <= "1111"; wait for 40 ns;
        testCarryIn <= '0'; testAdder4A <= "1110"; testAdder4B <= "0001"; wait for 40 ns;
        testCarryIn <= '0'; testAdder4A <= "1111"; testAdder4B <= "0001"; wait for 40 ns;
		  testCarryIn <= '1'; testAdder4A <= "0110"; testAdder4B <= "0101"; wait for 40 ns;
        testCarryIn <= '0'; testAdder4A <= "0111"; testAdder4B <= "0011"; wait for 40 ns;
        wait;
    end process;

end architecture;