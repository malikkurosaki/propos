_client() {
    _green "
    Client :
    i, init             initialize client | server
    r, run              run client
    ds, deps            show dependencies
    " | sed -e 's/^[ \t]*//g'

    _cyan "masukkan pilihan"
    read -p ": " opsi
    case $opsi in
    r | run)
        _green "
            w, web              menjalankan flutter debug web
            m, mobile           menjalankan flutter debug mobile
            " | sed -e 's/^[ \t]*//g'

        _cyan "masukkan pilihan"
        read -p ": " opsi
        case $opsi in
        w | web)
            cd client
            flutter run -d chrome --web-renderer html
            ;;
        m | mobile)
            read -p "apakah handphone anda terkoneksi dengan pc ? (y/n): " opsi
            case $opsi in
            y)
                flutter run
                ;;
            n)
                exit 0
                ;;
            *)
                _red "menu tidak ditemukan"
                ;;
            esac
            ;;
        q | quite)
            _yellow "bye ..."
            exit 0
            ;;
        *)
            _red "menu tidak ditemukan"
            ;;
        esac

        ;;
    i | init)
        cd client
        flutter pub add get
        flutter pub add get_storage
        flutter pub add responsive_builder
        flutter pub add intl
        flutter pub add flutter_native_splash
        _splash
        echo "$SPLASH" >./flutter_native_splash.yaml
        flutter pub run flutter_native_splash:create
        ;;
    ds | deps)
        cd client
        flutter pub deps
        ;;
    q | quite)
        _yellow "bye ..."
        exit 0
        ;;
    *)
        _red "menu tidak ditemukan"
        ;;
    esac
}
