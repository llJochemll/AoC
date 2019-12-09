module day1;

import std.algorithm;
import std.conv;
import std.file;
import std.math;
import std.stdio;

void challenge1() {
    File("input/day1.txt")
        .byLine
        .map!(a => a[0 .. $ - 1])
        .map!(a => a.to!real)
        .map!(a => (a / 3).floor)
        .map!(a => a.to!long)
        .map!(a => a - 2)
        .sum
        .writeln;
}

void challenge2() {
    File("input/day1.txt")
        .byLine
        .map!(a => a[0 .. $ - 1])
        .map!(a => a.to!long)
        .map!(a => a.calculateFuel)
        .sum
        .writeln;
}

long calculateFuel(long mass) {
    long fuel = ((mass / 3).to!real.floor - 2).max(0).to!long;

    if (fuel > 0) {
        fuel += calculateFuel(fuel);
    }

    return fuel;
}