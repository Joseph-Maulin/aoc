package y2015Solutions

import "./../../utils"
import "core:fmt"
import "core:slice"
import "core:strconv"
import "core:strings"

@(private = "file")
parse_line_measurements :: proc(line: string) -> (length: int, width: int, height: int, ok: bool) {
	line_parts := strings.split(line, "x")
	if len(line_parts) != 3 {
		fmt.eprintfln("invalid number of line parts: %s", line)
		return
	}
	parsed_length, length_parse_ok := strconv.parse_int(line_parts[0])
	if !length_parse_ok {
		fmt.eprintfln("invalid length format: %s", line_parts[0])
		return
	}
	parsed_width, width_parse_ok := strconv.parse_int(line_parts[1])
	if !width_parse_ok {
		fmt.eprintfln("invalid width format: %s", line_parts[1])
		return
	}

	parsed_height, height_parse_ok := strconv.parse_int(line_parts[2])
	if !height_parse_ok {
		fmt.eprintfln("invalid height format: %s", line_parts[2])
		return
	}

	return parsed_length, parsed_width, parsed_height, true
}

day2_p1 :: proc(input_file_path: string, allocator := context.allocator) {
	fmt.printfln("running solution %d : %s--part1", 2015, "day2")

	input_string, err := utils.read_input_file(input_file_path)
	if err != nil {
		fmt.eprintfln("error: %v", err)
	}

	total_sa := 0

	for &line in strings.split_lines(input_string) {
		line = strings.trim_space(line)
		if line == "" do continue

		length, width, height, ok := parse_line_measurements(line)
		if !ok {
			continue
		}

		sa := 2 * length * width + 2 * width * height + 2 * height * length

		sides := [3]int{length, width, height}
		slice.sort(sides[:])

		sa += sides[0] * sides[1]

		total_sa += sa
	}

	fmt.printfln("total square feet of wrapping paper: %d", total_sa)
}

day2_p2 :: proc(input_file_path: string, allocator := context.allocator) {
	fmt.printfln("running solution %d : %s--part2", 2015, "day2")

	input_string, err := utils.read_input_file(input_file_path)
	if err != nil {
		fmt.eprintfln("error: %v", err)
	}

	total_feet_of_ribbon := 0

	for &line in strings.split_lines(input_string) {
		line = strings.trim_space(line)

		length, width, height, ok := parse_line_measurements(line)
		if !ok {
			continue
		}

		sides := [3]int{length, width, height}
		slice.sort(sides[:])

		feet_of_ribbon := sides[0] * 2 + sides[1] * 2 + sides[0] * sides[1] * sides[2]
		total_feet_of_ribbon += feet_of_ribbon
	}

	fmt.printfln("total feet of ribbon: %d", total_feet_of_ribbon)
}
