module main

import crypto.md5

fn get_data() string {
	return 'iwrupvqb'
}

fn is_valid_hash(hash string, match_quant int) bool {
	md5_hash := md5.hexhash(hash)
	hash_start := md5_hash[0..match_quant]

	for c in hash_start {
		if c != `0` {
			return false
		}
	}

	return true
}

fn get_results() (int, int) {
	data := get_data()
	mut counter_part1 := 0
	mut counter_part2 := 0

	for {
		valid_part1 := is_valid_hash('${data}${counter_part1}', 5)
		valid_part2 := is_valid_hash('${data}${counter_part2}', 6)

		if !valid_part1 {
			counter_part1 += 1
		}

		if !valid_part2 {
			counter_part2 += 1
		}

		if valid_part1 && valid_part2 {
			break
		}
	}

	return counter_part1, counter_part2
}

fn main() {
	part_1, part_2 := get_results()
	println('/=== Day 4 ===/')
	println('	- part 1: ${part_1}')
	println('	- part 2: ${part_2}')
}
