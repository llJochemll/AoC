module day4;

import std.algorithm;
import std.array;
import std.conv;
import std.file;
import std.math;
import std.parallelism;
import std.stdio;
import std.string;

void challenge1() {
    int count = 0;

    foreach (number; 197487 .. 673252) {
        bool hasAdjacent = false;
        bool noDecrease = true;

        auto numberString = number.to!string;

        foreach (i, c; numberString) {
            int prev = i > 0 ? numberString[i - 1].to!string.to!int : -1;
            int current = c.to!string.to!int;
            int next = i < numberString.length - 1 ? numberString[i + 1].to!string.to!int : 10;

            if (current < prev) {
                noDecrease = false;
                break;
            }

            if (prev == current) {
                hasAdjacent = true;
            }
        }

        if (hasAdjacent && noDecrease) {
            count++;
        }
    }

    count.writeln;
}

void challenge2() {
    int count = 0;

    foreach (number; 197487 .. 673252) {
        bool hasAdjacent = false;
        bool noDecrease = true;

        auto numberString = number.to!string;

        foreach (i, c; numberString) {
            int prev2 = i > 1 ? numberString[i - 2].to!string.to!int : -1;
            int prev = i > 0 ? numberString[i - 1].to!string.to!int : -1;
            int current = c.to!string.to!int;
            int next = i < numberString.length - 1 ? numberString[i + 1].to!string.to!int : 10;

            if (current < prev) {
                noDecrease = false;
                break;
            }

            if (prev == current && current != next && current != prev2) {
                hasAdjacent = true;
            }
        }

        if (hasAdjacent && noDecrease) {
            count++;
        }
    }

    count.writeln;
}