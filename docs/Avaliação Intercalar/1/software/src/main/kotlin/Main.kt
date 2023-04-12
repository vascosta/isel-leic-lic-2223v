fun main() {
    LCD.init()
    KBD.init()
    var count = 0
    while (true) {
        val key = KBD.getKey()

        if (key != 0.toChar()) {
            LCD.write(key.toString())
            count++
            if (count == 16) {
                LCD.clear()
                count = 0
            }
            println(key)
        }
    }
}