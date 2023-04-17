set -gx DOCKER_CONFIG $XDG_CONFIG_HOME/docker
set -gx MACHINE_STORAGE_PATH $XDG_DATA_HOME/docker-machine

if command -v docker &>/dev/null
    abbr -a dk sudo docker
    abbr -a dkcu docker compose up
    abbr -a dkcd docker compose down
    abbr -a dkcr "docker-compose down && docker-compose up -d --build"
end