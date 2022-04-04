_server() {
    _green "
    Server:
    in, init             initialize client | server
    d, database         set database
    r, run              run server  
    i, install          install package
    un, uninstall       uninstall package
    " | sed -e 's/^[ \t]*//g'

    read -p "Pilih opsi: " opsi
    case $opsi in
    in | init)
        cd server
        npm init -y
        npm install prisma @prisma/client express express-async-handler moment cors localstorage
        npx prisma init
        _yellow "server berhasil di initialize"
        ;;
    d | database)
        _db
        ;;
    r | run)
        cd server
        nodemon index.js
        ;;
    i | install)
        read -p "Nama package: " package
        npm install $package
        _yellow "package berhasil di install"
        npm list
        ;;
    un | uninstall)
        cd server
        npm list
        read -p "Pilih package yang akan di uninstall : " package
        npm uninstall $package
        npm list
        ;;
    *)
        _red "menu tidak ditemukan"
        ;;
    esac
}
