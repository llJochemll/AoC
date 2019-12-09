module day6;

import std.algorithm;
import std.array;
import std.conv;
import std.file;
import std.math;
import std.parallelism;
import std.stdio;
import std.string;

void challenge1() {
    Body[string] bodies;

    auto lines = File("input/day6.txt").byLine.map!(a => a.strip().to!string).array;

    foreach (line; lines) {
        auto big = line.split(")").array[0];
        auto small = line.split(")").array[1];

        if (big !in bodies) {
            bodies[big] = new Body(big);
        }

        if (small !in bodies) {
            bodies[small] = new Body(small);
        }

        bodies[big].sattelites ~= bodies[small];
        bodies[small].orbiting = bodies[big];
    }

    bodies["COM"].orbitCount(0).writeln;
}

void challenge2() {
    Body[string] bodies;

    auto lines = File("input/day6.txt").byLine.map!(a => a.strip().to!string).array;

    foreach (line; lines) {
        auto big = line.split(")").array[0];
        auto small = line.split(")").array[1];

        if (big !in bodies) {
            bodies[big] = new Body(big);
        }

        if (small !in bodies) {
            bodies[small] = new Body(small);
        }

        bodies[big].sattelites ~= bodies[small];
        bodies[small].orbiting = bodies[big];
    }

    bodies["YOU"].findPath(bodies["SAN"], bodies["YOU"], PathInfo(false, 0)).writeln;
}

class Body {
    string name;
    Body orbiting;
    Body[] sattelites;

    this(string n) {
        name = n;
    }

    long orbitCount(long orbit) {
        return orbit + sattelites.map!(s => s.orbitCount(orbit + 1)).sum;
    }

    PathInfo[] findPath(Body target, Body prev, PathInfo pathInfo) {
        if (target.name == name) {
            return [PathInfo(true, pathInfo.steps)];
        }

        auto paths = sattelites
            .filter!(s => s.name != prev.name)
            .map!(s => s.findPath(target, this, PathInfo(false, pathInfo.steps + 1)))
            .join;

        if (orbiting !is null && orbiting.name != prev.name) {
            paths ~= orbiting.findPath(target, this, PathInfo(false, pathInfo.steps + 1));
        }

        if (paths.length == 0) {
            return [];
        }

        return paths.filter!(p => p.found).array;
    }
}

struct PathInfo {
    bool found;
    long steps;
}