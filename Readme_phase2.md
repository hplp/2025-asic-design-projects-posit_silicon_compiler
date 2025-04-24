## Implementation and Verification -  FP-Posit MAC

- FP-Posit Multiplication Testbench Result (Implement and test the Posit4 multiplication module):
  <p align="center">
  <img src="Images/posit_mul.png" alt="fp_posit_mul" width="80%">
</p>


- FP-Posit Accumulator Testbench Result (Implement and test the Posit4 Accumulator module):

  <p align="center">
  <img src="Images/posit_acc.png" alt="fp_posit_acc" width="80%">
</p>


- FP-Posit MAC Testbench Result (Integrate the multiplier and accumulator modules):

    <p align="center">
  <img src="Images/posit_mac.png" alt="fp_posit_mac" width="80%">
</p>



## SiliconCompiler Integration

### Installation 
https://docs.siliconcompiler.com/en/latest/user_guide/installation.html#installation

- Installing Python
  
  Before installing the SiliconCompiler package, the Python environment needed to be set up. 

- Installing SiliconCompiler

  After the python dependencies have installed, SiliconCompiler needed to be installed.

### ASIC Demo

  Now that SiliconCompiler has installed, the installation can be tested by running a quick demo through the ASIC design flow in the cloud.

```bash
sc -target asic_demo -remote
```
This command generates the design files for the Verilog module Heartbeat.

  <p align="center">
  <img src="Images/heartbeat.png" alt="heartbeat" width="50%">
</p>

### FP-Posit Multiplication

Design flow - FP-Posit Multiplication
  <p align="center">
  <img src="Images/design_flow_mul.png" alt="design_flow" width="80%">
</p>

Summary Report - FP-Posit Multiplication

  <p align="center">
  <img src="Images/Summary1_mul.png" alt="Summary" width="80%">
</p>

  <p align="center">
  <img src="Images/Summary2_mul.png" alt="Summary1_mul.png" width="80%">
</p>


Chip Layout - FP-Posit Multiplication
  <p align="center">
  <img src="Images/fp_posit4_mul.png" alt="fp_posit4_mul" width="50%">
</p>

### FP-Posit Accumulator

Design flow - FP-Posit Accumulator
  <p align="center">
  <img src="Images/design_flow_acc.png" alt="design_flow" width="80%">
</p>

Summary Report - FP-Posit Accumulator

  <p align="center">
  <img src="Images/Summary1_acc.png" alt="Summary" width="80%">
</p>

  <p align="center">
  <img src="Images/Summary2_acc.png" alt="Summary1_mul.png" width="80%">
</p>


Chip Layout - FP-Posit Accumulator
  <p align="center">
  <img src="Images/fp_posit4_mul.png" alt="fp_posit4_mul" width="50%">
</p>

### FP-Posit MAC

Design flow - FP-Posit MAC
  <p align="center">
  <img src="Images/design_flow_mac.png" alt="design_flow" width="80%">
</p>

Summary Report - FP-Posit MAC

  <p align="center">
  <img src="Images/Summary1_mac.png" alt="Summary" width="80%">
</p>

  <p align="center">
  <img src="Images/Summary2_mac.png" alt="Summary1_mul.png" width="80%">
</p>


Chip Layout - FP-Posit MAC
  <p align="center">
  <img src="Images/fp_posit4_mac.png" alt="fp_posit4_mul" width="50%">
</p>

## Challenges
Working on integrating the FP-Posit MAC unit within SiliconCompiler and developing appropriate constraint files for successful synthesis.
