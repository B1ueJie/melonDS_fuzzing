import sys
import re

if len(sys.argv) < 2:
    print("Usage: python3 extractInfo.py <log_file>")
    sys.exit(1)

with open(sys.argv[1], "r") as f:
    log = f.read()

# Extract error type (from 'ERROR: AddressSanitizer: ...')
error_match = re.search(r'ERROR: AddressSanitizer: ([^\d\n]+)', log)
error_type = error_match.group(1).strip() if error_match else "UnknownError"

# Extract file location (from the first '#1' backtrace line with a source file)
location_match = re.search(r'#1.*?(/[^ ]+\.(cpp|c|h):\d+:\d+)', log)
location = location_match.group(1).strip() if location_match else "UnknownLocation"

print(f"AddressSanitizer: {error_type} AT LOCATION {location}")
