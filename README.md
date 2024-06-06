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
| Bits 15 - 13 | Bit 12       | Bits 11 - 8 | Bits 7 - 4 |

### Store Instructions
| OpCode | Addressing Mode | Source | Destination |
|--------|-----------------|--------|-------------|
| Bits 15 - 13 | Bit 12 (1)   | Bits 11 - 8 | Bits 7 - 0 |

### Arithmetic Instructions
| OpCode | Addressing Mode | Destination | Source1 | Source2 |
|--------|-----------------|-------------|---------|---------|
| Bits 15 - 13 | Bit 12 (1)   | Bits 11 - 8 | Bits 7 - 4 | Bits 3 - 0 |
