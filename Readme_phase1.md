# Project_Template

## Team Name: 
Posit Silicon Compiler

## Team Members:
- Melika Morsali (qfc2zn)
- Hasantha Ekanayake (uyq6nu)

## Project Title:
Posit - Index-based computation of real-number multiplication with SiliconCompiler

## Project Description:
We propose to design and implement a Multiply-Accumulate (MAC) operation where the
activation inputs are in 16-bit IEEE floating-point format (FP16), and the weights are in 4-
bit posit (Posit4) format with SiliconCompiler. SiliconCompiler is an open-source framework
that automates the translation from source code to silicon. We aim to use SiliconCompiler
to compile the Verilog RTL design of FP16-Posit4 MAC to a GDS file.

## Key Objectives:

- Objective 1 - Design a Multiply-Accumulate (MAC) Unit using FP16 activations and Posit4 weights to explore efficiency gains in numerical computing for ML accelerators.

- Objective 2 - Integrate and validate decoding, multiplication, and accumulation stages in Verilog, ensuring functional correctness and numerical accuracy.

- Objective 3 - Leverage SiliconCompiler to automate the synthesis and physical design process, compiling the RTL implementation into a GDS file for fabrication readiness.

## Technology Stack:
 - Hardware Platform: Local workstation or server 
 - Software Tools: SiliconCompiler, Verilog Simulation Tool
 - Languages: Verilog HDL, Python, Shell scripting / Makefiles 

## Expected Outcomes:
1. A fully functional and verified FP16-Posit4 MAC unit, simulated and tested using Verilog testbenches.

2. A hardware-optimized RTL design, synthesized and placed-and-routed using SiliconCompiler with analysis of area, timing, and power.

3. A manufacturable GDS file output, demonstrating the full digital design flow from high-level numerical representation to silicon-level layout.

## Tasks:

- Implement and test the Posit4 multiplication module in Verilog (Melika)
- Implement and test the Posit4 Accumulator module in Verilog (Hasantha)
- Integrate the multiplier and accumulator modules (Melika and Hasantha)
- SiliconCompiler Integration and GDS Generation (Melika and Hasantha)
- Performance evaluation of MAC (Melika and Hasantha)

## Timeline:

| **Week**     | **Phase**                          | **Tasks / Deliverables**                                                                 |
|--------------|------------------------------------|-------------------------------------------------------------------------------------------|
| Week 1-2     | Project Setup & Research         | Initiate the project scope, review Posit format and MAC designs, set up dev environment, install SiliconCompiler |
| Week 2-3    |  Multiplier Design    | Implement and test the FP16-Posit4 multiplication module in Verilog    |
| Week 2-3     | Accumulator Module               | Implement and test the FP16-compatible accumulator module in Verilog                        |
| Week 2-3       | MAC Integration                 | Combine multiplier and accumulator into a full MAC unit; begin end-to-end simulation      |
| Week 4-5      | RTL Finalization                | Finalize and verify the complete MAC module with testbenches                              |
| Week 4-5  | SiliconCompiler Integration      | Set up the synthesis flow, configure PDK and toolchain, compile RTL to GDS               |
| Week 4-5      | Evaluation & Analysis           | Analyze timing, area, and power of the GDS output; iterate if needed                      |
| Week 6-7      | Final Report & Presentation      | Prepare final documentation, presentation slides, and demo/report submission              |

