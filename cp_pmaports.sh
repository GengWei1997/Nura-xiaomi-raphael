#!/bin/bash

# 要删除的文件夹列表
folders_to_remove=(
    "/home/gw/.local/var/pmbootstrap/cache_git/pmaports/device/archived/device-xiaomi-raphael"
    "/home/gw/.local/var/pmbootstrap/cache_git/pmaports/device/archived/firmware-xiaomi-raphael"
    "/home/gw/.local/var/pmbootstrap/cache_git/pmaports/device/archived/linux-xiaomi-raphael"
)

# 要复制的源文件夹和目标路径
source_dir="/home/gw/raphael/raphael-Nura"
target_dir="/home/gw/.local/var/pmbootstrap/cache_git/pmaports/device/testing"

folders_to_copy=(
    "device-xiaomi-raphael"
    "firmware-xiaomi-raphael"
    "linux-xiaomi-raphael"
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
echo "开始复制文件..."

# 复制新文件夹
for folder in "${folders_to_copy[@]}"; do
    source_path="$source_dir/$folder"
    target_path="$target_dir/$folder"
    
    if [ -d "$source_path" ]; then
        echo "正在复制: $source_path 到 $target_path"
        cp -r "$source_path" "$target_dir"
        if [ $? -eq 0 ]; then
            echo "✓ 复制成功: $folder"
        else
            echo "✗ 复制失败: $folder"
        fi
    else
        echo "源文件夹不存在，跳过: $source_path"
    fi
done

echo ""
echo "操作完成！"