#!/usr/bin/env bash

INSTALL_LOCATION=$(eval "echo $ORB_EVAL_INSTALL_LOCATION")

function install_flutter() {
  local machine=${1:-"Linux"}
  local arch=${2:-"amd64"}
  [[ $machine == "Darwin" ]] && uname=macos || uname=linux
  [[ $arch == "arm64" ]] && version="flutter_${uname}_arm64" || version="flutter_${uname}"
  [[ $uname == "linux" ]] && suffix="tar.xz" || suffix="zip"

  baseurl="https://storage.googleapis.com/flutter_infra_release/releases/stable"

  fullurl="$baseurl/$uname/${version}_$ORB_VAL_FLUTTER_SDK_VERSION-stable.${suffix}"

  curl -o "flutter_sdk.${suffix}" "$fullurl"
}

install_flutter "$(uname)" "$(uname -a)"

echo "export PATH=$INSTALL_LOCATION/flutter/bin:\$PATH" >> "$BASH_ENV"

# shellcheck source=/dev/null
source "$BASH_ENV"
which flutter

