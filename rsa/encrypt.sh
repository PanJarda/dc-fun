#!/bin/sh
read line
printf "$line" | od -An -t xC | tr -d " " | tr 'a-f' 'A-F' | dc -e "16i ? Ai 65537 9516311845790656153499716760847001433441357 |16op"
