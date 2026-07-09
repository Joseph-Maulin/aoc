package main

import "core:mem"
import "y2015"

main :: proc() {
	arena_mem := make([]byte, 1 * mem.Megabyte)
	arena: mem.Arena
	mem.arena_init(&arena, arena_mem)
	arena_alloc := mem.arena_allocator(&arena)
	defer delete(arena_mem)

	y2015.run(allocator = arena_alloc)
	mem.free_all(arena_alloc)
}
