module day5;

import std.algorithm;
import std.array;
import std.conv;
import std.file;
import std.range;
import std.stdio;
import std.string;

void challenge1() {
    auto numbers = readText("input/day5.txt").split(",").map!(a => a.to!int).array;

    numbers.execute(5).writeln;
}

auto execute(ref int[] program, int input) {
    int[] output;
    auto pointer = 0;

    while (true) {
        int[ulong] paramModes;

        auto instruction = program[pointer];
        auto instructionString = instruction.to!string;
        int opCode = instruction;

        void increasePointer(int amount) {
            if (instruction == program[pointer]) {
                pointer += amount;
            }
        }

        pointer.writeln;

        if (instructionString.length > 2) {
            opCode = instructionString[$ - 2 .. $].to!int;

            foreach (i, digit; instructionString[0 .. $ - 2]) {
                paramModes[instructionString.length - 3 - i] = digit.to!string.to!int;
            }
        }

        if (opCode == 1) {
            auto lhs = paramModes.getParamMode(0) == 0 ? program[program[pointer + 1]] : program[pointer + 1];
            auto rhs = paramModes.getParamMode(1) == 0 ? program[program[pointer + 2]] : program[pointer + 2];

            program[program[pointer + 3]] = lhs + rhs;

            increasePointer(4);
            continue;
        }

        if (opCode == 2) {
            auto lhs = paramModes.getParamMode(0) == 0 ? program[program[pointer + 1]] : program[pointer + 1];
            auto rhs = paramModes.getParamMode(1) == 0 ? program[program[pointer + 2]] : program[pointer + 2];

            program[program[pointer + 3]] = lhs * rhs;

            increasePointer(4);
            continue;
        }

        if (opCode == 3) {
            program[program[pointer + 1]] = input;

            increasePointer(2);
            continue;
        }

        if (opCode == 4) {
            int value = paramModes.getParamMode(0) == 0 ? program[program[pointer + 1]] : program[pointer + 1];

            output ~= value;

            increasePointer(2);
            continue;
        }

        if (opCode == 5) {
            int check = paramModes.getParamMode(0) == 0 ? program[program[pointer + 1]] : program[pointer + 1];
            int address = paramModes.getParamMode(1) == 0 ? program[program[pointer + 2]] : program[pointer + 2];

            if (check != 0) {
                pointer = address;
            } else {
                increasePointer(3);
            }

            continue;
        }

        if (opCode == 6) {
            int check = paramModes.getParamMode(0) == 0 ? program[program[pointer + 1]] : program[pointer + 1];
            int address = paramModes.getParamMode(1) == 0 ? program[program[pointer + 2]] : program[pointer + 2];

            if (check == 0) {
                pointer = address;
            } else {
                increasePointer(3);
            }

            continue;
        }

        if (opCode == 7) {
            auto lhs = paramModes.getParamMode(0) == 0 ? program[program[pointer + 1]] : program[pointer + 1];
            auto rhs = paramModes.getParamMode(1) == 0 ? program[program[pointer + 2]] : program[pointer + 2];
            int address = program[pointer + 3];

            if (lhs < rhs) {
                program[address] = 1;
            } else {
                program[address] = 0;
            }

            increasePointer(4);

            continue;
        }

        if (opCode == 8) {
            auto lhs = paramModes.getParamMode(0) == 0 ? program[program[pointer + 1]] : program[pointer + 1];
            auto rhs = paramModes.getParamMode(1) == 0 ? program[program[pointer + 2]] : program[pointer + 2];
            int address = program[pointer + 3];

            if (lhs == rhs) {
                program[address] = 1;
            } else {
                program[address] = 0;
            }

            increasePointer(4);

            continue;
        }

        if (opCode == 99) {
            break;
        }
    }

    return output;
}

auto getParamMode(int[ulong] paramModes, int paramIndex) {
    if (paramIndex in paramModes) {
        return paramModes[paramIndex];
    }

    return 0;
}