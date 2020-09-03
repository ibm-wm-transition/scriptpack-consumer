#!/bin/sh

APP_HOME=`pwd`

SHOW_HELP=0

ORIG_ARGS="$@"

processOptions()
{
    if [ $# -eq 0 ]
    then
        SHOW_HELP=1
    fi
    while :
    do
        if [ "$1" = "-d" ]
        then
            APP_HOME="$2"
        elif [ "$1" = "-h" ] || [ "$1" = "--h" ] || [ "$1" = "--help" ]
        then
            SHOW_HELP=1
        elif [ -z "$1" ]
        then
            break
        fi
        shift
    done
}

# PAYLOAD-EXTRACT-CODE

executeBootstrap()
{
	JAVA="${APP_HOME}/jvm/bin/java"
    unset CLASSPATH
    for jar_file in `ls ${APP_HOME}/libs/*.jar 2> /dev/null`
    do
        if [ -z "$CLASSPATH" ]
        then
            CLASSPATH=$jar_file
        else
            CLASSPATH="${CLASSPATH}:${jar_file}"
        fi
    done
    $JAVA -cp $CLASSPATH com.softwareag.scriptpack.consumer.Main $ORIG_ARGS
    exit $?
}

showHelp()
{
    if [ $SHOW_HELP -eq 1 ]
    then
        echo "Usage: $0 [Options...]"
        echo ""
        echo "Options:"
        echo "       -h,--help                 This usage help."
        echo "       -d ~/myapp                Target installation directory."
        echo ""
        exit 0
    fi
}

main()
{
    processOptions "$@"
    showHelp
    extractPayload
    executeBootstrap
}

main "$@"

PAYLOAD:
