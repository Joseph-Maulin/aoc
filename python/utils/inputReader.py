from collections.abc import Iterator

def read_input_file(input_file_path: str) -> Iterator[str]:
    try:
        file = open(input_file_path, "r")
        for line in file:
            yield line.strip()
        file.close()
    except Exception as e:
        print(f"Error reading input file {input_file_path}: {e}")
