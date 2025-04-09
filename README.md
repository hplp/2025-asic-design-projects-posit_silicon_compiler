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
(List the hardware platform, software tools, language(s), etc. you plan to use)

## Expected Outcomes:
A fully functional and verified FP16-Posit4 MAC unit, simulated and tested using Verilog testbenches.

A hardware-optimized RTL design, synthesized and placed-and-routed using SiliconCompiler with analysis of area, timing, and power.

A manufacturable GDS file output, demonstrating the full digital design flow from high-level numerical representation to silicon-level layout.

## Tasks:
(Describe the tasks that need to be completed. Assign students to tasks)

## Timeline:
(Provide a timeline or milestones for the project)
