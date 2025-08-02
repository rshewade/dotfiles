#!/bin/bash

SESSION_NAME="my_session"
WINDOW_NAME="main"

# Start new tmux session, detached
tmux new-session -d -s "$SESSION_NAME" -n "$WINDOW_NAME"

# Split window: left 75% (pane 0), right 25% (pane 1)
tmux split-window -h -p 25 -t "${SESSION_NAME}:${WINDOW_NAME}"

# Split right pane (pane 1) horizontally into two (pane 1 and pane 2, each 50%)
tmux split-window -v -p 50 -t "${SESSION_NAME}:${WINDOW_NAME}.1"

# Optional: select the first (left) pane
 tmux select-pane -t "${SESSION_NAME}:${WINDOW_NAME}.0"

# Start nvim in the leftmost pane (pane 0)
tmux send-keys -t "${SESSION_NAME}:${WINDOW_NAME}.0" "nvim" C-m

# Start opencode in the top right pane (pane 1)
tmux send-keys -t "${SESSION_NAME}:${WINDOW_NAME}.1" "opencode" C-m

# Attach to the session
tmux attach-session -t "$SESSION_NAME"
