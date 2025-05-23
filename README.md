# Posit - Index-based Computation of Real Number Multiplication with SiliconCompiler

## Team Name: 
Posit Silicon Compiler

## Team Members:
- Melika Morsali (qfc2zn)
- Hasantha Ekanayake (uyq6nu)


## 1. Project Overview

#### Project Title: Posit - Index-based Computation of Real Number Multiplication with SiliconCompiler  
#### Repository URL: [GitHub Repository Link](https://github.com/hplp/2025-asic-design-projects-posit_silicon_compiler)

This project is to design and implement a Multiply-Accumulate (MAC) operation where the
activation inputs are in 16-bit IEEE floating-point format (FP16), and the weights are in 4-
bit posit (Posit4) format with SiliconCompiler. SiliconCompiler is an open-source framework
that automates the translation from source code to silicon. We aim to use SiliconCompiler
to compile the Verilog RTL design of FP16-Posit4 MAC to a GDS file.

## 2. Key Objectives:

- Objective 1 - Design a Multiply-Accumulate (MAC) Unit using FP16 activations and Posit4 weights to explore efficiency gains in numerical computing for ML accelerators.

- Objective 2 - Integrate and validate decoding, multiplication, and accumulation stages in Verilog, ensuring functional correctness and numerical accuracy.

- Objective 3 - Leverage SiliconCompiler to automate the synthesis and physical design process, compiling the RTL implementation into a GDS file for fabrication readiness.

## 3. Technology Stack:
 - Hardware Platform: Local workstation or server 
 - Software Tools: SiliconCompiler, Verilog Simulation Tool
 - Languages: Verilog HDL, Python, Shell scripting / Makefiles 

## 4. Expected Outcomes:
1. A fully functional and verified FP16-Posit4 MAC unit, simulated and tested using Verilog testbenches.

2. A hardware-optimized RTL design, synthesized and placed-and-routed using SiliconCompiler with analysis of area, timing, and power.

3. A manufacturable GDS file output, demonstrating the full digital design flow from high-level numerical representation to silicon-level layout.

## 5. Methods

- Implement and test the Posit4 multiplication module in Verilog 
- Integrate the multiplier and accumulator modules 
- SiliconCompiler Integration and GDS Generation 
- Performance evaluation of MAC 

## 6. Results:

### 6.1 Implementation and test the Posit4 multiplication module in Verilog 
- FP-Posit Multiplication Testbench Result (Implement and test the Posit4 multiplication module):
  <p align="center">
  <img src="Images/posit_mul.png" alt="fp_posit_mul" width="80%">
</p>

### 6.2 Implementation and test the Posit4 Accumulator module in Verilog 
- FP-Posit Accumulator Testbench Result (Implement and test the Posit4 Accumulator module):
  <p align="center">
  <img src="Images/posit_acc.png" alt="fp_posit_acc" width="80%">
</p>

### 6.3 Integration of the multiplier and accumulator modules 
- FP-Posit MAC Testbench Result (Integrate the multiplier and accumulator modules):

    <p align="center">
  <img src="Images/posit_mac.png" alt="fp_posit_mac" width="80%">
</p>



## 7. SiliconCompiler Integration

  <img src="Images/sc_logo_with_text.png" alt="sc_logo" width="80%">


### 7.1 Installation 
https://docs.siliconcompiler.com/en/latest/user_guide/installation.html#installation

- Installing Python
  
  Before installing the SiliconCompiler package, the Python environment needed to be set up. 

- Installing SiliconCompiler

  After the python dependencies have installed, SiliconCompiler needed to be installed.

### 7.2 Architeture 

#### Standardized Schema​
A single, extensible data model that cleanly separates design descriptions, EDA tools, and Process Design Kits (PDKs), making complex flows configurable yet easy to grasp.​
​
#### Python API & Flowgraph​
An object-oriented Python layer exposes simple set/get access to the schema, a parallel “flowgraph” programming model, and utility functions for setting up runs and collecting metrics.​
​
#### Pluggable Drivers​
Tool- and PDK-specific drivers plug into the core schema at runtime, automatically discovered via a dynamic module search​
​
#### Scalable & Extendable​
The combination of a rich schema, well-defined plugin interfaces, and comprehensive reference docs lets teams rapidly onboard new tools and PDKs without rewriting core code.

