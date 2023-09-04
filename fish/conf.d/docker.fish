if command -v docker &>/dev/null
    set -gx DOCKER_CONFIG $XDG_CONFIG_HOME/docker
    set -gx MACHINE_STORAGE_PATH $XDG_DATA_HOME/docker-machine

    abbr -a dk docker
    abbr -a dkcu docker compose up
    abbr -a dkcd docker compose down
    abbr -a dkcr "docker-compose down && docker-compose up -d --build"

    if ! grep -q docker /etc/group
        sudo groupadd docker
    end
end
