module main

import os

struct Coords {
mut:
	x int
	y int
}

fn get_data() string {
	data := os.read_file('2015/03.input') or {
		eprintln('Cannot read file ${err}')
		exit(1)
	}

	return data
}

fn part1() int {
	data := get_data()
	mut places_visited := [
		Coords{0, 0},
	]
	mut current_pos := Coords{0, 0}

	for c in data {
		match c {
			`^` { current_pos.y -= 1 }
			`v` { current_pos.y += 1 }
			`<` { current_pos.x -= 1 }
			`>` { current_pos.x += 1 }
			else {}
		}

		mut found := false

		for p in places_visited {
			if current_pos == p {
				found = true
				break
			}
		}

		if !found {
			places_visited.prepend(current_pos)
		}
	}

	return places_visited.len
}

fn part2() int {
	data := get_data()
	mut places_visited := [
		Coords{0, 0},
	]
	mut reg_santa_pos := Coords{0, 0}
	mut robo_santa_pos := Coords{0, 0}

	for i, c in data {
		mut delta_pos := Coords{0, 0}

		match c {
			`^` { delta_pos.y = -1 }
			`v` { delta_pos.y = 1 }
			`<` { delta_pos.x = -1 }
			`>` { delta_pos.x = 1 }
			else {}
		}

		if i % 2 == 0 {
			robo_santa_pos.x += delta_pos.x
			robo_santa_pos.y += delta_pos.y
			places_visited.prepend(robo_santa_pos)
		} else {
			reg_santa_pos.x += delta_pos.x
			reg_santa_pos.y += delta_pos.y
			places_visited.prepend(reg_santa_pos)
		}
	}

	mut places_visited_once := [
		Coords{0, 0},
	]

	for p in places_visited {
		mut found_place := false

		for p1 in places_visited_once {
			if p == p1 {
				found_place = true
				break
			}
		}

		if !found_place {
			places_visited_once.prepend(p)
		}
	}

	return places_visited_once.len
}

fn main() {
	println('/=== Day 3 ===/')
	println('	- part 1: ${part1()}')
	println('	- part 2: ${part2()}')
}
