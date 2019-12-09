module day3;

import std.algorithm;
import std.array;
import std.conv;
import std.file;
import std.math;
import std.parallelism;
import std.stdio;
import std.string;

void challenge1() {
    auto lines = File("input/day3.txt").byLine.map!(a => a.to!string).array;

    auto path1 = lines[0][0 .. $ - 1].split(",").map!(a => a.to!string).array;
    auto path2 = lines[1][0 .. $ - 1].split(",").map!(a => a.to!string).array;

    auto positions1 = path1.move;
    auto positions2 = path2.move;

    positions1[0 .. 10].writeln;

    Position[] crossings;
    foreach (p1i, ref p1; positions1) {
        if (p1i % 1000  == 0) {
            writeln(p1i, "/", positions1.length - 1);
        }

        foreach (p2i, ref p2; positions2) {
            if (p2.x == p1.x && p2.y == p1.y) {
                crossings ~= p1;
                break;
            }
        }

        /*if (positions2.canFind!(p2 => p2.x == p1.x && p2.y == p1.y)) {
            crossings ~= p1;
        }*/
    }

    auto distances = crossings.map!(c => abs(c.x) + abs(c.y)).array;

    distances.sort[0].writeln;
}

void challenge2() {
    auto lines = File("input/day3.txt").byLine.map!(a => a.to!string).array;

    auto path1 = lines[0][0 .. $ - 1].split(",").map!(a => a.to!string).array;
    auto path2 = lines[1][0 .. $ - 1].split(",").map!(a => a.to!string).array;

    auto positions1 = path1.move;
    auto positions2 = path2.move;

    positions1[0 .. 10].writeln;

    Crossing[] crossings;
    foreach (p1i, ref p1; positions1) {
        if (p1i % 1000  == 0) {
            writeln(p1i, "/", positions1.length - 1);
        }

        foreach (p2i, ref p2; positions2) {
            if (p2.x == p1.x && p2.y == p1.y) {
                crossings ~= Crossing(p1.x, p1.y, p1i + 1 + p2i + 1);
                break;
            }
        }

        /*if (positions2.canFind!(p2 => p2.x == p1.x && p2.y == p1.y)) {
            crossings ~= p1;
        }*/
    }

    auto distances = crossings.map!(c => c.distance).array;

    distances.sort[0].writeln;
}

auto move(string[] path) {
    Position[] positions;
    Position currentPosition;

    foreach (i, op; path) {
        auto dir = op[0];
        auto length = op[1 .. $].to!int;

        if (dir == 'U') {
            foreach (offset; 1 .. length + 1) {
                auto y = currentPosition.y + offset;

                positions ~= Position(currentPosition.x, y);
            }

            currentPosition.y += length;
        }

        if (dir == 'D') {
            foreach (offset; 1 .. length + 1) {
                auto y = currentPosition.y - offset;

                positions ~= Position(currentPosition.x, y);
            }

            currentPosition.y -= length;
        }

        if (dir == 'L') {
            foreach (offset; 1 .. length + 1) {
                auto x = currentPosition.x - offset;

                positions ~= Position(x, currentPosition.y);
            }

            currentPosition.x -= length;
        }

        if (dir == 'R') {
            foreach (offset; 1 .. length + 1) {
                auto x = currentPosition.x + offset;

                positions ~= Position(x, currentPosition.y);
            }

            currentPosition.x += length;
        }
    }

    return positions;
}

/*auto move2(string[] path) {
    Line[] lines;
    Position currentPosition;

    foreach (i, op; path) {
        auto dir = op[0];
        auto length = op[1 .. $].to!int;

        if (dir == 'U') {
            lines ~= Line(currentPosition, Position(currentPosition.x, currentPosition.y + length), length, "H");

            currentPosition.y += length;
        }

        if (dir == 'D') {
            lines ~= Line(currentPosition, Position(currentPosition.x, currentPosition.y - length), length, "H");

            currentPosition.y -= length;
        }

        if (dir == 'L') {
            lines ~= Line(currentPosition, Position(currentPosition.x - length, currentPosition.y), length, "V");

            currentPosition.x -= length;
        }

        if (dir == 'R') {
            lines ~= Line(currentPosition, Position(currentPosition.x + length, currentPosition.y), length, "V");

            currentPosition.x += length;
        }
    }

    return positions;
}*/

auto crosses(Line l1, Line l2) {
    
}

auto crossing(Line l1, Line l2) {

}

struct Position {
    int x;
    int y;
}

struct Crossing {
    int x;
    int y;
    ulong distance;
}

struct Line {
    Position start;
    Position end;
    ulong distance;
    string dir;
}