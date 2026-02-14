# Educational-ARM-Processors-ARM1-ARM32-ARMPIP

This project implements three progressively complex ARM-based processor architectures in **SystemVerilog**, demonstrating the evolution of computer architecture from a simple FSM-controlled design to a fully hazard-resolved pipelined processor.

Course: CIE 439 – Computer Architecture and Assembly Language  
Institution: Zewail City of Science and Technology  
Semester: Fall 2025  

---

## 🚀 Project Overview

The project consists of three processor implementations:

### 1️⃣ ARM1 – 8-bit Multicycle Processor
- Accumulator-based architecture
- 4-state FSM control unit
- Unified instruction/data memory
- Basic ALU operations (ADD, SUB, AND, OR)
- Memory operations (LDA, LDB, STR)
- Output instruction
- Fully simulated and verified

📌 Concepts Demonstrated:
- Fetch–Decode–Execute cycle
- Finite State Machine control
- Multicycle datapath design

---

### 2️⃣ ARM32 – 32-bit Single-Cycle Processor
- Subset of ARM instruction set
- Separate instruction and data memories
- Register file with 15 general-purpose registers
- Conditional execution (ARM condition codes)
- Data processing, memory, and branch instructions

📌 Concepts Demonstrated:
- Single-cycle architecture
- Instruction encoding
- ALU flag handling
- Conditional execution logic

---

### 3️⃣ ARMPIP – 32-bit 5-Stage Pipelined Processor
Pipeline stages:
1. Fetch
2. Decode
3. Execute
4. Memory
5. Writeback

Supported instructions:
- ADD, SUB, AND, ORR, BIC, EOR, MOV
- LDR, STR
- Branch (B)

### 🛠 Hazard Handling

| Hazard Type | Resolution | Penalty |
|-------------|------------|---------|
| RAW (Register) | Data Forwarding | 0 cycles |
| Load-Use (LDR) | Stall + Forward | 1 cycle |
| Control (Branch) | Pipeline Flush | 2 cycles |

📌 Concepts Demonstrated:
- Pipeline registers
- Forwarding unit
- Hazard detection unit
- Stall & flush logic
- Throughput improvement

---

## 📚 References

- Harris & Harris, *Digital Design and Computer Architecture – ARM Edition*
- CIE 439 Course Materials

---

## 👨‍💻 Authors

- Mohammed Soliman  
- Mohammed Abdelrahman  
- Mohamed Ashraf  

---

## 📌 Key Takeaway

This project demonstrates the architectural evolution of processors — from a simple FSM-based accumulator machine to a fully pipelined ARM processor with hazard resolution — providing practical insight into modern CPU design principles.


