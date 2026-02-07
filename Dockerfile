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

GAME=${GAME:-ninja}

case "$GAME" in
  ninja)
    python3 ninja-game/app.py
    ;;
  pacman)
    python3 pacman-game/main.py
    ;;
  tetris)
    python3 tetris-game/main.py
    ;;
  mario)
    python3 mario-game/main.py
    ;;
  mariokart)
    python3 mario-kart-game/MarioKart.pyw
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
