function sysctl_check(){
    files=("/etc/sysctl.d/" "/run/sysctl.d/" "/usr/local/lib/sysctl.d/" "/usr/lib/sysctl.d/" "/lib/sysctl.d/")
    for element in ${files[@]}; do
        if grep -qEr "\b($1)\b" $element; then
            echo "$1 trouvé"
            return 0
        else
            continue
        fi
    done
    return 1
}

function print_green(){
    echo -e "\033[32m$1\033[0m"
}

function print_red(){
    echo -e "\033[31m$1\033[0m"
}
