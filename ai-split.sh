#!/bin/bash
# ==============================================================================
# ai-split - Multiple AI Agents in Split View
# Version: v1.0.0
# Description: Batch-launches multiple AI CLI tools and arranges them side-by-side.
# ==============================================================================

# 1. Single-Instance Lock
LOCK_FILE="/tmp/ai_split_launch.lock"
if [ -f "$LOCK_FILE" ]; then
    LOCK_TIME=$(stat -f %m "$LOCK_FILE")
    NOW=$(date +%s)
    if (( NOW - LOCK_TIME < 10 )); then
        echo "⚠️ Another launch in progress. Skipping."
        exit 0
    fi
fi
touch "$LOCK_FILE"
trap 'rm -f "$LOCK_FILE"' EXIT

# 2. Configuration & Discovery (Reused from ai-tabs)
PASTE_DELAY=0.4
CMD_CREATION_DELAY=0.5
INIT_DELAY=4.5
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PARENT_DIR="$(dirname "$SCRIPT_DIR")"

# Search for .env
[ -f "${SCRIPT_DIR}/.env" ] && ENV_FILE="${SCRIPT_DIR}/.env"
[ -z "$ENV_FILE" ] && [ -f "${PARENT_DIR}/.env" ] && ENV_FILE="${PARENT_DIR}/.env"

SUPPORTED_TOOLS=(
    "gemini:--resume latest"
    "iflow:--continue"
)

FOUND_TOOLS=()
FOUND_CMDS=()

# Load Manual/Auto tools
if [ -f "$ENV_FILE" ]; then
    set -a; source "$ENV_FILE"; set +a
    for var in $(compgen -v | grep '^TOOL_[0-9]' | sort -V); do
        TPATH="${!var}"
        if [ -x "$TPATH" ]; then
            NAME=$(basename "$TPATH")
            FLAG="--continue"
            for item in "${SUPPORTED_TOOLS[@]}"; do [[ "${item%%:*}" == "$NAME" ]] && FLAG="${item#*:}" && break; done
            FOUND_TOOLS+=("$NAME")
            FOUND_CMDS+=("'$TPATH' $FLAG || '$TPATH' || exec \$SHELL")
        fi
    done
fi

for item in "${SUPPORTED_TOOLS[@]}"; do
    NAME="${item%%:*}"
    FLAG="${item#*:}"
    ALREADY=false
    for f in "${FOUND_TOOLS[@]}"; do [[ "$f" == "$NAME" ]] && ALREADY=true && break; done
    [[ "$ALREADY" == true ]] && continue
    TPATH=$(which "$NAME" 2>/dev/null)
    if [ -z "$TPATH" ]; then
        SPATHS=("/opt/homebrew/bin/$NAME" "/usr/local/bin/$NAME" "$HOME/.local/bin/$NAME" "$HOME/.npm-global/bin/$NAME")
        for p in "${SPATHS[@]}"; do [[ -x "$p" ]] && TPATH="$p" && break; done
    fi
    if [ -n "$TPATH" ]; then
        FOUND_TOOLS+=("$NAME")
        FOUND_CMDS+=("'$TPATH' $FLAG || '$TPATH' || exec \$SHELL")
    fi
done

NUM=${#FOUND_CMDS[@]}
[[ "$NUM" -eq 0 ]] && echo "❌ No supported AI tools found." && exit 1

# Force limit to exactly 2 for "Duo" split view
if [[ "$NUM" -gt 2 ]]; then
    echo "💡 Found $NUM tools, but limiting to the first 2 for the perfect Duo Split."
    FOUND_CMDS=("${FOUND_CMDS[@]:0:2}")
    NUM=2
fi

# 3. AppleScript Orchestration (Split Logic)
AS_SCRIPT="tell application \"System Events\"\n"

for ((i=0; i<NUM; i++)); do
    # 1. Open Terminal in Editor
    AS_SCRIPT+="    keystroke \"p\" using {command down, shift down}\n"
    AS_SCRIPT+="    delay 0.2\n"
    AS_SCRIPT+="    set the clipboard to \"Terminal: Create New Terminal in Editor Area\"\n"
    AS_SCRIPT+="    keystroke \"v\" using {command down}\n"
    AS_SCRIPT+="    delay 0.2\n"
    AS_SCRIPT+="    keystroke return\n"
    AS_SCRIPT+="    delay $CMD_CREATION_DELAY\n"
    
    # 2. Wait for terminal to be ready and inject command
    AS_SCRIPT+="    delay $INIT_DELAY\n"
    CLEAN_CMD=$(echo "${FOUND_CMDS[$i]}" | sed 's/"/\\"/g')
    AS_SCRIPT+="    set the clipboard to \"$CLEAN_CMD\"\n"
    AS_SCRIPT+="    keystroke \"v\" using {command down}\n"
    AS_SCRIPT+="    delay $PASTE_DELAY\n"
    AS_SCRIPT+="    keystroke return\n"
    
    # 3. Split if more tools remain
    if [ $((i+1)) -lt "$NUM" ]; then
        AS_SCRIPT+="    delay 0.5\n"
        AS_SCRIPT+="    keystroke \"p\" using {command down, shift down}\n"
        AS_SCRIPT+="    delay 0.2\n"
        AS_SCRIPT+="    set the clipboard to \"View: Split Editor Right\"\n"
        AS_SCRIPT+="    keystroke \"v\" using {command down}\n"
        AS_SCRIPT+="    delay 0.2\n"
        AS_SCRIPT+="    keystroke return\n"
        AS_SCRIPT+="    delay 0.5\n"
    fi
done

AS_SCRIPT+="end tell"

# Execute
echo -e "$AS_SCRIPT" | osascript
echo "🛰  Ai split initialized ($NUM tools in split view)."
