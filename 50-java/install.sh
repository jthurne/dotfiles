#!/bin/sh
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")"; cd -P "$(dirname "$(readlink "${BASH_SOURCE[0]}" || echo .)")"; pwd)"
source "${script_dir}/jdks"

ASDF_HOME=$(brew --prefix asdf)
asdf=$ASDF_HOME/bin/asdf

$asdf install java "latest:${JDK8_PKG}"
$asdf install java "latest:${JDK11_PKG}"
$asdf install java "latest:${JDK15_PKG}"
$asdf install java "latest:${JDK16_PKG}"
$asdf install java "latest:${JDK17_PKG}"
$asdf install java "latest:${JDK18_PKG}"
$asdf install java "latest:${JDK19_PKG}"
$asdf install java "latest:${JDK20_PKG}"
