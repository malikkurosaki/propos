_db() {
    _green "
    Database:
    s, set       set database
    " | sed -e 's/^[ \t]*//g'

    read -p "Pilih opsi: " opsi
    case $opsi in
    s | set)
        _yellow "lengkapi form berikut untuk mengatur database"
        read -p "Nama database: " db
        read -p "Username: " user
        read -p "Password: " pass
        read -p "Host: " host
        read -p "Port: " port
        DB=DATABASE_URL="mysql://$user:$pass@$host:$port/$db"
        echo $DB >./server/.env
        SCHEMA=$(cat ./server/prisma/schema.prisma | sed -e 's/postgresql/mysql/g')
        echo -e "$SCHEMA" >./server/prisma/schema.prisma

        _yellow "database berhasil di set"
        ;;
    *)
        _red "menu tidak ditemukan"
        ;;
    esac
}
