package y2015Solutions

import "./../../utils"
import "core:fmt"
import "core:strings"

@(private = "file")
Vec2 :: [2]int

day3_p1 :: proc(input_file_path: string, allocator := context.allocator) {
	fmt.printfln("running solution %d : %s--part1", 2015, "day3")

	input_string, err := utils.read_input_file(input_file_path)
	if err != nil {
		fmt.eprintfln("error: %v", err)
	}

	santa_grid_location := Vec2{0, 0}
	location_cache := make(map[Vec2]struct{})
	location_cache[santa_grid_location] = struct{}{}

	for char in strings.trim_space(input_string) {
		switch char {
		case '<':
			santa_grid_location.x -= 1
		case '^':
			santa_grid_location.y += 1
		case 'v':
			santa_grid_location.y -= 1
		case '>':
			santa_grid_location.x += 1
		}
		location_cache[santa_grid_location] = struct{}{}
	}

	fmt.printfln("unique houses visited: %d", len(location_cache))
}

day3_p2 :: proc(input_file_path: string, allocator := context.allocator) {
	fmt.printfln("running solution %d : %s--part2", 2015, "day3")

	input_string, err := utils.read_input_file(input_file_path)
	if err != nil {
		fmt.eprintfln("error: %v", err)
	}

	santa_grid_location := Vec2{0, 0}
	robo_santa_grid_location := Vec2{0, 0}
	location_cache := make(map[Vec2]struct{})
	location_cache[santa_grid_location] = struct{}{}

	for char, i in strings.trim_space(input_string) {
		deliverer := &santa_grid_location if i % 2 == 0 else &robo_santa_grid_location
		switch char {
		case '<':
			deliverer^.x -= 1
		case '^':
			deliverer^.y += 1
		case 'v':
			deliverer^.y -= 1
		case '>':
			deliverer^.x += 1
		}
		location_cache[deliverer^] = struct{}{}
	}

	fmt.printfln("unique houses visited: %d", len(location_cache))
}
