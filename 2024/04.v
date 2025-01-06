module main

import os

struct Vector2 {
	x int
	y int
}

const available_chars = [`X`, `M`, `A`, `S`]
const d4_test_data = [
	[`M`, `M`, `M`, `S`, `X`, `X`, `M`, `A`, `S`, `M`],
	[`M`, `S`, `A`, `M`, `X`, `M`, `S`, `M`, `S`, `A`],
	[`A`, `M`, `X`, `S`, `X`, `M`, `A`, `A`, `M`, `M`],
	[`M`, `S`, `A`, `M`, `A`, `S`, `M`, `S`, `M`, `X`],
	[`X`, `M`, `A`, `S`, `A`, `M`, `X`, `A`, `M`, `M`],
	[`X`, `X`, `A`, `M`, `M`, `X`, `X`, `A`, `M`, `A`],
	[`S`, `M`, `S`, `M`, `S`, `A`, `S`, `X`, `S`, `S`],
	[`S`, `A`, `X`, `A`, `M`, `A`, `S`, `A`, `A`, `A`],
	[`M`, `A`, `M`, `M`, `M`, `X`, `M`, `M`, `M`, `M`],
	[`M`, `X`, `M`, `X`, `A`, `X`, `M`, `A`, `S`, `X`],
]

__global (
	d4_data [][]rune
)

fn init() {
	text := os.read_file('2024/04.input') or {
		eprintln('Cannot read input file ${err}')
		exit(1)
	}
	lines := text.split_into_lines()

	for line in lines {
		d4_data.prepend(line.runes())
	}

	d4_data.reverse_in_place()
}

fn is_char_valid(new_x int, new_y int, char_to_validate rune) bool {
	max_x := d4_data[0].len - 1
	max_y := d4_data.len - 1

	if new_x >= 0 && new_x <= max_x && new_y >= 0 && new_y <= max_y
		&& d4_data[new_y][new_x] == char_to_validate {
		return true
	}

	return false
}

fn count_sequential_matches(x int, y int) int {
	mut found := 0
	mut search_positions := [
		[true, true, true],
		[true, false, true],
		[true, true, true],
	]

	// search
	for offset := 1; offset < 4; offset += 1 {
		current_char_to_find := available_chars[offset]

		for dy := -1; dy < 2; dy += 1 {
			for dx := -1; dx < 2; dx += 1 {
				x_offset := x + offset * dx
				y_offset := y + offset * dy

				if search_positions[dy + 1][dx + 1] {
					search_positions[dy + 1][dx + 1] = is_char_valid(x_offset, y_offset,
						current_char_to_find)
				}
			}
		}
	}

	// count valid findings
	for cy := 0; cy < search_positions.len; cy += 1 {
		for cx := 0; cx < search_positions[cy].len; cx += 1 {
			if search_positions[cy][cx] {
				found += 1
			}
		}
	}

	return found
}

fn d4p1() int {
	mut count := 0

	for y := 0; y < d4_data.len; y += 1 {
		for x := 0; x < d4_data[y].len; x += 1 {
			current_char := d4_data[y][x]

			if current_char == `X` {
				count += count_sequential_matches(x, y)
			}
		}
	}

	return count
}

fn d4p2() int {
	mut count := 0

	for y := 1; y < d4_data.len - 1; y += 1 {
		for x := 1; x < d4_data[y].len - 1; x += 1 {
			current_char := d4_data[y][x]

			if current_char == `A` {
				str_a := '${d4_data[y - 1][x - 1]}A${d4_data[y + 1][x + 1]}'
				str_b := '${d4_data[y - 1][x + 1]}A${d4_data[y + 1][x - 1]}'

				if (str_a == 'SAM' || str_a == 'MAS') && (str_b == 'SAM' || str_b == 'MAS') {
					count += 1
				}
			}
		}
	}

	return count
}

fn day4() {
	println('/=== Day 4 ===/')
	println('	- part 1: ${d4p1()}')
	println('	- part 2: ${d4p2()}')
}
