#!/bin/bash

# 要删除的文件夹列表
folders_to_remove=(
    "/home/gw/.local/var/pmbootstrap/cache_git/pmaports/device/archived/device-xiaomi-raphael"
    "/home/gw/.local/var/pmbootstrap/cache_git/pmaports/device/archived/firmware-xiaomi-raphael"
    "/home/gw/.local/var/pmbootstrap/cache_git/pmaports/device/archived/linux-xiaomi-raphael"
)

echo "开始清理目标文件夹..."

# 删除旧文件夹
for folder in "${folders_to_remove[@]}"; do
    if [ -d "$folder" ]; then
        echo "正在删除: $folder"
        rm -rf "$folder"
        if [ $? -eq 0 ]; then
            echo "✓ 删除成功: $folder"
        else
            echo "✗ 删除失败: $folder"
        fi
    else
        echo "文件夹不存在，跳过: $folder"
    fi
done

echo ""
echo "操作完成！"