FROM python:3.11-slim

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    SDL_VIDEODRIVER=dummy \
    SDL_AUDIODRIVER=dummy

WORKDIR /app

# Copy all game folders and root files
COPY . /app

# Install system dependencies for pygame
RUN apt-get update && apt-get install -y --no-install-recommends \
    libsdl2-2.0-0 \
    libsdl2-image-2.0-0 \
    libsdl2-mixer-2.0-0 \
    libsdl2-ttf-2.0-0 \
    libasound2 \
    libpulse0 \
    && pip install --no-cache-dir -r requirements.txt \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create a startup script to handle game selection
RUN cat > /app/start_game.sh <<'SCRIPT'
#!/bin/bash
set -e

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
  *)
    echo "Unknown game: $GAME"
    echo "Available games: ninja, pacman, tetris, mario, mariokart"
    exit 1
    ;;
esac
SCRIPT

RUN chmod +x /app/start_game.sh

# Default command runs the startup script
CMD ["/app/start_game.sh"]
