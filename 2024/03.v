module main

import os
import strconv

const d3_test_data = 'xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))'
const d3_p2_test_data = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

fn d3_get_data() string {
	input := os.read_file('2024/03.input') or {
		eprintln('Cannot open file ${err}')
		exit(1)
	}

	return input
}

fn process_mul_instruction(input string) (int, int) {
	mut closing_paren_index := 0
	mut comma_index := 0
	mut product := 0
	mut left_operand := 0
	mut right_operand := 0
	max_length_of_multiplication := 12
	last_index := if max_length_of_multiplication < input.len {
		max_length_of_multiplication
	} else {
		input.len - 1
	}
	opening_paren_index := 4
	slice_of_input := input[0..last_index]
	initial_match := slice_of_input[0..opening_paren_index]

	if initial_match == 'mul(' {
		for i, c in slice_of_input {
			if c == `,` {
				comma_index = i
			}

			if c == `)` {
				closing_paren_index = i
				break
			}
		}

		if closing_paren_index > opening_paren_index && comma_index != 0 {
			left_operand = strconv.atoi(slice_of_input[opening_paren_index..comma_index]) or { 0 }
			right_operand = strconv.atoi(slice_of_input[comma_index + 1..closing_paren_index]) or {
				0
			}

			product = left_operand * right_operand
		}
	}

	return product, closing_paren_index
}

fn d3p1() int {
	mut result := 0
	input := d3_get_data()

	for i := 0; i < input.len; i += 1 {
		curr_char := input[i]

		if curr_char == `m` {
			product, new_index_offset := process_mul_instruction(input[i..])
			result += product
			i += new_index_offset
		}
	}

	return result
}

fn d3p2() int {
	mut result := 0
	mut instructions_enabled := true
	input := d3_get_data()

	for i := 0; i < input.len; i += 1 {
		curr_char := input[i]

		if instructions_enabled && curr_char == `m` {
			product, new_index_offset := process_mul_instruction(input[i..])
			result += product
			i += new_index_offset
		} else if curr_char == `d` {
			do_instruction_test := input[i..i + 4]
			dont_instruction_test := input[i..i + 7]

			if do_instruction_test == 'do()' {
				instructions_enabled = true
			} else if dont_instruction_test == "don't()" {
				instructions_enabled = false
			}
		}
	}

	return result
}

fn main() {
	println('/=== Day 3 ===/')
	println('\t- part 1: ${d3p1()}')
	println('\t- part 2: ${d3p2()}')
}
