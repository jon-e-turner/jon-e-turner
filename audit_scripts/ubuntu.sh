#!/bin/bash

AUDIT_CMD="audit"
FIX_CMD="fix"
START_DATE=$(date -u -Iseconds)
OUTPUT_DIR=$HOME
FINDINGS_FILE="$OUTPUT_DIR/audit-findings-$START_DATE.json"
LOG_FILE="$OUTPUT_DIR/audit-logs-$START_DATE.log"

function toLog() {
    echo "$(date -u -Iseconds): $*" >>"$LOG_FILE"
}

if [ $# -eq 0 ]; then
    # echo usage instructions
    exit 1
fi

command="$1"

case "${command}" in
"$AUDIT_CMD" | "$FIX_CMD")
    shift
    ;;
*)
    toLog "Error: invalid command '${command}'"
    exit 1
    ;;
esac

if [ "$(id -u)" -ne 0 ]; then
    echoerr "Error: this script must be run with super-user privileges."
    exit 1
fi

# Check installed services

if service; then
    service --status-all
else
    toLog "WARNING: binary 'service' is not available"
fi