<img src="Images/Architecture.png" alt="sc_logo" width="50%">


### 7.3 Design Flow 

<img src="Images/Design_flow.png" alt="Design_flow" width="40%">



### 7.4 ASIC Demo

  Now that SiliconCompiler has installed, the installation can be tested by running a quick demo through the ASIC design flow in the cloud.

```bash
$ pip install siliconcompiler
$ sc heartbeat.v -remote

```

For designs that are too complex to be compiled at the command line, development should be like programming in Python:
```bash
import siliconcompiler
chip = siliconcompiler.Chip('heartbeat')
chip.load_target('skywater130_demo')
chip.input('heartbeat.v')
chip.clock('clk', period=10)
chip.set('option','remote', True)
chip.run()
chip.summary()
chip.show()

```

This command generates the design files for the Verilog module Heartbeat. The design flow involves following steps;



  <p align="center">
  <img src="Images/heartbeat.png" alt="heartbeat" width="50%">
</p>

### 7.5 FP-Posit Multiplication

Command line execution
```bash
$ pip install siliconcompiler
$ sc fp_posit4_mul.v -remote

```

Design flow - FP-Posit Multiplication
  <p align="center">
  <img src="Images/design_flow_mul.png" alt="design_flow" width="80%">
</p>

Summary Report - FP-Posit Multiplication

<p align="center">
  <img src="Images/Summary1_mul.png" alt="Summary" width="80%"><img src="Images/Summary2_mul.png" alt="Summary" width="80%">
</p>


Chip Layout - FP-Posit Multiplication
  <p align="center">
  <img src="Images/fp_posit4_mul.png" alt="fp_posit4_mul" width="50%">
</p>

### 7.6 FP-Posit Accumulator

Command line execution
```bash
$ pip install siliconcompiler
$ sc fp_posit4_acc.v -remote

```

Design flow - FP-Posit Accumulator
  <p align="center">
  <img src="Images/design_flow_acc.png" alt="design_flow" width="80%">
</p>

Summary Report - FP-Posit Accumulator

<p align="center">
  <img src="Images/Summary1_acc.png" alt="Summary" width="80%"><img src="Images/Summary2_acc.png" alt="Summary" width="80%">
</p>



Chip Layout - FP-Posit Accumulator
  <p align="center">
  <img src="Images/fp_posit4_acc.png" alt="fp_posit4_acc" width="50%">
</p>

### 7.7 FP-Posit MAC

Command line execution
```bash
$ pip install siliconcompiler
$ sc fp_posit_mac.v fp_posit_mac.sdc -remote

```

Python Execution
```bash
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
```
  

Design flow - FP-Posit MAC
  <p align="center">
  <img src="Images/design_flow_mac.png" alt="design_flow" width="80%">
</p>

Summary Report - FP-Posit MAC

<p align="center">
  <img src="Images/Summary1_mac.png" alt="Summary" width="80%"><img src="Images/Summary2_mac.png" alt="Summary" width="80%">
</p>


Chip Layout - FP-Posit MAC
  <p align="center">
  <img src="Images/fp_posit_mac.png" alt="fp_posit4_mul" width="50%">
</p>

####  Intermediate Files for the MAC Design Flow


Floor Plan
  <p align="center">
  <img src="Images/fp_posit_mac .floorplan.png" alt="floorplan.png" width="50%">
</p>


Power and Ground Planning
  <p align="center">
  <img src="Images/fp_posit_mac.powergrid.png" alt="fp_posit_mac.powergrid.png" width="50%">
</p>


Placement
  <p align="center">
  <img src="Images/fp_posit_mac.placement.png" alt="fp_posit_mac.placement" width="50%">
