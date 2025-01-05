// Run this with `v run generate-files-for-year <year>`

module main

import os

fn main() {
	year := os.args[1]
	directory := '${year}/'
	main_filename := '${directory}main.v'

	if !os.exists(year) {
		os.mkdir(year)!
	}

	if os.exists(main_filename) {
		os.rm(main_filename)!
	}

	mut main_file := os.create(main_filename) or {
		eprintln('Error creating main file ${err}')
		exit(2)
	}

	main_file.writeln('module main')!
	main_file.writeln('')!
	main_file.writeln('fn main() {')!

	for i := 1; i <= 25; i += 1 {
		mut file := directory
		day_number_str := i.str()

		if i < 10 {
			file += '0' + day_number_str
		} else {
			file += day_number_str
		}

		file += '.v'

		main_file.writeln('    day${day_number_str}()')!

		if !os.exists(file) {
			mut f := os.create(file)!

			f.writeln('module main')!
			f.writeln('')!
			f.writeln('fn d${day_number_str}p1() int {')!
			f.writeln('    return 0')!
			f.writeln('}')!
			f.writeln('')!
			f.writeln('fn d${day_number_str}p2() int {')!
			f.writeln('    return 0')!
			f.writeln('}')!
			f.writeln('')!

			f.writeln('fn day${day_number_str}() {')!
			f.writeln("    println('/=== Day ${day_number_str} ===/')")!
			f.writeln("    println('\t- part 1: \${d${day_number_str}p1()}')")!
			f.writeln("    println('\t- part 2: \${d${day_number_str}p2()}')")!
			f.writeln('}')!

			f.flush()
			f.close()

			println('File ${file} created')
		}
	}

	main_file.writeln('}')!

	main_file.flush()
	main_file.close()
}
