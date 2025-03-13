#!/bin/bash

# 檢查剪貼簿是否包含圖片
if wl-paste --list-types | grep -q "image/"; then
    # 從剪貼簿獲取圖片並傳遞給 swappy
    TMP_IMAGE="/tmp/clipboard_image.png"
    wl-paste --type image/png > "$TMP_IMAGE"
    swappy -f "$TMP_IMAGE"
    rm -f "$TMP_IMAGE"
else
    echo "No image in clipboard"
fi
