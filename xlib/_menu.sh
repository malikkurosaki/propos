_menu() {
    _green "
    Menu:
    h, help             memunculkan bantuan menu
    c, client           menu pilihan lient
    s, server           menu pilihan server
    g, git              git menu
    q, quite            menutup terminal
    " | sed -e 's/^[ \t]*//g'

    _yellow "q | CTRL+C untuk keluar"

    _cyan "masukkan pilihan"
    read -p ": " opsi
    case $opsi in
    h | help)
        _help
        ;;
    c | client)
        _client
        ;;
    s | server)
        _server
        ;;
    g | git)
        _git
        ;;
    q | quite)
        _yellow "bye ..."
        exit 0
        ;;
    *)
        _red "menu tidak ditemukan"
        exit 0
        ;;
    esac

}
