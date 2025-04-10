#!/bin/bash
SERVER_JAR="paper.jar"
VERSION="1.21.4"  # <- замените на свою версию

# Скачиваем свежий билд Paper
wget -O "$SERVER_JAR" "https://api.papermc.io/v2/projects/paper/versions/$VERSION/builds/latest/downloads/paper-$VERSION-222.jar"

# Проверяем, что файл скачался
if [ -f "$SERVER_JAR" ]; then
    echo "✅ Paper успешно обновлен до версии $VERSION!"
else
    echo "❌ Ошибка загрузки Paper!"
    exit 1
fi
