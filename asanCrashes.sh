#!/bin/bash


BINARY="/home/osboxes/melonDSOriginal/melonDS/asan_build/melonDS"
CRASH_DIR="/home/osboxes/melonDS/out/default/crashes"
OUTPUT_FILE="crash_summary.txt"
PYTHON_SCRIPT="./extractInfo.py"


> "$OUTPUT_FILE"

for crash_file in "$CRASH_DIR"/*.nds; do
    crash_name=$(basename "$crash_file" .nds)

    echo "Processing $crash_name..."

    # Run the binary and capture stderr to a temporary file
    ASAN_OPTIONS=detect_leaks=0 "$BINARY" "$crash_file" 2>&1 | tee temp_output.txt > /dev/null

    # Run Python parser with temp_output.txt
    parsed_output=$(python3 "$PYTHON_SCRIPT" temp_output.txt)

    # Write result to output file
    {
        echo "$crash_name:"
        if [[ -n "$parsed_output" ]]; then
            echo "$parsed_output"
        else
            echo "No ASAN error detected."
        fi
        echo ""
    } >> "$OUTPUT_FILE"

done

# Clean up
rm -f temp_output.txt
echo "Done. Results written to $OUTPUT_FILE."
