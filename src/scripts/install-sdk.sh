#!/usr/bin/env bash

INSTALL_LOCATION=$(eval "echo $ORB_EVAL_INSTALL_LOCATION")

function install_flutter() {
  local machine=${1:-"Linux"}
  local arch=${2:-"amd64"}

  [[ $machine == "Darwin" ]] && uname=macos || uname=linux
  [[ $arch =~ "arm64" ]] && version="flutter_${uname}_arm64" || version="flutter_${uname}"
  [[ $uname == "linux" ]] && suffix="tar.xz" || suffix="zip"

  baseurl="https://storage.googleapis.com/flutter_infra_release/releases/$ORB_VAL_FLUTTER_RELEASE_CHANNEL"
  fullurl="$baseurl/$uname/${version}_$ORB_VAL_FLUTTER_SDK_VERSION-$ORB_VAL_FLUTTER_RELEASE_CHANNEL.${suffix}"

  curl -o "flutter_sdk.${suffix}" "$fullurl"

  mkdir -p $INSTALL_LOCATION
  
  if [ $suffix == "tar.xz" ]; then
    tar xf flutter_sdk.tar.xz -C "$INSTALL_LOCATION"
  else
    unzip -oqq flutter_sdk.zip -d "$INSTALL_LOCATION"
  fi

  rm -f "flutter_sdk.${suffix}"
}


if ! command -v flutter &> /dev/null; then
  install_flutter "$(uname)" "$(uname -m)"
else
  echo "Previous Flutter installation detected: $(eval command -v flutter)"
  exit 0
fi

echo "export PATH=$INSTALL_LOCATION/flutter/bin:\$PATH" >> "$BASH_ENV"

# shellcheck source=/dev/null
source "$BASH_ENV"
which flutter
