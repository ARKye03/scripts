convert_to_gif() {
  while getopts i:o:f:s: flag; do
    case "${flag}" in
    i) input=${OPTARG} ;;
    o) output=${OPTARG} ;;
    f) fps=${OPTARG} ;;
    s) scale=${OPTARG} ;;
    esac
  done

  palette="palette.png"

  # Generate the palette
  ffmpeg -i "$input" -vf "fps=$fps,scale=$scale:-1:flags=lanczos,palettegen" -y $palette

  # Generate the GIF using the palette
  ffmpeg -i "$input" -i $palette -filter_complex "fps=$fps,scale=$scale:-1:flags=lanczos[x];[x][1:v]paletteuse" -y "$output"

  # Clean up the palette file
  rm $palette
}

# Example usage:
# convert_to_gif -i input.mp4 -o output.gif -f 10 -s 320
