module main

import os

struct Word {
	str     string
	indices []int
}

fn get_data() []string {
	mut data := []string{}
	text := os.read_file('2015/05.input') or {
		eprintln('Cannot read file ${err}')
		exit(1)
	}
	lines := text.split_into_lines()

	for line in lines {
		data.prepend(line)
	}

	return data
}

fn part1() int {
	mut good_counter := 0
	data := get_data()

	for str in data {
		mut vowels_count := 0
		mut valid_consecutive_chars_found := false
		mut invalid_consecutive_chars_found := false

		for i, c in str {
			if i + 1 < str.len {
				next_char := str[i + 1]

				if !valid_consecutive_chars_found && next_char == c {
					valid_consecutive_chars_found = true
				}

				if !invalid_consecutive_chars_found {
					match c {
						`a` { invalid_consecutive_chars_found = next_char == `b` }
						`c` { invalid_consecutive_chars_found = next_char == `d` }
						`p` { invalid_consecutive_chars_found = next_char == `q` }
						`x` { invalid_consecutive_chars_found = next_char == `y` }
						else {}
					}
				}
			}

			match c {
				`a`, `e`, `i`, `o`, `u` { vowels_count += 1 }
				else {}
			}
		}

		if vowels_count > 2 && valid_consecutive_chars_found && !invalid_consecutive_chars_found {
			good_counter += 1
		}
	}

	return good_counter
}

fn part2() int {
	mut good_counter := 0
	data := get_data()

	for str in data {
		mut valid_words := []Word{}
		mut valid_repeat_char_with_one_between := false
		mut repeated_pairs := 0

		for i, c in str {
			if i + 2 < str.len {
				if !valid_repeat_char_with_one_between && c == str[i + 2] {
					valid_repeat_char_with_one_between = true
				}
			}

			if i + 1 < str.len {
				valid_words.prepend(Word{
					str:     '${c.ascii_str()}${str[i + 1].ascii_str()}'
					indices: [i, i + 1]
				})
			}
		}

		for wi, w in valid_words {
			for x := wi + 1; x < valid_words.len; x += 1 {
				w1 := valid_words[x]

				if w.str == w1.str && w.indices[0] != w1.indices[1] && w.indices[1] != w1.indices[0] {
					repeated_pairs += 1
				}
			}
		}

		if valid_repeat_char_with_one_between && repeated_pairs > 0 {
			good_counter += 1
		}
	}

	return good_counter
}

fn main() {
	println('/=== Day 5 ===/')
	println('	- part 1: ${part1()}')
	println('	- part 2: ${part2()}')
}
