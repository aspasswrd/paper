# Paper Minecraft Server

Этот репозиторий содержит полную конфигурацию моего оптимизированного Minecraft сервера на базе PaperMC с поддержкой кросс-платформенной игры (Java + Bedrock).

## 📌 Технические характеристики

- **Ядро сервера**: [PaperMC](https://papermc.io/) (автообновляемая версия)
- **Поддерживаемые версии**: 1.8.x - 1.20.x (через ViaVersion)
- **Выделенная память**: 2ГБ-6ГБ (настраивается)
- **Оптимизации**: Флаги Aikar's, многопоточная загрузка чанков
- **Кросс-платформа**: Поддержка Bedrock Edition через Geyser

## 🚀 Быстрый старт

### Требования
- Java 17+ (рекомендуется Temurin)
- 4+ ГБ оперативной памяти
- Linux/Windows (рекомендуется Linux)

### Установка и запуск
1. Клонируйте репозиторий:
   ```bash
   git clone https://github.com/aspasswrd/paper.git
   cd paper
   ```

2. Дайте права на выполнение скрипта:
   ```bash
   chmod +x start.sh
   ```

3. Запустите сервер:
   ```bash
   ./start.sh
   ```

4. При первом запуске:
   - Примите EULA (измените `eula.txt`)
   - Настройте необходимые плагины
   - Перезапустите сервер

## 🔧 Оптимизированный запуск

Скрипт `start.sh` включает:
```bash
#!/bin/bash
JAR_FILE="paper.jar"
MIN_RAM="2G"
MAX_RAM="6G"
THREADS=$(nproc)

# Флаги оптимизации Aikar's
FLAGS_OPTIMIZE="-XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs"

java -Xms${MIN_RAM} -Xmx${MAX_RAM} ${FLAGS_OPTIMIZE} \
    -XX:ActiveProcessorCount=${THREADS} \
    -Dpaper.maxChunkThreads=${THREADS} \
    -Dpaper.maxTickThreads=${THREADS} \
    -Dpaper.disableChannelLimit=true \
    -Dpaper.globalMaxConcurrentChunkLoads=1000 \
    -jar ${JAR_FILE} --nogui
```

## 🔌 Полный список плагинов

### Основные компоненты
| Плагин | Назначение |
|--------|------------|
| **AuthMe** | Система авторизации |
| **CMI** | Многофункциональный плагин (экономка, телепорты и др.) |
| **DiscordSRV** | Интеграция с Discord |
| **EssentialsX** | Базовые команды и функционал |
| **LuckPerms** | Продвинутая система прав |
| **PlaceholderAPI** | Поддержка плейсхолдеров |

### Кросс-платформенность
| Плагин | Описание |
|--------|----------|
| **Geyser-Spigot** | Поддержка Bedrock Edition |
| **Floodgate** | Авторизация Bedrock игроков |
| **ViaVersion** + **ViaBackwards** | Поддержка старых версий клиентов |

### Оптимизация
| Плагин | Функционал |
|--------|-----------|
| **Spark** | Профайлер производительности |
| **ClearLag** | Управление ентитями |
| **Plan** | Мониторинг сервера |

### Безопасность
| Плагин | Защита от |
|--------|----------|
| **AntiVPN** | VPN/прокси соединений |
| **CoreProtect** | Логирование действий |
| **WorldGuard** | Защита территорий |

### Дополнительные возможности
| Плагин | Возможности |
|--------|------------|
| **HolographicDisplays** | Голограммы |
| **HeadDatabase** | Коллекция голов |
| **PlayerParticles** | Частицы для игроков |

## ⚙ Рекомендуемые настройки

1. **Для Geyser**:
   - Настройте `config.yml` в папке Geyser
   - Укажите правильный внешний IP

2. **Для DiscordSRV**:
   ```yaml
   BotToken: "ВАШ_ТОКЕН"
   ServerId: "ID_ДИСКОРД_СЕРВЕРА"
   ```

3. **Оптимальные параметры Paper**:
   - `paper.yml`: увеличьте `max-chunk-threads`
   - `spigot.yml`: настройте тайминги entity-activation-range

## 🛠 Администрирование

Полезные команды:
```bash
# Просмотр нагрузки (через Spark)
/spark health

# Бэкап мира
tar -czvf backup-$(date +%F).tar.gz world/
