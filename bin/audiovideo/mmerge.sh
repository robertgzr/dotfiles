#!/bin/bash

IN=$1
ADD_SUB=$2
# ATT_DIR=$3

RELASE_NAME="CoalGirls-Hi10"
RELASE_NAME_LANG=eng

SUB_NAME="HorribleSubs"
SUB_NAME_LANG=eng

OUT=${IN//.mkv/.new.mkv}

if [[ -z $IN ]]; then
  echo "usage: mmerge.sh <IN> <ADDITIONAL SUB> <ATTRIBUTE DIR>"
  exit 1
fi

attach_fonts_edit()
{
  for ttf in "$ATT_DIR"/{*.ttf,*.TTF}; do
    mkvpropedit -v "$OUT" --add-attachment "$ttf"
  done

  for otf in "$ATT_DIR"/{*.otf,*.OTF}; do
    mkvpropedit -v "$OUT" --add-attachment "$otf"
  done
}

echo "[mmerge] Mux $IN <- $ADD_SUB"
echo ""

mkvmerge -v --track-order 0:0,1:0 -o "$OUT" \
  --track-name 0:$RELASE_NAME \
  --language 0:$RELASE_NAME_LANG \
  --default-track 0:true \
  "$IN" \
  --track-name 0:$SUB_NAME\
  --language 0:$SUB_NAME_LANG \
  "$ADD_SUB" 
  # --sync 0:-1000 \

# attach_fonts_edit

echo "[mmerge] Finished."
echo "[mmerge] ~===============================================================~"
echo ""
echo ""
