if [ $# -eq 0 ]; then
    echo "Пожалуйста, укажите имя миграции"
    exit 1
fi

timestamp=$(date +%Y%m%d%H%M%S)

filename="${timestamp}_$1"

touch "${filename}.up.sql"
touch "${filename}.down.sql"

echo "Созданы файлы миграции:"
echo "${filename}.up.sql"
echo "${filename}.down.sql"
