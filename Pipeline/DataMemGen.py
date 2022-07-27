str = "Linux is Not Unix is Unix is Unix"
pat = "Unix"

print("// string")

for i in range(len(str)):
    print("RAM_data[%d] <= {24'h0, 8'd%-3d};  // %s" %
          (i, ord(str[i]), str[i]))

print(f"for (i = {i + 1}; i < 256; i = i + 1)")
print("\tRAM_data[i] <= 32'b0;")

print("// pattern")

for i in range(len(pat)):
    print("RAM_data[%d] <= {24'h0, 8'd%-3d};  // %s" %
          (i + 256, ord(pat[i]), pat[i]))

print(f"for (i = {i + 257}; i < RAM_SIZE; i = i + 1)")
print("\tRAM_data[i] <= 32'b0;")
