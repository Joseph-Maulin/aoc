package y2015Solutions

import "./../../utils"
import "core:crypto/legacy/md5"
import "core:fmt"

@(private = "file")
PUZZLE_INPUT :: "yzbqklnj"

@(private = "file")
check_hash :: proc(num: int) -> [md5.DIGEST_SIZE]u8 {
	ctx: md5.Context
	md5.init(&ctx)

	buf: [32]u8
	data := fmt.bprintf(buf[:], "%s%d", PUZZLE_INPUT, num)
	md5.update(&ctx, transmute([]u8)data)

	digest: [md5.DIGEST_SIZE]u8
	md5.final(&ctx, digest[:])

	return digest
}

day4_p1 :: proc(allocator := context.allocator) {
	fmt.printfln("running solution %d : %s--part1", 2015, "day4")

	i := 0
	for {
		digest := check_hash(i)

		if digest[0] == 0 && digest[1] == 0 && (digest[2] & 0xF0) == 0 {
			fmt.printfln("hash number: %d", i)
			break
		}

		i += 1
	}
}

day4_p2 :: proc(allocator := context.allocator) {
	fmt.printfln("running solution %d : %s--part2", 2015, "day4")

	i := 0
	for {
		digest := check_hash(i)

		if digest[0] == 0 && digest[1] == 0 && digest[2] == 0 {
			fmt.printfln("hash number: %d", i)
			break
		}

		i += 1
	}
}
