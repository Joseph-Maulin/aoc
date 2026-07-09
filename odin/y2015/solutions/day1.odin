package y2015Solutions

import "./../../utils"
import "core:fmt"

day1_p1 :: proc(input_file_path: string, allocator := context.allocator) {
	fmt.printfln("running solution %d : %s--part1", 2015, "day1")
	input_string, err := utils.read_input_file(input_file_path)
	if err != nil {
		fmt.eprintfln("error: %v", err)
	}

	curr_floor := 0
	for x in input_string {
		switch x {
		case '(':
			curr_floor += 1
		case ')':
			curr_floor -= 1
		}
	}

	fmt.printfln("result floor: %d", curr_floor)
}

day1_p2 :: proc(input_file_path: string, allocator := context.allocator) {
	fmt.printfln("running solution %d : %s--part1", 2015, "day2")
	input_string, err := utils.read_input_file(input_file_path)
	if err != nil {
		fmt.eprintfln("error: %v", err)
	}

	entered_basement := 0
	curr_floor := 0
	for x, i in input_string {
		switch x {
		case '(':
			curr_floor += 1
		case ')':
			curr_floor -= 1
		}

		if curr_floor < 0 {
			entered_basement = i + 1
			break
		}
	}

	if entered_basement == 0 {
		fmt.eprintln("never entered basement")
	} else {
		fmt.printfln("entered basement: %d", entered_basement)
	}
}
