module main

import os

fn d1_get_data() ([]int, []int) {
	mut left_list := []int{}
	mut right_list := []int{}

	text := os.read_file('2024/01.input') or {
		eprintln('Cannot open file: ${err}')
		exit(1)
	}

	lines := text.split_into_lines()

	for line in lines {
		left_item := line[0..5]
		right_item := line[8..13]

		left_list.prepend(left_item.int())
		right_list.prepend(right_item.int())
	}

	return left_list, right_list
}

fn d1p1() int {
	mut left_list, mut right_list := d1_get_data()
	mut total_distance := 0

	left_list.sort(a > b)
	right_list.sort(a > b)

	for left_list.len != 0 {
		a := left_list.pop()
		b := right_list.pop()
		mut distance := 0

		if a > b {
			distance = a - b
		} else if b > a {
			distance = b - a
		}

		total_distance += distance
	}

	return total_distance
}

fn d1p2() int {
	mut left_list, mut right_list := d1_get_data()
	mut similarity_score := 0

	for id in left_list {
		filtered_right_list := right_list.filter(it == id)
		similarity_score += id * filtered_right_list.len
	}

	return similarity_score
}

fn main() {
	println('/=== Day 1 ===/')
	println('\t- part 1: ${d1p1()}')
	println('\t- part 2: ${d1p2()}')
}
