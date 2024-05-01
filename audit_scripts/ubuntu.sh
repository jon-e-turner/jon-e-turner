#!/bin/bash

AUDIT_CMD="audit"
FIX_CMD="fix"
START_DATE=$(date -u -Iseconds)
OUTPUT_DIR=$HOME
FINDINGS_FILE="$OUTPUT_DIR/audit-findings-$START_DATE.log"
LOG_FILE="$OUTPUT_DIR/audit-logs-$START_DATE.log"
QUIET=false
# ALLOW_SYSTEM_CHANGES=false

function toLog() {
    if [ $QUIET ]; then
        echo "$(date -u -Iseconds): $*" >> "$LOG_FILE"
    else
        echo "$(date -u -Iseconds): $*" | tee -a "$LOG_FILE"
    fi
}

function toFindings() {
    echo "$(date -u -Iseconds): $*" >> "$FINDINGS_FILE"
}

if [ $# -eq 0 ]; then
    echo "USAGE: $0 (audit|fix)"
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
    toLog "Error: this script must be run with super-user privileges."
    exit 1
fi

# Check if firewall is configured

if [ "$(which ufw)" ]; then
    if [ "$(ufw status verbose)" == "Status: inactive" ]; then
        toLog "ERROR: 'ufw' is disabled!"
    else
        toLog "INFO: 'ufw' is enabled."
    fi
else
    toLog "WARNING: Utility 'ufw' is not available."
fi        

# Check installed services

if [ "$(which service)" ]; then
    service --status-all
else
    toLog "WARNING: Utility 'service' is not available."
fi

# Check world-writable, executable files

find / -type f \( -perm -o+wx \) -exec ls -ld {} \;

# fix with: find / -type f \( -perm -o+wx \) -exec chmod o-w {} \;

# Check SSH config

# Check users with login shell

# Check sudoers file