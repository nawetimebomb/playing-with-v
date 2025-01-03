module main

import math
import os
import strconv

const test_data = [
	[7, 6, 4, 2, 1],
	[1, 2, 7, 8, 9],
	[9, 7, 6, 2, 1],
	[1, 3, 2, 4, 5],
	[8, 6, 4, 4, 1],
	[1, 3, 6, 7, 9],
]

fn get_reports() [][]int {
	mut reports := [][]int{}

	text := os.read_file('2024/02.txt') or {
		eprintln('Error reading file ${err}')
		exit(1)
	}
	lines := text.split_into_lines()

	for line in lines {
		mut levels := []int{}
		mut value := ''

		line_runes := line.runes()

		for i, r in line_runes {
			if r != ` ` {
				value += r.str()
			}

			if r == ` ` || i == line_runes.len - 1 {
				level := strconv.atoi(value) or {
					eprintln('Error converting to int ${value} ${err}')
					exit(2)
				}
				levels.prepend(level)
				value = ''
			}
		}

		reports.prepend(levels.reverse())
	}

	return reports
}

fn is_safe(report []int) bool {
	expected_sign := math.signi(report[1] - report[0])

	for i := 1; i < report.len; i += 1 {
		a := report[i - 1]
		b := report[i]
		delta := b - a

		if math.signi(delta) != expected_sign {
			return false
		}

		if delta == 0 || delta < -3 || delta > 3 {
			return false
		}
	}

	return true
}

fn find_first_unsafe_index(report []int) int {
	expected_sign := math.signi(report[1] - report[0])

	for i := 1; i < report.len; i += 1 {
		a := report[i - 1]
		b := report[i]
		delta := b - a

		if math.signi(delta) != expected_sign {
			return i - 1
		}

		if delta == 0 || delta < -3 || delta > 3 {
			return i - 1
		}
	}

	return -1
}

fn is_safe_with_dampener(report []int) bool {
	unsafe_index := find_first_unsafe_index(report)

	if unsafe_index >= 0 {
		mut new_report := report.clone()
		new_report.delete(unsafe_index)
		return is_safe(new_report)
	}

	return true
}

fn d2p1() int {
	reports := get_reports()
	mut safe_reports := 0

	for report in reports {
		if is_safe(report) {
			safe_reports += 1
		}
	}

	return safe_reports
}

fn d2p2() int {
	reports := get_reports()
	mut safe_reports := 0

	for report in reports {
		if is_safe_with_dampener(report) {
			safe_reports += 1
		}
	}

	return safe_reports
}

fn day2() {
	println('/=== Day 2 ===/')
	println('\t- part 1: ${d2p1()}')
	println('\t- part 2: ${d2p2()}')
}
