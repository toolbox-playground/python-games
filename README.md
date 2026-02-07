# python-games

A collection of Pygame projects for learning, modification, and exercise. Each game is a complete, standalone project.

## Games Included

### 1. Ninja Game
- **Original Repo**: https://github.com/tombackert/ninja-game
- **Entry Point**: `python3 ninja-game/app.py`
- **License**: MIT
- **Description**: A ninja platformer game with combat mechanics

### 2. Pac-Man
- **Original Repo**: https://github.com/AnandSrikumar/PyPacman
- **Entry Point**: `python3 pacman-game/main.py`
- **License**: GPL-3.0
- **Description**: Classic Pac-Man game implementation

### 3. Tetris
- **Original Repo**: https://github.com/AnandSrikumar/PyTetris
- **Entry Point**: `python3 tetris-game/main.py`
- **License**: MIT
- **Description**: Classic Tetris game implementation

### 4. Super Mario
- **Original Repo**: https://github.com/mx0c/super-mario-python
- **Entry Point**: `python3 mario-game/main.py`
- **License**: MIT
- **Description**: Super Mario platformer game

### 5. Mario Kart
- **Original Repo**: https://github.com/s4rd0n1k/pygame_mariokart
- **Entry Point**: `python3 mario-kart-game/MarioKart.pyw`
- **License**: Check mario-kart-game/LICENSE for details
- **Description**: Mario Kart-inspired racing game

## Running Games Locally

### Requirements
- **Python 3.10+**
- **uv** (Python & dependency manager)

> Some games use Python 3.10+ features (PEP 604 union types `X | Y`, `match` statement).  
> Using Python 3.10 or newer is required to avoid syntax or runtime errors.


## Setup (Recommended: `uv`)

### 1. Install `uv`
```bash
brew install uv
```
(Windows / Linux: see https://github.com/astral-sh/uv)

### 2. Use Python 3.10+

From the repo root:
```bash
uv python install 3.10
uv python pin 3.10
uv venv
source .venv/bin/activate
```
This ensures the project always uses Python 3.10+ and you are using a virtual environment.

### 3. Install Dependencies
```bash
uv pip install -r requirements.txt
```

> Note: a Docker image is an isolated environment so a local venv is not required when running via Docker.

### Run a Specific Game
```bash
# Most games expect to be executed from their own project folder so assets are found correctly.
# Example: run Mario Kart from its folder
cd mario-kart-game && python3 MarioKart.pyw

# Ninja Game
cd ninja-game && python3 app.py

# Pac-Man
cd pacman-game && python3 main.py

# Tetris
cd tetris-game && python3 main.py

# Super Mario
cd mario-game && python3 main.py

# Mario Kart 
cd mario-kart-game && python3 MarioKart.pyw
```

## Running in Docker

### Build the Docker Image
```bash
docker build -t python-games .
```

### Run a Game in Docker (Linux/Mac with Display Support)

Each game runs in its own container. Select which game to play using the `GAME` environment variable. Default is `ninja` if not specified.

```bash
# Ninja Game
docker run --rm -e GAME=ninja -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix python-games

# Pac-Man
docker run --rm -e GAME=pacman -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix python-games

# Tetris
docker run --rm -e GAME=tetris -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix python-games

# Super Mario
docker run --rm -e GAME=mario -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix python-games

# Mario Kart
docker run --rm -e GAME=mariokart -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix python-games

# Default (Ninja)
docker run --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix python-games
```

### Docker Run Explanation

- `--rm`: automatically remove container when it exits
- `-e GAME=<game_name>`: Selects which game to play
- `-e DISPLAY=$DISPLAY`: Forwards your display to the container
- `-v /tmp/.X11-unix:/tmp/.X11-unix`: Mounts the X11 socket for display forwarding
