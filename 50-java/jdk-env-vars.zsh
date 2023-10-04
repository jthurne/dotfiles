#/bin/zsh
# Export JDK environment variable used for build
script_dir=${0:a:h}
source "${script_dir}/jdks"

# Need to source asdf otherwise weird errors are thrown when this script is called when starting a new shell
asdf_home=$(brew --prefix asdf)
source "${asdf_home}/libexec/asdf.sh"

find_jdk() {
  version=$1
  # tr -d removes the "*" that asdf prefixes the current java version
  # xargs is used to trim leading and trailing whitespace
  latest=$(asdf list java ${version} | tail -n 1 | tr -d '*' | xargs)
  asdf where java ${latest}
}

export JDK8="$(find_jdk ${JDK8_PKG})"
export JDK11="$(find_jdk ${JDK11_PKG})"
export JDK15="$(find_jdk ${JDK15_PKG})"
export JDK16="$(find_jdk ${JDK16_PKG})"
export JDK17="$(find_jdk ${JDK17_PKG})"
export JDK18="$(find_jdk ${JDK18_PKG})"
export JDK19="$(find_jdk ${JDK19_PKG})"
export JDK20="$(find_jdk ${JDK20_PKG})"
export JDK21="$(find_jdk ${JDK21_PKG})"

