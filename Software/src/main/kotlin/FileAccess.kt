import java.io.File

object FileAccess {
    fun read(fileName: String): List<String> = File(fileName).bufferedReader().readLines()

    fun write(fileName: String, fileContent: String) = File(fileName).bufferedWriter().use { out ->
        out.write(fileContent)
    }
}

fun main() {
    val fileName = "USERS.txt"
    val fileRead = FileAccess.read(fileName)
    fileRead.forEach { println(it) }
    val fileContent = "3;0;Vasco Costa"
    FileAccess.write(fileName, fileContent)
}

/*
    0;1249;Alan Turing;Turing machine is ready;
    1;2072;George Boole;
    2;0;Maurice Karnaugh;Simplification is possible;
    3;0;John von Neumann;
    6;0;Kathleen Booth;
*/