</p>


Clocks

<div style="display: flex; justify-content: center; align-items: center;">
  <img src="Images/fp_posit_mac.clk.png" alt="fp_posit_mac.clk.png" width="45%" />
  <img src="Images/fp_posit_mac.clocks.png" alt="fp_posit_mac.clocks.png" width="45%" />
</div>

Timing

<div style="display: flex; justify-content: center; align-items: center;">
  <img src="Images/hold.histogram.png" alt="Hold Histogram" width="45%" />
  <img src="Images/setup.histogram.png" alt="Setup Histogram" width="45%" />
</div>


Routing
 <p align="center">
  <img src="Images/fp_posit_mac.routing.png" alt="fp_posit_mac.placement" width="50%">
</p>



Power Density

 <p align="center">
  <img src="Images/typical.png" alt="typical" width="50%">
</p>

GDSII generation

  <p align="center">
  <img src="Images/fp_posit_mac.png" alt="fp_posit4_mul" width="50%">
</p>

[▶️ Watch the demo video on OneDrive](https://myuva-my.sharepoint.com/:v:/g/personal/uyq6nu_virginia_edu/EUrEXopo-11LhvKPCUpOJf8BFL82Wty9AOR7l5IHRvMYqQ?e=t8cr6X)

####  7.8 Performace Eveluation of Silicon Compiler

| Metric                           | TinyTapeout                         | SiliconCompiler                                      |
|----------------------------------|-------------------------------------|------------------------------------------------------|
| **End-to-End Runtime**           | ~5 min (full OpenLane flow)         | ~10 min initial, ~2 min for incremental rebuilds     |
| **Incremental Rebuild Time**     | Full rerun (~5 min)                 | Cached stages → ~1–2 min                             |
| **Design Flow**             | Web-based, template-driven, simplified process                 | Automated RTL-to-GDSII with full P&R, DRC, LVS, etc.|                                 |
| **Supported Complexity**       | Small digital designs               | Small to very large, complex SoCs and ASICs          |                      
| **Scalability & Parallelism**    | Single-machine only                 | Built-in remote/cluster support                      |


## 8. Key Takeaways

Why SiliconCompiler?

- Ease-of-use: Programmable with a simple Python API
- Portability: Powerful dynamic JSON schema supports ASIC and FPGA design and simulation
- Speed: Flowgraph execution model enables cloud scale execution.
- Friction-less: Remote execution model enables "zero install" compilation
- Modularity: Tool abstraction layer makes it easy to add/port new tools to the project.
- Provenance: Compilation manifests created automatically during execution.
- Documented: An extensive set of auto-generated high quality reference documents.

## 9. Challenges

- Verilog Compatibility
Makeing sure the Verilog codes (including all custom settings) loads into Yosys correctly, so it doesn’t lose any signal sizes or precision.

- Timing Setup
Writing simple timing rules for each stage of the design and create delay files so the timing checker can confirm it meets your clock speed.

- Debugging & Fast Rebuilds
Tracking down errors that only happen in one setup (like wrong file paths or missing settings), and use SiliconCompiler’s cache so only the parts you changed get rebuilt.

## 10.Conclusion

This project focused on designing and implementing a Multiply-Accumulate (MAC) operation using SiliconCompiler. SiliconCompiler, an open-source framework, automates the translation from source code to silicon. Our goal was to utilize SiliconCompiler to compile the Verilog RTL design of the FP16-Posit4 MAC into a GDS file.

In conclusion, SiliconCompiler proves to be a powerful tool for automating the translation from source code to silicon. By leveraging this open-source framework, we successfully compiled the Verilog RTL design of the FP16-Posit4 MAC into a GDS file. This process not only streamlined the design workflow but also demonstrated the efficiency and effectiveness of SiliconCompiler in handling complex digital design tasks. The use of SiliconCompiler significantly enhances productivity and ensures a seamless transition from design to implementation.
## References

[1] [SiliconCompiler](https://www.siliconcompiler.com/)

