#!/bin/bash
check_page_poison() {
    grep -qE '\b(page_poison=1)\b' /proc/cmdline
}

if check_page_poison; then
    echo "Les contremesures cache poisonning sont appliquées" >&2
    exit 0
else
    echo "les contremesures cache poisoning ne sont pas appliquées" >&2
    exit 1
fi