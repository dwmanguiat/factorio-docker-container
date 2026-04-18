# Factorio Docker Server

Runs a Factorio dedicated server in Docker. All secrets and server settings are injected at runtime via environment variables.

## Prerequisites

- Docker and Docker Compose
- A [Factorio](https://factorio.com) account (required for public server listing)
- UDP port `34197` open on your firewall/router
- TCP port `27015` open if you want RCON access

## Setup

**1. Clone the repo**
```bash
git clone https://github.com/dwmanguiat/factorio-docker-container.git
cd factorio-docker-container
```

**2. Create your `.env` file**
```bash
cp .env.example .env
```

**3. Fill in `.env`**

| Variable | Description |
|---|---|
| `SERVER_NAME` | Name shown in the server browser |
| `SERVER_DESCRIPTION` | Server description |
| `GAME_PASSWORD` | Password players need to join (leave blank for none) |
| `RCON_PASSWORD` | Password for RCON remote admin access |
| `FACTORIO_USERNAME` | Your factorio.com username |
| `FACTORIO_TOKEN` | Your factorio.com token (get it from [factorio.com/profile](https://factorio.com/profile)) |

> `FACTORIO_USERNAME` and `FACTORIO_TOKEN` are required for public server listing.

**4. Start the server**
```bash
docker compose up -d
```

**5. Check it's running**
```bash
docker logs factorio
```

Look for `Hosting game at IP ADDR:({0.0.0.0:34197})` and `Matching server game ... has been created`.

## First run

On first run the server loads the latest autosave. If no save exists yet, set `GENERATE_NEW_SAVE=true` in `docker-compose.yml`, start once, then set it back to `false`.

## Saves and data

Game data (saves, mods, config) is stored in a Docker named volume `factorio-data`. It persists across container restarts and recreations.

To back up saves:
```bash
docker cp factorio:/factorio/saves ./saves-backup
```

## RCON

Connect to the server's RCON interface for admin commands:
```bash
docker exec -it factorio rcon-cli --host 127.0.0.1 --port 27015 --password <RCON_PASSWORD>
```

## Deploying on Linux

Open the required port in UFW:
```bash
sudo ufw allow 34197/udp
sudo ufw allow 27015/tcp  # optional, RCON only
```

Then follow the setup steps above.
