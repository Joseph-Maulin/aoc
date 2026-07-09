package y2015

import solutions "./solutions/"
import "core:fmt"

run :: proc(allocator := context.allocator) {
	context.allocator = allocator
	fmt.println("running aoc 2015!")

	// solutions.day1_p1("y2015/inputs/day1.txt")
	// solutions.day1_p2("y2015/inputs/day1.txt")

	// solutions.day2_p1("y2015/inputs/day2.txt")
	// solutions.day2_p2("y2015/inputs/day2.txt")

	// solutions.day3_p1("y2015/inputs/day3.txt")
	// solutions.day3_p2("y2015/inputs/day3.txt")

	// solutions.day4_p1()
	// solutions.day3_p2()

	// solutions.day5_p1("y2015/inputs/day5.txt")
	// solutions.day5_p2("y2015/inputs/day5.txt")

	solutions.day6_p1("y2015/inputs/day6.txt")
	solutions.day6_p2("y2015/inputs/day6.txt")

}
