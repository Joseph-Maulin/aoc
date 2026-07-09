from utils.inputReader import read_input_file

def day1_p1(input_file_path: str):
    print("running solution 2015 : day1--part1")
    floor = 0
    for line in read_input_file(input_file_path):
        for c in line:
            match c:
                case "(":
                    floor += 1
                case ")":
                    floor -= 1

    print(f"final floor: {floor}")

def day1_p2(input_file_path: str):
    print("running solution 2015 : day1--part2")
    floor = 0
    for line in read_input_file(input_file_path):
        for i, c in enumerate(line):
            match c:
                case "(":
                    floor += 1
                case ")":
                    floor -= 1

            if floor < 0:
                print(f"entered basement at: {i + 1}")
                return
    print("did not enter basement")
