import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

object TUI {
    private val DATE_PATTERN = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm")
    private var date = LocalDateTime.now()
    var dateFormatted = date.format(DATE_PATTERN)
    fun init() {
        LCD.init()
        KBD.init()
    }


    fun clearLine(line: Int) =writeText("                ", line)
    fun clearScreen() = LCD.clear()
    fun waitForKey(time: Long) = KBD.waitKey(time)
    fun writeCentralized(text: String, line: Int, clearScreen: Boolean = false) {
        if (clearScreen) LCD.clear()
        LCD.cursor(line, 8 - text.length / 2)
        LCD.write(text)
    }
    fun writeText(text: String, line: Int, column: Int = 0) {
        LCD.cursor(line, column)
        LCD.write(text)
    }
    fun writeDate() {
        val currentDate = LocalDateTime.now()
        val currentDateFormatted = currentDate.format(DATE_PATTERN)

        if (currentDate.minute != date.minute) {
            date = currentDate
            dateFormatted = currentDateFormatted.substring(11,16)
            updateTime(dateFormatted)
        }
    }
    private fun updateTime(text: String) = writeText(text, 0, 11)
    fun writeFailedMessage(message: String) {
        clearLine(1)
        writeCentralized(message, 1)
        clearLine(1)
        Thread.sleep(2000)
    }
}