onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/clk
add wave -noupdate /testbench/reset
add wave -noupdate /testbench/enabledVGA
add wave -noupdate -radix hexadecimal /testbench/dut/rom_instruction/address
add wave -noupdate -radix hexadecimal /testbench/dut/rom_instruction/q
add wave -noupdate /testbench/dut/arm1/MemWrite
add wave -noupdate -radix decimal /testbench/dut/arm1/ALUResult
add wave -noupdate -radix decimal /testbench/dut/arm1/WriteData
add wave -noupdate -radix decimal /testbench/dut/arm1/ReadData
add wave -noupdate /testbench/dut/arm1/MemorySelector
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {176 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 258
configure wave -valuecolwidth 150
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {631 ps}
