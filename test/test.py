import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles

@cocotb.test()
async def test_servo(dut):
    dut._log.info("start")
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # reset
    dut._log.info("reset")
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 1)
    dut.rst_n.value = 1
    # set the compare value
    dut.ui_in.value = 5
    await ClockCycles(dut.clk, 10000)
    dut.ui_in.value = 15
    await ClockCycles(dut.clk, 10000)
    dut.ui_in.value = 25 
    await ClockCycles(dut.clk, 10000)
    dut.ui_in.value = 35 
    await ClockCycles(dut.clk, 10000)
    dut.ui_in.value = 45 
    await ClockCycles(dut.clk, 10000)
