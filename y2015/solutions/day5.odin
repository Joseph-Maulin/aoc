package y2015Solutions

import "./../../utils"
import "core:fmt"
import "core:strings"

@(private = "file")
INVALID_STRINGS :: [4]string{"ab", "cd", "pq", "xy"}
VOWELS :: [5]u8{'a', 'e', 'i', 'o', 'u'}

day5_p1 :: proc(input_file_path: string, allocator := context.allocator) {
	fmt.printfln("running solution %d : %s--part1", 2015, "day5")

	input_string, err := utils.read_input_file(input_file_path)
	if err != nil {
		fmt.printfln("error reading input file: %v", err)
		return
	}

	nice_strings := 0
	letter_cache := map[u8]int{}
	outer_loop: for &line in strings.split_lines(input_string) {
		line = strings.trim_space(line)
		if line == "" do continue

		clear(&letter_cache)
		duplicate_found := false
		for i := 0; i < len(line); i += 1 {
			if i - 1 >= 0 {
				check_slice := line[i - 1:i + 1]
				for invalid_str in INVALID_STRINGS {
					if check_slice == invalid_str do continue outer_loop
				}
				if check_slice[0] == check_slice[1] {
					duplicate_found = true
				}
			}
			letter_cache_val, ok := letter_cache[line[i]]
			if !ok {
				letter_cache[line[i]] = 1
			} else {
				letter_cache[line[i]] = letter_cache_val + 1
			}
		}

		num_vowels := 0
		for v in VOWELS {
			letter_count, ok := letter_cache[v]
			if ok {
				num_vowels += letter_count
			}
		}

		if num_vowels >= 3 && duplicate_found {
			nice_strings += 1
		}
	}

	fmt.printfln("nice strings: %d", nice_strings)
}

@(private = "file")
has_repeat_with_gap :: proc(s: string) -> bool {
	for i := 0; i < len(s) - 2; i += 1 {
		if s[i] == s[i + 2] {
			return true
		}
	}
	return false
}

@(private = "file")
has_repeated_pair :: proc(s: string) -> bool {
	seen := map[string]int{}

	for i := 0; i < len(s) - 1; i += 1 {
		pair := s[i:i + 2]

		if first, ok := seen[pair]; ok {
			if i - first >= 2 {
				return true
			}
		} else {
			seen[pair] = i
		}
	}

	return false
}

day5_p2 :: proc(input_file_path: string, allocator := context.allocator) {
	fmt.printfln("running solution %d : %s--part1", 2015, "day5")

	input_string, err := utils.read_input_file(input_file_path)
	if err != nil {
		fmt.printfln("error reading input file: %v", err)
		return
	}

	nice_strings := 0

	for &line in strings.split_lines(input_string) {
		line = strings.trim_space(line)
		if line == "" do continue

		if has_repeat_with_gap(line[:]) && has_repeated_pair(line[:]) {
			nice_strings += 1
		}
	}

	fmt.printfln("nice strings: %d", nice_strings)
}
