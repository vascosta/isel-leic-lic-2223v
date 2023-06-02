import java.io.File

object FileAccess {
    fun read(fileName: String): List<String> = File(fileName).bufferedReader().use { it.readLines() }
    fun write(fileName: String, fileContent: List<String>) = File(fileName).bufferedWriter().use { out ->
        out.write(fileContent.joinToString(System.lineSeparator()))
    }
    fun clear(fileName: String) = write(fileName, listOf(""))
}

fun main() {
    val fileName = "Users.txt"
    FileAccess.read(fileName).forEach { println(it) }
    val fileContent = listOf("3;0;Vasco Costa;")
    FileAccess.write(fileName, fileContent)
    FileAccess.clear(fileName)
}

/*
0;1249;Alan Turing;Turing machine is ready;
1;2072;George Boole;
2;0;Maurice Karnaugh;Simplification is possible;
3;0;John von Neumann;
6;0;Kathleen Booth;
*/