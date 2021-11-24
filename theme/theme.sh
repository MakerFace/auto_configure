#!/bin/bash

CDIR=`pwd`
THEME="$HOME/.local/share/themes"
CURSOR="$HOME/.local/share/icons"
ICON="$HOME/.local/share/icons"

RESOURCES_ARCHIVE=`awk '/^__ARCHIVE_BOUNDARY__/ {print NR+1; exit 0;}' $0`

RESOURCES_COMPRESS="$CDIR/resources.tar.gz"
WhiteSurLight="$CDIR/WhiteSur-light.tar.gz"
WhiteSurDark="$CDIR/WhiteSur-dark.tar.gz"
CursorDark="$CDIR/capitaine-cursors-r4.tar.gz"
CursorLight="$CDIR/capitaine-cursors-light-r4.tar.gz"
Icons="$CDIR/01-McMojave-circle.tar.gz"

function decompress() {
    DES=${@: -1}
    FILES=${@: 1:$#-1}
    if [ ! -d "$DES" ];then
        `mkdir -p $DES`
    fi
    for file in $FILES; do
        echo "decompress $file to $DES"
        `tar xf $file -C $DES`
    done
}
tail -n +$RESOURCES_ARCHIVE $0 > $RESOURCES_COMPRESS
decompress $RESOURCES_COMPRESS "./"
decompress $WhiteSurLight $WhiteSurDark $THEME
decompress $CursorLight $CursorDark $CURSOR
decompress $Icons $ICON

clean_files=($RESOURCES_COMPRESS $WhiteSurLight $WhiteSurDark $CursorLight $CursorDark $Icons)
for file in ${clean_files[@]}
do
    `rm $file`
done
exit 0
__ARCHIVE_BOUNDARY__
