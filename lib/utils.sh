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
        to_lower $(uname -s)
    fi
}

# appends $line to $file if not already present, leaving the rest of the
# file (e.g. Ubuntu's distro-provided ~/.bashrc content) untouched
ensure_line () {
    local file=$1
    local line=$2
    touch "$file"
    grep -qxF "$line" "$file" || echo "$line" >> "$file"
}

