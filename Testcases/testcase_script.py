#! /usr/bin/env python3

"""This file parses assembly code and creates testcases in verilog syntax.
Each instruction is assumed to take one clock cycle, and each case is tested
5 time units after the negedge of the clock.

* The variable that is being checked should be named 'WriteData'.
* The Clock should be named "Clk".
* The Reset signal should be named "Rst".
* There should be two integers named "tests" and "passed".
* This program beings parsing at "main:". Everything before is ignored.

Lines that begin with a pound are added as comments to the .v file.

Lines in the assembly file should be in this format:
    add $s1, $s2, $s3     # [s1] = 5

* Everything before the equal sign can be formatted in whatever way desired.
* The number after the equal sign will be compared with write data.
* If WriteData is not being used for a command, omit the comment or write a
comment without an equals sign.
* If the number is proceeded by "0x" then it is interpreted as hex. 

"""

def main():

    file_name = input("Enter input file name:")

    try:
        f = open(file_name)
    except:
        print("ERROR: Cannot open input file. Make sure that it exists.")
        return

    out_file_name = input("Enter output file name:")
    out_f = open(out_file_name, 'w')

    # Initial Setup
    out_f.write("tests <= 0;\n")
    out_f.write("passed <= 0;\n")
    out_f.write("Rst <= 1;\n\n")
    out_f.write("$display(\"\\n\\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\");\n")
    out_f.write("$display(\"Starting Unit Tests.\");\n\n")
    out_f.write("@(negedge Clk);\n")
    out_f.write("@(negedge Clk);\n")
    out_f.write("Rst <= 0;\n")
    out_f.write("@(negedge Clk);\n")
    out_f.write("@(negedge Clk);\n")
    
    main = f.readline()

    while main.strip() != "main:":
        main = f.readline()

    out_f.write("\n// main:\n\n")

    searching = False
    searchName = "main"

    for line in f:
        if (not searching) or (len(line.strip().split(":")) > 0 and line.strip().split(":")[0] == searchName):
            searching = False
            # Check for empty line
            if line.strip() == "":
                continue
            # Check if this is a comment
            elif line.strip()[0] == "#":
                out_f.write("\n\n//// {} ////\n".format(line[1:].strip()))
            elif ":" in line:
                out_f.write("\n// main:\n")
            else:
                l = line.strip().split("#")
                if len(l) > 0:
                    out_f.write("\n// {}\n".format(l[0]))
                    out_f.write("@(negedge Clk);\n")
                    if l[0][0] == "j":
                        instr = l[0].strip().split()
                        if len(instr) == 2:
                            searching = True
                            searchName = instr[1].strip()
                    elif len(l) > 1:
                        l2 = l[1].split("=")
                        if len(l2) == 2:
                            value = l2[1]
                            # Hex
                            if len(value.split("x")) == 2:
                                value_stripped = value.split("x")[1].strip()
                                out_f.write("#5 if (WriteData == 32'h{})\n".format(value_stripped))
                                out_f.write("\tpassed = passed + 1;\n")
                                out_f.write("else\n")
                                out_f.write("\t$display(\"Failed: {}. Exceptect WriteData: {}. Actual WriteData: %h\", WriteData);\n".format(l[0].strip(), value_stripped))
                            # Decimal
                            else:
                                value_stripped = value.strip()
                                out_f.write("#5 if (WriteData == 32'd{})\n".format(value_stripped))
                                out_f.write("\tpassed = passed + 1;\n")
                                out_f.write("else\n")
                                out_f.write("\t$display(\"Failed: {}. Exceptect WriteData: {}. Actual WriteData: %d\", WriteData);\n".format(l[0].strip(), value_stripped))

    out_f.write("\n// Report results\n")
    out_f.write("if (passed == tests)\n")
    out_f.write("\t$display(\"All tests passed.\");\n")
    out_f.write("else\n")
    out_f.write("\t$display(\"%4d out of %4d tests passed.\", passed, tests);\n")
    out_f.write("$display(\"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\\n\\n\");\n")
            
    f.close()
    out_f.close()
    print("Done.")
    
if __name__ == "__main__":
    main()
                            
