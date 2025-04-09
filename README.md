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
(Describe the tasks that need to be completed. Assign students to tasks)

## Timeline:
Week	Phase	Tasks / Deliverables
Week 1–2	🚀 Project Setup & Research	Finalize project scope, review Posit format and MAC designs, set up development environment, install SiliconCompiler
Week 3–4	⚙️ FP16-Posit4 Multiplier Design	Implement and test the Posit4 decoder and FP16-Posit4 multiplication module in Verilog
Week 5–6	✅ Multiplier Verification	Develop Verilog testbenches and validate functional correctness of the multiplier
Week 7–8	➕ Accumulator Module	Design and simulate the FP16-compatible accumulator module and integrate it with the multiplier
Week 9	🔗 MAC Integration	Combine multiplier and accumulator into a full MAC unit; begin end-to-end simulation
Week 10	🧪 RTL Finalization	Finalize and verify the complete MAC module with testbenches
Week 11–12	🏗️ SiliconCompiler Integration	Set up the synthesis flow, configure PDK and toolchain, compile RTL to GDS
Week 13	📊 Evaluation & Analysis	Analyze timing, area, and power of the GDS output; iterate if needed
Week 14	📝 Final Report & Presentation	Prepare final documentation, presentation slides, and demo/report submission
