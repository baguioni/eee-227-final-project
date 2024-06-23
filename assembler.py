import sys

# Instruction set and opcodes
INSTRUCTION_SET = {
    'LOAD':  '000',
    'AND':   '001',
    'OR':    '010',
    'XOR':   '011',
    'STORE': '100',
    'ADD':   '101',
    'SUB':   '110',
    'MUL':   '111'
}

# Addressing modes
ADDRESSING_MODES = {
    'immediate': '0',
    'register': '1'
}

# Number of registers and memory size
NUM_REGISTERS = 16
MEMORY_SIZE = 256

def check_register(value):
    reg_num = int(value.replace('R', ''))
    if reg_num < 0 or reg_num >= NUM_REGISTERS:
        raise ValueError(f"Register out of range: {value}")
    return format(reg_num, '04b')

def check_memory(value):
    mem_addr = int(value.replace('M', ''))
    if mem_addr < 0 or mem_addr >= MEMORY_SIZE:
        raise ValueError(f"Memory address out of range: {value}")
    return format(mem_addr, '08b')

def check_immediate(value):
    imm_value = int(value)
    if imm_value < 0 or imm_value >= MEMORY_SIZE:
        raise ValueError(f"Immediate value out of range: {value}")
    return format(imm_value, '08b')

def parse_instruction(line):
    parts = line.split()
    instruction = parts[0].upper()

    if instruction not in INSTRUCTION_SET:
        raise ValueError(f"Invalid instruction: {instruction}")

    opcode = INSTRUCTION_SET[instruction]

    if instruction == 'LOAD':
        dest = check_register(parts[1])
        if parts[2].startswith('M'):
            addr_mode = '1'  # memory addressing mode
            src = check_memory(parts[2])
        else:
            addr_mode = '0'  # immediate addressing mode
            src = check_immediate(parts[2])
        return f"{opcode}{addr_mode}{dest}{src}"

    elif instruction == 'STORE':
        addr_mode = '1'  # always register addressing mode for source
        src = check_register(parts[1])
        if parts[2].startswith('M'):
            dest = check_memory(parts[2])
        else:
            dest = check_register(parts[2])
        return f"{opcode}{addr_mode}{src}{dest}"

    elif instruction in {'AND', 'OR', 'XOR', 'ADD', 'SUB', 'MUL'}:
        addr_mode = '1'  # always register addressing mode for arithmetic instructions
        dest = check_register(parts[1])
        src1 = check_register(parts[2])
        src2 = check_register(parts[3])
        return f"{opcode}{addr_mode}{dest}{src1}{src2}"

    else:
        raise ValueError(f"Unsupported instruction: {instruction}")

def assemble(assembly_code):
    machine_code = []
    for line_number, line in enumerate(assembly_code, start=1):
        line = line.strip()
        if not line or line.startswith('#'):
            continue  # Ignore empty lines and comments
        try:
            machine_code.append(parse_instruction(line))
        except ValueError as e:
            raise ValueError(f"Error on line {line_number}: {e}")
    return machine_code

def main():
    if len(sys.argv) != 2:
        print("Usage: python assembler.py <assembly_file>")
        sys.exit(1)

    assembly_file = sys.argv[1]
    with open(assembly_file, 'r') as f:
        assembly_code = f.readlines()

    try:
        machine_code = assemble(assembly_code)
        for instruction in machine_code:
            print(instruction)
    except ValueError as e:
        print(e)
        sys.exit(1)

if __name__ == "__main__":
    main()
