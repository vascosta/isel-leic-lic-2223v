import java.text.SimpleDateFormat
import java.util.*

object Log {
    data class Log(val uin: String, val date: String, var time: String)
    private const val LOG_FILE = "LogFile.txt"
    private val log = mutableListOf<Log>()
    private val logsToWrite = mutableListOf<String>()
    private val dateFormat = SimpleDateFormat("dd/M/yyyy")
    private val timeFormat = SimpleDateFormat("hh:mm:ss")

    fun init() {
        val fileLines = FileAccess.read(LOG_FILE)
        fileLines.forEach { line ->
            val l = line.split(";")
            log.add(Log(l[0], l[1], l[2]))
        }
    }
    fun addLog(uin: String) = log.add(Log(uin, dateFormat.format(Date()), timeFormat.format(Date())))
    fun writeLog() {
        FileAccess.clear(LOG_FILE)
        log.forEach { logsToWrite.add("${it.uin};${it.date};${it.time};") }
        FileAccess.write(LOG_FILE, logsToWrite)
    }
}

fun main() {
    Log.addLog("123")
    Thread.sleep(1000)
    Log.addLog("456")
    Thread.sleep(1000)
    Log.addLog("789")
    Thread.sleep(1000)
    Log.writeLog()
    FileAccess.read("LogFile.txt").forEach { println(it) }
}