exit_error () {
    echo $1 && exit $2
}

base_dir () {
    echo "$(dirname $(readlink -f $0))"
}

include () {
    source "$(base_dir)/$1"
}


to_lower () {
    echo $@ | tr '[:upper:]' '[:lower:]'
}

to_upper () {
    echo $@ | tr '[:lower:]' '[:upper:]'
}

os_name () {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        to_lower $NAME
    else
        uname -s
    fi
}

