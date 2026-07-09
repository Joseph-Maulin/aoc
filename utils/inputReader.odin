package utils

import "core:fmt"
import "core:os"

read_input_file :: proc(
	input_file_path: string,
	allocator := context.allocator,
) -> (
	input: string,
	err: os.Error,
) {
	path := fmt.tprintf("../%s", input_file_path)
	bytes := os.read_entire_file(input_file_path, allocator = allocator) or_return
	return string(bytes), nil
}
