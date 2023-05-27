import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

object Others {
    fun exceptionHandler(function: () -> Unit) {
        while (true) {
            try {
                function()
                break
            }
            catch (e: Exception) {
                println(e.message)
            }
        }
    }

}