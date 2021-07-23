#!/usr/bin/env bash

set -e

if [ ! -z "${DEBUG}" ]; then
  set -x
fi

_latest_version() {
  curl -sSLf "https://api.github.com/repos/k0sproject/k0s/releases/latest" | grep -oE "tag_name\": *\".{1,15}\"," | sed 's/tag_name\": *\"//;s/\",//'
}

_detect_arch() {
  case $(uname -m) in
    amd64|x86_64) echo "amd64" ;;
    arm64|aarch64) echo "arm64" ;;
    armv7l|armv8l|arm) echo "arm" ;;
    *) echo "Unsupported processor architecture"; return 1 ;;
  esac
}

_arch() {
  if [ ! -z "${K0S_ARCH}" ]; then
    echo "$K0S_ARCH"
  else
    echo "$(_detect_arch)"
  fi

}

_version() {
  if [ ! -z "${K0S_VERSION}" ]; then
    echo "$K0S_VERSION"
  else
    echo "$(_latest_version)"
  fi
}

_download_url() {
  local version="$(_version)"
  local arch="$(_arch)"

  echo "https://github.com/k0sproject/k0s/releases/download/$version/k0s-$version-$arch"
}

_download_oci_bundle_url() {
  local version="$(_version)"
  local arch="$(_arch)"

  echo "https://github.com/k0sproject/k0s/releases/download/$version/k0s-airgap-bundle-$version-$arch"
}


echo "Downloading k0s airgap bundle from URL: $(_download_oci_bundle_url)"
curl -sSLf $(_download_oci_bundle_url) > kubanetes/var/lib/k0s/images/bundle_file
echo "Downloading k0s from URL: $(_download_url)"
curl -sSLf $(_download_url) > kubanetes/usr/local/bin/k0s
chmod 755 kubanetes/usr/local/bin/k0s

K0S_VERSION=$(_version) K0S_ARCH=$(_arch) envsubst < control.template.txt > kubanetes/DEBIAN/control
