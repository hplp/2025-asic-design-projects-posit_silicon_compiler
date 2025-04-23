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



## SiliconCompiler Integration and GDS Generation 

### Installation 
https://docs.siliconcompiler.com/en/latest/user_guide/installation.html#installation

- Installing Python
  
  Before installing the SiliconCompiler package you will need to set up a Python environment. 

- Installing SiliconCompiler

  After you’ve got the python dependencies installed, you will need to install SiliconCompiler.

- ASIC Demo

  Now that you have installed SiliconCompiler, you can test your installation by running a quick demo through the ASIC design flow in the cloud.

```bash
sc -target asic_demo -remote
```
This is generating the design files for the verilog code "Heartbeat".

  <p align="center">
  <img src="Images/heartbeat.png" alt="heartbeat" width="80%">
</p>
