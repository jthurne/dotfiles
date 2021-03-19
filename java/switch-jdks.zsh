
# See https://github.com/AdoptOpenJDK/homebrew-openjdk#switch-between-different-jdk-versions
jdk() {
        version=$1
        export JAVA_HOME=$(/usr/libexec/java_home -v"$version");
        java -version
 }
