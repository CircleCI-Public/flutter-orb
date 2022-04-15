#!/bin/bash
if [ ! -d "$ORB_PARAM_INSTALL_LOCATION/flutter" ]; then
  mkdir -p "$ORB_PARAM_INSTALL_LOCATION"
  if [ "$(uname)" == 'Darwin' ]; then
    curl -o flutter_sdk.zip https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_$ORB_PARAM_FLUTTER_SDK_VERSION-stable.zip
    unzip -qq flutter_sdk.zip -d "$ORB_PARAM_INSTALL_LOCATION"
    rm flutter_sdk.zip
  elif  uname -a | grep -q "Linux" ; then
    curl -o flutter_sdk.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_$ORB_PARAM_FLUTTER_SDK_VERSION-stable.tar.xz
    tar xf flutter_sdk.tar.xz -C "$ORB_PARAM_INSTALL_LOCATION"
    rm -f flutter_sdk.tar.xz
  else
    echo "Your platform ($(uname -a)) is not supported."
    exit 1
  fi
fi
# shellcheck disable=SC2016
echo 'export PATH=$ORB_PARAM_INSTALL_LOCATION/flutter/bin:$PATH' >> "$BASH_ENV"