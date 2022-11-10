#!/usr/bin/env bash

INSTALL_LOCATION=$(eval "echo $ORB_EVAL_INSTALL_LOCATION")

if [ ! -d "$INSTALL_LOCATION/flutter" ]; then
  mkdir -p "$INSTALL_LOCATION"
  if [ "$(uname)" == 'Darwin' ]; then
    curl -o flutter_sdk.zip https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_$ORB_VAL_FLUTTER_SDK_VERSION-stable.zip
    unzip -qq flutter_sdk.zip -d "$INSTALL_LOCATION"
    rm flutter_sdk.zip
  elif uname -a | grep -q "Linux" ; then
    curl -o flutter_sdk.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_$ORB_VAL_FLUTTER_SDK_VERSION-stable.tar.xz
    tar xf flutter_sdk.tar.xz -C "$INSTALL_LOCATION"
    rm -f flutter_sdk.tar.xz
  else
    echo "This platform ($(uname -a)) is not supported."
    exit 1
  fi
fi

echo "$PATH"
echo "export PATH=$INSTALL_LOCATION/flutter/bin:$PATH">> "$BASH_ENV"

# shellcheck source=/dev/null
source "$BASH_ENV"
