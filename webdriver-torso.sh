usage="$(basename "$0") [-h] [-v <number>] [-s <number>] [-t <text>] -- program to generate Webdriver Torso-esque video clips

where:
    -h  show this help text
    -v  set the number of videos to generate (default: 1)
    -s  set the number of slides to generate for each video (default: 10)
    -t  set the text that appears before each slide number (default: aqua.flv)" 

while getopts ':hv:s:t:' option; do
  case "$option" in
    h) echo "$usage"
       exit
       ;;
    v) VIDEOS=$OPTARG
       ;;
	s) SLIDES=$OPTARG
       ;;
	t) TEXT=$OPTARG
       ;;
    :) printf "missing argument for -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
   \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
  esac
done
shift $((OPTIND - 1))

C1=0

while [ ${C1:-0} -lt ${VIDEOS:-1} ]; do

	C2=0

	# Generate random 6 digit video ID and delete tmp file
	VIDEO=$(mktemp XXXXXX)
	rm $VIDEO

	# Generate slide audio and video in loop
	while [ ${C2:-0} -lt ${SLIDES:-10} ]; do
		# Generate random numbers in range for SINE wave frequency and rectangle coordinates
		SINE=$((RANDOM%3300+300))
		rec1_x1=$((RANDOM%640+0))
		rec1_x2=$((RANDOM%640+0))
		rec1_y1=$((RANDOM%330+0))
		rec1_y2=$((RANDOM%330+0))
		rec2_x1=$((RANDOM%640+0))
		rec2_x2=$((RANDOM%640+0))
		rec2_y1=$((RANDOM%330+0))
		rec2_y2=$((RANDOM%330+0))
		
		# Uses ImageMagick library to generate slide pictures (http://imagemagick.org/)
		convert -size '640x360' xc:white -fill red -draw "rectangle ${rec1_x1},${rec1_y1},${rec1_x2},${rec1_y2}" -fill blue  -draw "rectangle ${rec2_x1},${rec2_y1},${rec2_x2},${rec2_y2}" -font 'Courier-Bold' -fill black -draw "text 10,340 '${TEXT-aqua.flv} - Slide 000${C2}'" ./process/${C2}.png
		
		# Uses sox library to generate a sine wave (http://sox.sourceforge.net/)
		sox -n ./process/${C2}.wav synth 1 sine $SINE
		let C2=C2+1
	done

	# Combine all individual sine waves into a single audio file
	sox ./process/*.wav ./process/tone.wav

	# Uses ffmpeg to combine each PNG file into a single mp4 video (https://www.ffmpeg.org/)
	# FYI: The settings here are Youtube's recomendation for prepping video with ffmpeg for upload, so trust me that this is *probably* a best practice.
	ffmpeg -framerate 1 -i ./process/%d.png -vf fps=10 -s:v 1280x720 -c:v libx264 -profile:v high -crf 20 -pix_fmt yuv420p ./process/video.mp4

	# Finally combine the video and audio files together
	ffmpeg -i ./process/video.mp4 -i ./process/tone.wav -c:v copy -c:a aac -strict experimental ./videos/tmp${VIDEO}.mp4

	# Remove all the source files generated along the way
	rm ./process/*.*
	let C1=C1+1
done