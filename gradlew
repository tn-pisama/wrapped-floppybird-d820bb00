#!/usr/bin/env sh

# Add default JVM options here. You can also use JAVA_OPTS and GRADLE_OPTS to pass JVM options to this script.
DEFAULT_JVM_OPTS=""

APP_NAME="Gradle"
APP_BASE_NAME=`basename "$0"`

# Use the maximum available, or set MAX_FD != -1 to use that value.
MAX_FD="maximum"

warn () {
    echo "$*"
}

die () {
    echo
    echo "ERROR: $*"
    echo
    exit 1
}

# OS specific support (must be 'true' or 'false').
cygwin=false
msys=false
darwin=false
nonstop=false
case "`uname`" in
  CYGWIN* )
    cygwin=true
    ;;
  Darwin* )
    darwin=true
    ;;
  MINGW* )
    msys=true
    ;;
  NONSTOP* )
    nonstop=true
    ;;
esac

CLASSPATH_SEPARATOR=:
if $cygwin || $msys; then
  CLASSPATH_SEPARATOR=";"
fi

# Attempt to set APP_HOME
# Resolve links: $0 may be a link
PRG="$0"
# Need this for relative symlinks.
while [ -h "$PRG" ] ; do
    ls=`ls -ld "$PRG"`
    link=`expr "$ls" : '.*-> \(.*\)$'`
    if expr "$link" : '/.*' > /dev/null; then
        PRG="$link"
    else
        PRG=`dirname "$PRG"`"/$link"
    fi
done
SAVED="`pwd`"
cd "`dirname \"$PRG\"`/">/dev/null
APP_HOME="`pwd -P`"
cd "$SAVED" >/dev/null

# Determine the Java command to use to start the JVM.
if [ -n "$JAVA_HOME" ] ; then
    if [ -x "$JAVA_HOME/jre/sh/java" ] ; then
        # IBM's JDK on AIX uses strange locations for the executables
        JAVACMD="$JAVA_HOME/jre/sh/java"
    else
        JAVACMD="$JAVA_HOME/bin/java"
    fi
    if [ ! -x "$JAVACMD" ] ; then
        die "ERROR: JAVA_HOME is set to an invalid directory: $JAVA_HOME\n\nPlease set the JAVA_HOME variable in your environment to match the\nlocation of your Java installation."
    fi
else
    JAVACMD="java"
    which java >/dev/null 2>&1 || die "ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.\n\nPlease set the JAVA_HOME variable in your environment to match the\nlocation of your Java installation."
fi

# Increase the maximum number of open files if necessary.
if ! $cygwin && ! $msys && ! $nonstop ; then
    MAX_FD_LIMIT=`ulimit -H -n`
    if [ $? -eq 0 ] ; then
        if [ "$MAX_FD" = "maximum" -o "$MAX_FD" = "max" ] ; then
            MAX_FD="$MAX_FD_LIMIT"
        fi
        ulimit -n $MAX_FD
        if [ $? -ne 0 ] ; then
            warn "Could not set maximum file descriptor limit: $MAX_FD"
        fi
    else
        warn "Could not query maximum file descriptor limit: $MAX_FD_LIMIT"
    fi
fi

# Add extension processing logic.
# For Cygwin or MSYS, switch paths to Windows format before running java
if $cygwin || $msys; then
    APP_HOME=`cygpath --path --mixed "$APP_HOME"`
    CLASSPATH=`cygpath --path --mixed "$CLASSPATH"`

    JAVACMD=`cygpath --unix "$JAVACMD"`

    # We build the pattern for arguments to be converted to Windows paths
    ROOTDIRSRAW=`find -L / -maxdepth 1 -mindepth 1 -type d 2>/dev/null`
    SEP=""
    for dir in $ROOTDIRSRAW ; do
        ROOTDIRS="$ROOTDIRS$SEP$dir"
        SEP="|"
    done
    OURCYGPATTERN="(^($ROOTDIRS))"
    # Add a user-defined pattern to the existing one
    if [ "$GRADLE_CYGPATTERN" != "" ] ; then
        OURCYGPATTERN="$OURCYGPATTERN|($GRADLE_CYGPATTERN)"
    fi
    # Add options with file input to this pattern list
    WIN_PATH_OPTS="$WIN_PATH_OPTS --build-file --gradle-user-home --init-script --project-cache-dir --project-dir --settings-file"
    # Add options with file input to this pattern list
    # (Used for compile options)
    # TODO: This list is not exhaustive and needs to be updated periodically
    WIN_PATH_OPTS_PATTERNS="(-I|--include|-cp|-classpath|--source-path|--module-path|--upgrade-module-path|--patch-module|--processor-path|--processor-module-path|--system|@)"
fi

# Escape application args
CMD_LINE_ARGS=()
for ((i=1; i <= $#; i++)); do
    arg="${!i}"
    # Handle an empty argument
    if [ -z "$arg" ] ; then
        CMD_LINE_ARGS+=("")
        continue
    fi
    # If we're on Cygwin/MSYS, convert arguments starting with our path pattern to Windows paths
    if ($cygwin || $msys) && [[ "$arg" == -* ]] ; then
        if [[ $arg == $WIN_PATH_OPTS_PATTERNS* ]] ; then
            i=$((i+1))
            val="${!i}"
            if [[ $val == $OURCYGPATTERN* ]] ; then
                val=$(cygpath --path --mixed "$val")
            fi
            CMD_LINE_ARGS+=("$arg" "$val")
        elif [[ $WIN_PATH_OPTS == *" $arg "* ]] ; then
            i=$((i+1))
            val="${!i}"
            if [[ $val == $OURCYGPATTERN* ]] ; then
                val=$(cygpath --path --mixed "$val")
            fi
            CMD_LINE_ARGS+=("$arg" "$val")
        else
            CMD_LINE_ARGS+=("$arg")
        fi
    else
        CMD_LINE_ARGS+=("$arg")
    fi
done

# Collect all arguments for the java command, following the shell quoting and substitution rules
eval set -- "$DEFAULT_JVM_OPTS $JAVA_OPTS $GRADLE_OPTS \"-Dorg.gradle.appname=$APP_BASE_NAME\" -classpath \"$APP_HOME/gradle/wrapper/gradle-wrapper.jar\" org.gradle.wrapper.GradleWrapperMain \"${CMD_LINE_ARGS[@]}\""

# Start the wrapper
# Ensure that the wrapper jar exists
if [ ! -f "$APP_HOME/gradle/wrapper/gradle-wrapper.jar" ]; then
    die "The Gradle wrapper JAR is missing. Please ensure that the file '$APP_HOME/gradle/wrapper/gradle-wrapper.jar' exists."
fi

"$JAVACMD" "$@"
