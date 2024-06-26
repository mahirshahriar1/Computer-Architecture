# CSE Projects Repository

Welcome to the CSE Projects Repository. This repository contains projects for two courses: CSE 231 (Digital Logic Design) and CSE 332 (Computer Organization and Architecture).

## Projects

### CSE 231 Digital Logic Design

#### Project: Pattern-Based Digital Lock System

This project involves designing a digital lock system using a pattern-based approach. The system includes:

- **Input:** A keypad for user input.
- **Output:** Two types of displays:
  - **Display 1:** Shows up to 4 input values using 7-segment displays.
  - **Display 2:** Indicates if the pattern is correct ("O") or incorrect ("N").
- **Modes:** 
  - **Mode 1:** Store a specific pattern.
  - **Mode 2:** Input and match with stored patterns.
- **Advanced Features:** 
  - Store up to 3 patterns, each up to 5 digits long.
  - Admin mode for pattern management (view, edit, delete).
  - Automatic display off after a period of inactivity.

More details can be found in the [CSE 231](/Pattern_Based_Lock_System_231/readme.md).

### CSE 332 Computer Organization and Architecture

#### Project: 16-bit Processor

This project involves designing a 16-bit processor with the following components:

- **Instruction Formats:** R-Type, I-Type, and J-Type.
- **ALU (Arithmetic Logic Unit):** Performs arithmetic and logic operations.
- **Zero Logic:** Indicates zero output from the ALU.
- **Register File:** High-speed storage cells inside the CPU.
- **Datapath:** Manages the fetch-decode-execute cycle.
- **Control Unit:** Defines operation codes and control signals.

An example problem is provided to demonstrate the use of the processor in storing the first 10 even numbers in memory and summing them.

More details can be found in the [CSE 332](/16_Bits_Datapath_332/readme.md).

## Repository Structure

```plaintext
CSE_Projects_Repo/
├── Pattern_Based_Lock_System_231/
│   ├── readme.md
│   ├── Pattern - Based Lock System.circ│  
└── Pattern - Based Lock System/
    ├── readme.md
    ├── 16_Bits_Project.circ
    └── Instruction_Memory.txt
    └── Report.pdf
    
