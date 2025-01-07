// Run this with `v run generate-files-for-year <year>`

module main

import os

fn main() {
	year := os.args[1]
	directory := '${year}/'

	if !os.exists(year) {
		os.mkdir(year)!
	}

	for i := 1; i <= 25; i += 1 {
		mut filename := directory
		day_number_str := i.str()

		if i < 10 {
			filename += '0' + day_number_str
		} else {
			filename += day_number_str
		}

		vfile := '${filename}.v'
		ifile := '${filename}.input'

		if !os.exists(ifile) {
			mut ifv := os.create(ifile)!
			ifv.close()
		}

		if !os.exists(vfile) {
			mut f := os.create(vfile)!

			f.writeln('module main')!
			f.writeln('')!
			f.writeln('fn part1() int {')!
			f.writeln('    return 0')!
			f.writeln('}')!
			f.writeln('')!
			f.writeln('fn part2() int {')!
			f.writeln('    return 0')!
			f.writeln('}')!
			f.writeln('')!

			f.writeln('fn main() {')!
			f.writeln("    println('/=== Day ${day_number_str} ===/')")!
			f.writeln("    println('\t- part 1: \${part1()}')")!
			f.writeln("    println('\t- part 2: \${part2()}')")!
			f.writeln('}')!

			f.flush()
			f.close()

			println('File ${filename} created')
		}
	}
}
