#!/usr/bin/env bash
#
# Installs asdf packages
#
echo
echo "Installing ASDF plugins"

ASDF_HOME=$(brew --prefix asdf)
asdf=$ASDF_HOME/bin/asdf

$asdf plugin-add java
$asdf plugin-add python
$asdf plugin-add ruby
$asdf plugin-add gradle
$asdf plugin-add sbt
$asdf plugin-add groovy

exit 0
