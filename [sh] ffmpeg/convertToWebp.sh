#!/bin/bash

# Check if FFmpeg is installed
if! command -v ffmpeg &> /dev/null; then
    echo "FFmpeg could not be found. Please install FFmpeg."
    exit 1
fi

# Input file path passed as an argument
INPUT_FILE=$1

# Output file name, keeping the original extension for clarity
OUTPUT_FILE="${INPUT_FILE%.mp4}.webp"

# Convert to WebP with optimized settings
echo "Converting $INPUT_FILE to WebP..."
ffmpeg -i "$INPUT_FILE" -c:v libwebp -quality 80 -compression_level 6 "$OUTPUT_FILE"
echo "Conversion completed. Output saved as $OUTPUT_FILE."

# Optional: Display the output file size
du -sh "$OUTPUT_FILE"

