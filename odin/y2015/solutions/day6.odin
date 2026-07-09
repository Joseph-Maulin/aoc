package y2015Solutions

import "./../../utils"
import "core:fmt"
import "core:mem"
import "core:strconv"
import "core:strings"

@(private = "file")
LIGHT_GRID_MATRIX :: [1000][1000]i8
light_grid: LIGHT_GRID_MATRIX

LightGridCmdAction :: enum {
	TOGGLE,
	TURN_OFF,
	TURN_ON,
}

LightGridCmd :: struct {
	action:       LightGridCmdAction,
	range_low_x:  int,
	range_high_x: int,
	range_low_y:  int,
	range_high_y: int,
}

LightGridParseError :: enum {
	None,
	ParseError,
	UnknownCmd,
}

parse_range :: proc(range: string) -> (int, int, LightGridParseError) {
	range_split := strings.split_n(range, ",", 2)
	l, lok := strconv.parse_int(range_split[0])
	if !lok {
		return 0, 0, .ParseError
	}
	h, hok := strconv.parse_int(range_split[1])
	if !hok {
		return 0, 0, .ParseError
	}
	return l, h, .None
}

parse_light_grid_cmd :: proc(cmd: string) -> (LightGridCmd, LightGridParseError) {
	cmd_fields := strings.fields(cmd)
	cmd_val: string
	range_low_x: int
	range_low_y: int
	range_high_x: int
	range_high_y: int
	action: LightGridCmdAction
	err: LightGridParseError
	switch cmd_fields[0] {
	case "toggle":
		action = LightGridCmdAction.TOGGLE
		range_low_x, range_low_y, err = parse_range(cmd_fields[1])
		if err != .None {
			return {}, err
		}
		range_high_x, range_high_y, err = parse_range(cmd_fields[3])
		if err != .None {
			return {}, err
		}
	case "turn":
		cmd_val = strings.join(cmd_fields[:2], "_")
		switch cmd_val {
		case "turn_on":
			action = LightGridCmdAction.TURN_ON
		case "turn_off":
			action = LightGridCmdAction.TURN_OFF
		}
		range_low_x, range_low_y, err = parse_range(cmd_fields[2])
		if err != .None {
			return {}, err
		}
		range_high_x, range_high_y, err = parse_range(cmd_fields[4])
		if err != .None {
			return {}, err
		}
	case:
		return {}, .UnknownCmd
	}
	return LightGridCmd {
			action = action,
			range_low_x = range_low_x,
			range_low_y = range_low_y,
			range_high_x = range_high_x,
			range_high_y = range_high_y,
		},
		.None
}

@(private = "file")
count_light_grid_brightness :: proc() -> (lit: int) {
	for row in light_grid {
		for light in row {
			lit += int(light)
		}
	}
	return
}

day6_p1 :: proc(input_file_path: string, allocator := context.allocator) {
	fmt.printfln("running solution %d : %s--part1", 2015, "day6")
	defer mem.zero_item(&light_grid)

	input_string, err := utils.read_input_file(input_file_path)
	if err != nil {
		fmt.printfln("error reading input file: %v", err)
		return
	}

	for &line in strings.split_lines(input_string) {
		line = strings.trim_space(line)
		if line == "" do continue

		cmd := parse_light_grid_cmd(line) or_continue

		switch cmd.action {
		case .TOGGLE:
			for i := cmd.range_low_y; i < cmd.range_high_y + 1; i += 1 {
				for j := cmd.range_low_x; j < cmd.range_high_x + 1; j += 1 {
					light_grid[i][j] = 0 if light_grid[i][j] == 1 else 1
				}
			}
		case .TURN_OFF:
			for i := cmd.range_low_y; i < cmd.range_high_y + 1; i += 1 {
				for j := cmd.range_low_x; j < cmd.range_high_x + 1; j += 1 {
					light_grid[i][j] = 0
				}
			}
		case .TURN_ON:
			for i := cmd.range_low_y; i < cmd.range_high_y + 1; i += 1 {
				for j := cmd.range_low_x; j < cmd.range_high_x + 1; j += 1 {
					light_grid[i][j] = 1
				}
			}
		}
	}

	lit := count_light_grid_brightness()
	fmt.printfln("lit: %d", lit)
}

day6_p2 :: proc(input_file_path: string, allocator := context.allocator) {
	fmt.printfln("running solution %d : %s--part2", 2015, "day6")
	defer mem.zero_item(&light_grid)

	input_string, err := utils.read_input_file(input_file_path)
	if err != nil {
		fmt.printfln("error reading input file: %v", err)
		return
	}

	for &line in strings.split_lines(input_string) {
		line = strings.trim_space(line)
		if line == "" do continue

		cmd := parse_light_grid_cmd(line) or_continue

		switch cmd.action {
		case .TOGGLE:
			for i := cmd.range_low_y; i < cmd.range_high_y + 1; i += 1 {
				for j := cmd.range_low_x; j < cmd.range_high_x + 1; j += 1 {
					light_grid[i][j] += 2
				}
			}
		case .TURN_OFF:
			for i := cmd.range_low_y; i < cmd.range_high_y + 1; i += 1 {
				for j := cmd.range_low_x; j < cmd.range_high_x + 1; j += 1 {
					light_grid[i][j] = max(light_grid[i][j] - 1, 0)
				}
			}
		case .TURN_ON:
			for i := cmd.range_low_y; i < cmd.range_high_y + 1; i += 1 {
				for j := cmd.range_low_x; j < cmd.range_high_x + 1; j += 1 {
					light_grid[i][j] += 1
				}
			}
		}
	}

	lit := count_light_grid_brightness()
	fmt.printfln("lit: %d", lit)
}
