#!/bin/bash
CARLA_VERSION="0.9.10.1"

RUN_DIR=$(dirname $(readlink -f $0))

START_SERVER="off"

function usage_exit {
  cat <<_EOS_ 1>&2
  Usage: $PROG_NAME [OPTIONS...]
  OPTIONS:
    -h, --help      Display how to use
    -s, --server    Launch CARLA server simultaneously
_EOS_
  cd ${CURRENT_DIR}
  exit 1
}

while (( $# > 0 )); do
  if [[ $1 == "--help" ]] || [[ $1 == "-h" ]]; then
    usage_exit
  elif [[ $1 == "--server" ]] || [[ $1 == "-s" ]]; then
    START_SERVER="on"
    shift 1
  else
    echo "無効なパラメータ： $1"
    usage_exit
  fi
done

RUNTIME=""
DOCKER_VERSION=$(docker version --format '{{.Client.Version}}' | cut --delimiter=. --fields=1,2)
if [[ $DOCKER_VERSION < "19.03" ]] && ! type nvidia-docker; then
  RUNTIME="--gpus all"
else
  RUNTIME="--runtime=nvidia"
fi

if [[ $START_SERVER == "on" ]]; then
  gnome-terminal -- \
    -it --rm \
    -p 2000-2002:2000-2002 \
    ${RUNTIME} \
    --name="carla-sim" \
    carlasim/carla:${CARLA_VERSION} \
    bash -c "DISPLAY= SDL_VIDEODRIVER=offscreen SDL_HINT_CUDA_DEVICE=0 ./CarlaUE4.sh -opengl"
fi

docker run \
  -it --rm \
  --env="DISPLAY=${DISPLAY}" \
  --privileged \
  --net=host \
  --name="carla-pyapi" \
  ${RUNTIME} \
  carla-pyapi:${CARLA_VERSION}