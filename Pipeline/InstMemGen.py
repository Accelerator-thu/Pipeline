with open("Pipeline\Instructions.txt", "r") as inst:
    insts = inst.readlines()
    for i in range(len(insts)):
        print('\t', end="")
        print(f"8'd{i}: Instruction <= 32'b", end="")
        print(insts[i].rstrip('\n'), end="")
        print(";")
    inst.close()
print('\t', end="")
print("default: Instruction <= 32'b" + "0" * 32 + ";")