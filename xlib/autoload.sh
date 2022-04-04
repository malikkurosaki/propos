_autoload() {
    for file in $(find . -name "_*.sh"); do
        source $file
    done
    _menu
}
