# 8-bit Processor

This repository contains the implementation and documentation for an 8-bit processor. Below is the description of the Instruction Set Architecture (ISA) for the processor.

## Instructions
| Instruction | OpCode |
|-------------|--------|
| LOAD        | 000    |
| AND         | 001    |
| OR          | 010    |
| XOR         | 011    |
| STORE       | 100    |
| ADD         | 101    |
| SUB         | 110    |
| MUL         | 111    |

## Addressing Modes
| Addressing Mode | Value |
|-----------------|-------|
| Immediate       | 0     |
| Register        | 1     |

## Instruction Formats

### Load Instructions
| OpCode | Addressing Mode | Destination | Source |
|--------|-----------------|-------------|--------|
| Bits 15 - 13 | Bit 12       | Bits 11 - 8 | Bits 7 - 0 |

### Store Instructions
| OpCode | Addressing Mode | Source | Destination |
|--------|-----------------|--------|-------------|
| Bits 15 - 13 | Bit 12 (1)   | Bits 11 - 8 | Bits 7 - 0 |

### Arithmetic Instructions
| OpCode | Addressing Mode | Destination | Source1 | Source2 |
|--------|-----------------|-------------|---------|---------|
| Bits 15 - 13 | Bit 12 (1)   | Bits 11 - 8 | Bits 7 - 4 | Bits 3 - 0 |

## Assembler Documentation

### Load Instructions
- `<source>` can be an immediate value or memory address prefixed with `M`.

#### Store Instructions
- `<dest>` is a memory address prefixed with `M`

### Using the Assembler

1. **Write Your Assembly Code**:
   - Create a text file with your assembly code. For example, `test_program`.

2. **Run the Assembler**:
   - Open a terminal or command prompt.
   - Navigate to the directory containing `assembler.py`.
   - Run the assembler script with the assembly file as an argument:
     ```
     python assembler.py test_program
     ```

3. **Output**:
   - The assembler will generate a file named `instruction.dat` containing the machine code.
   - If there are any errors in the assembly code, they will be displayed with the line number for easy debugging.

### Example Usage

#### Input Assembly File (`program.asm`):
```assembly
LOAD R1 5
LOAD R2 3
SUB R0 R1 R2
STORE R0 M1
```

## Verifying the processor RTL
Assuming you have Icarus Verilog installed, run the following command in your terminal.
```
iverilog -o dsn tb_cpu.v alu.v cpu.v control_unit.v data_memory.v functional_units.v instruction_memory.v mux2-1.v program_counter.v register_file.v
```
