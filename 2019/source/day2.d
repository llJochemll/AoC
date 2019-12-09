module day2;

import std.algorithm;
import std.array;
import std.conv;
import std.file;
import std.stdio;
import std.string;

void challenge1() {
    auto numbers = readText("input/day2.txt").split(",").map!(a => a.to!int).array;
    numbers[1] = 12;
    numbers[2] = 2;

    writeln(numbers);

    foreach (i, ref number; numbers) {
        if (i % 4 != 0) continue;

        if (number == 1) {
            numbers[numbers[i + 3]] = numbers[numbers[i + 1]] + numbers[numbers[i + 2]];
        }

        if (number == 2) {
            numbers[numbers[i + 3]] = numbers[numbers[i + 1]] * numbers[numbers[i + 2]];
        }

        if (number == 99) {
            break;
        }
    }

    numbers.writeln;
    numbers[0].writeln;
}

void challenge2() {
    auto numbers = readText("input/day2.txt").split(",").map!(a => a.to!int).array;

    foreach (noun; 0 .. 99) {
        foreach (verb; 0 .. 99) {
            auto program = numbers.dup;
            program[1] = noun;
            program[2] = verb;

            if (program.executeProgram[0] == 19690720) {
                noun.writeln;
                verb.writeln;
            }
        }
    }
}

int[] executeProgram(int[] program) {
    auto numbers = program.dup;

    foreach (i, ref number; numbers) {
        if (i % 4 != 0) continue;

        if (number == 1) {
            numbers[numbers[i + 3]] = numbers[numbers[i + 1]] + numbers[numbers[i + 2]];
        }

        if (number == 2) {
            numbers[numbers[i + 3]] = numbers[numbers[i + 1]] * numbers[numbers[i + 2]];
        }

        if (number == 99) {
            break;
        }
    }

    return numbers;
}