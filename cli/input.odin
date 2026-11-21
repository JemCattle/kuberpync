package cli

import "core:bufio"
import str "core:strings"
import "core:strconv"
import "core:fmt"
import "core:reflect"

read_line :: proc(r: ^bufio.Reader) -> (line: string, ok: bool) {
	raw, err := bufio.reader_read_string(r, '\n', context.temp_allocator)
	if err != nil && len(raw) == 0 {
		return "", false
	}
	return str.trim_space(raw), true
}

input_string :: proc(r: ^bufio.Reader, allocator:= context.allocator) -> (val: string, ok: bool) {
	for {
		line := read_line(r) or_return
		if len(line) > 0 {
			return str.clone(line, allocator), true
		}
		fmt.println("Please input text:")
	}
}

input_int :: proc(r: ^bufio.Reader, min, max: int) -> (val: int, ok: bool) {
	for {
		line := read_line(r) or_return
		parsed, parseok := strconv.parse_int(line)
		if parseok && parsed >= min && parsed <= max {
			return parsed, true
		}
		fmt.printfln("Please enter a number between %d and %d (inclusive):", min, max)
	}
}

input_enum :: proc(r: ^bufio.Reader, $T: typeid) -> (val: T, ok: bool) {
	for {
		line := read_line(r) or_return
		normalised := str.to_upper(line, context.temp_allocator)
		if parsed, valid := reflect.enum_from_name(T, normalised); valid {
			return parsed, true
		}
		fmt.printfln("\"%v\" is not valid, try again:", line)
	}
}
