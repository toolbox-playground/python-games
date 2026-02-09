#!/bin/bash
set -e

# Start virtual X server
Xvfb :0 -screen 0 1280x720x24 &
sleep 2

# Start window manager
fluxbox &
sleep 2

# Start VNC server
x11vnc -display :0 -forever -nopw -shared -noxkb -noscr &
sleep 2

# Start noVNC (browser)
websockify --web=/usr/share/novnc/ 6080 localhost:5900 &
sleep 2

# Run game AFTER display is fully ready
GAME=${GAME:-ninja}

case "$GAME" in
  ninja)
    cd /app/ninja-game
    python app.py
    ;;
  pacman)
    cd /app/pacman-game
    python main.py
    ;;
  tetris)
    cd /app/tetris-game
    python main.py
    ;;
  mario)
    cd /app/mario-game
    python main.py
    ;;
  mariokart)
    cd /app/mario-kart-game
    python MarioKart.pyw
    ;;
esac
