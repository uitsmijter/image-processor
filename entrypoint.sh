#!/bin/bash
#set -x

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

isSysctl=$(which sysctl)
isNproc=$(which nproc)
if [ ! -z ${isSysctl} ]; then
	CPUCOUNT=$(sysctl -n hw.ncpu 2>/dev/null || echo "4")
elif [ ! -z ${isNproc} ]; then
	CPUCOUNT=$(nproc --all 2>/dev/null || echo "4")
else
	CPUCOUNT=4
fi

 function help() {
    echo "Resize images in various formats: "
    echo ""
    echo "        -i |         input folder"
    echo "        -o |         output folder"
    echo "        -s |         sizes to generate"
    echo ""
    echo " Formats generated: jpeg, webp, avif"
    echo ""
    exit ${1:-1}
}

function resize {
	folder=${1}
	target=${2}
	size=${3}
	
	mkdir -p ${target}/${size}
	for originalImage in "${folder}"/*.jpg; do
		baseName=$(basename ${originalImage%.*})
		targetName=${target}/${size}/${baseName}

		if [ ! -f "${targetName}" ]; then
			echo "  - ${originalImage} in ${size}/jpg -> ${targetName}.jpg"
			ffmpeg -y -i ${originalImage} \
				-vf scale=${size}:-1 \
				-threads ${CPUCOUNT} \
				${targetName}.jpg \
				2> /dev/null
		else
			echo "skip. Already present: ${targetName}.jpg"
		fi

		if [ ! -f "${targetName}.webp" ]; then
			echo "  - ${originalImage} in ${size}/webp -> ${targetName}.webp"
			ffmpeg -y -i ${originalImage} \
				-vf scale=${size}:-1 \
				-threads ${CPUCOUNT} \
				${targetName}.webp \
				2> /dev/null
		else
			echo "skip. Already present: ${targetName}.webp"
		fi

		if [ ! -f "${targetName}.avif" ]; then
			echo "  - ${originalImage} in ${size}/avif"
			npx avif \
				--input="${targetName}.jpg" \
				--quality 60 \
				--effort 7 \
				--overwrite
		else
			echo "skip. Already present: ${targetName}.avif"
		fi

	done;
}

IMAGE_SOURCE_FOLDER=""
IMAGE_TARGET_FOLDER=""
IMAGE_SIZES=""
PARAMS=""
COUNT=$#
if [ ${COUNT} == 0 ]; then
  help
fi
while (("$#")); do
  case "$1" in
  -h | --help | help)
    help 0
    ;;
  -i)
    IMAGE_SOURCE_FOLDER=${2}
    shift 2
    ;;
  -o)
    IMAGE_TARGET_FOLDER=${2}
    shift 2
    ;;
  -s)
    IMAGE_SIZES=${2}
    shift 2
    ;;
  --) # end argument parsing
    shift
    break
    ;;
  --* | -*=) # unsupported flags
    echo "Error: Unsupported flag $1" >&2
    help
    ;;
  *) # preserve positional arguments
    PARAMS="$PARAMS $1"
    shift
    ;;
  esac
done
# set positional arguments in their proper place
eval set -- "$PARAMS"

if [ -z "${IMAGE_SOURCE_FOLDER}" ] || [ -z "${IMAGE_TARGET_FOLDER}" ] || [ -z "${IMAGE_SIZES}" ]; then
	help
fi

for size in ${IMAGE_SIZES}; do
	echo "resize to ${size}:"
	resize "${IMAGE_SOURCE_FOLDER}" "${IMAGE_TARGET_FOLDER}" "${size}"
	echo ""
done
