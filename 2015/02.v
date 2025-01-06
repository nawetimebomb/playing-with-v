// https://adventofcode.com/2015/day/2
// 2*l*w + 2*w*h + 2*h*l

module main

import math
import os
import strconv

struct PaperSize {
	l int
	w int
	h int
}

fn d2_get_data() []PaperSize {
	mut data := []PaperSize{}
	text := os.read_file('2015/02.input') or {
		eprintln('Cannot read file ${err}')
		exit(1)
	}
	lines := text.split_into_lines()

	for line in lines {
		mut cp := []string{}
		mut curr_value := []rune{}

		for i, c in line {
			curr_value.prepend(c)

			if c == `x` || i == line.len - 1 {
				mut result := ''

				if c == `x` {
					curr_value.delete(0)
				}

				curr_value.reverse_in_place()

				for v in curr_value {
					result += v.str()
				}

				cp.prepend(result)
				curr_value.clear()
			}
		}
		l := strconv.atoi(cp[2]) or { 0 }
		w := strconv.atoi(cp[1]) or { 0 }
		h := strconv.atoi(cp[0]) or { 0 }

		data.prepend(PaperSize{l, w, h})
	}

	return data
}

fn d2p1p2() (int, int) {
	data := d2_get_data()
	mut total_wrap_square_feet := 0
	mut ribbon_feet := 0

	for gift in data {
		side_1 := gift.l * gift.w
		side_2 := gift.w * gift.h
		side_3 := gift.h * gift.l
		smallest_side := math.min(side_1, math.min(side_2, side_3))
		largest_number := math.max(gift.l, math.max(gift.w, gift.h))
		side_ribbon_size := gift.l * 2 + gift.w * 2 + gift.h * 2 - largest_number * 2
		bow_size := gift.l * gift.w * gift.h

		total_wrap_square_feet += (2 * side_1 + 2 * side_2 + 2 * side_3) + smallest_side
		ribbon_feet += side_ribbon_size + bow_size
	}

	return total_wrap_square_feet, ribbon_feet
}

fn day2() {
	part_1, part_2 := d2p1p2()
	println('/=== Day 2 ===/')
	println('	- part 1: ${part_1}')
	println('	- part 2: ${part_2}')
}
