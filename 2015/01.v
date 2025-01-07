// https://adventofcode.com/2015/day/1

module main

import os

fn d1_get_data() string {
	data := os.read_file('2015/01.input') or {
		eprintln('Cannot load file ${err}')
		exit(1)
	}

	return data
}

fn d1_get_result() (int, int) {
	mut current_floor := 0
	mut first_time_basement := 0
	data := d1_get_data()

	for i, c in data {
		if c == `(` {
			current_floor += 1
		}

		if c == `)` {
			current_floor -= 1
		}

		if first_time_basement == 0 && current_floor == -1 {
			first_time_basement = i + 1
		}
	}

	return current_floor, first_time_basement
}

fn main() {
	current_floor, first_time_basement := d1_get_result()

	println('/=== Day 1 ===/')
	println('	- part 1: ${current_floor}')
	println('	- part 2: ${first_time_basement}')
}
