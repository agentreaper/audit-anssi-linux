function sysctl_check(){
    files=("/etc/sysctl.d/" "/run/sysctl.d/" "/usr/local/lib/sysctl.d/" "/usr/lib/sysctl.d/" "/lib/sysctl.d/")
    for element in ${files[@]}; do
        if grep -qEr "\b($1)\b" $element; then
            echo "$element : "$1" présent"
        else
            echo "$element : "$1" absente"
        fi
    done
}
sysctl_check $1