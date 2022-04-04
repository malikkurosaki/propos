_git() {
    _green "
    Git:
    r, remote           menampilkan remote
    b, branch           menampilkan branch
    " | sed -e 's/^[ \t]*//g'

    read -p "Pilih opsi: " opsi
    case $opsi in
    r | remote)
        git remote -v
        ;;
    b | branch)
        git branch -a
        ;;
    *)
        _red "menu tidak ditemukan"
        ;;
    esac
    read -p "Pilih opsi: " opsi
}
