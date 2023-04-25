object TUI {
    //ler uma key do keyboard e escrever no lcd

    fun init() {
        LCD.init()
        KBD.init()
    }

    fun writeText(text: String) {
        LCD.write(text)
    }

    fun writeKey() {
        LCD.write(KBD.getKey())
    }

    fun clearScreen() {
        LCD.clear()
    }

    fun readKey() = KBD.getKey()

    fun waitForKey(time: Long) = KBD.waitKey(time)

    fun writeCentralized(text: String, line: Int, clearScreen: Boolean = false) {
        if (clearScreen) LCD.clear()
        LCD.cursor(line, 8 - text.length / 2)
        LCD.write(text)
    }

    fun writeTextLeft(text: String) {
        LCD.cursor(1, 0)
        LCD.write(text)
    }
}