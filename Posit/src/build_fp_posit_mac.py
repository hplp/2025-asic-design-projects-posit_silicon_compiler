#!/usr/bin/env python3

from siliconcompiler import Chip
from siliconcompiler.targets import skywater130_demo

if __name__ == "__main__":
    # 1) Create your chip object
    chip = Chip('fp_posit_mac')

    # 2) Add RTL source and SDC constraint file
    chip.input('fp_posit_mac.v')      # Verilog RTL
    chip.input('fp_posit_mac.sdc')    # Timing constraints

    # 3) Define your clock
    chip.clock('clk', period=10)      # 100 MHz target

    # 4) Tell SC which SDC to use
    chip.set('constraint', 'sdc', 'fp_posit_mac.sdc')

    # 5) Select PDK & flow recipe
    chip.use(skywater130_demo)

    # 6) (Optional) run remotely
    chip.set('option', 'remote', True)

    # 7) Execute the flow and print a summary
    chip.run()
    chip.summary()
