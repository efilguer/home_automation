import sys

def find_max_battery(string_input):
    percent_end_idx = string_input.find('%') #finds the index of the percent; -2 to get the full substring
    percent_start_idx = percent_end_idx - 2
    battery_percent = string_input[percent_start_idx:percent_end_idx]
    print("inside find_max TEST IN PY", battery_percent)
    return battery_percent

if __name__ == "__main__":
    #input = sys.argv[0]
    input = sys.stdin.read().strip()
    print(input)
    find_max_battery(input)