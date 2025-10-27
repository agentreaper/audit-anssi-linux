#!/bin/bash
check_l1tf() {
    grep -qE '\b(l1tf=off|l1tf=full,force)\b' /proc/cmdline
}

if check_l1tf; then
    echo "Les contremesures l1tf sont appliquées" >&2
    exit 0
else
    echo "les contremesures l1tf ne sont pas appliquées" >&2
    exit 1
fi