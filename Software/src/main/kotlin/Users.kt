object Users {

    data class User(val uin: String, var pin: String, val userName: String, var message: String)
    private const val USERS_FILE = "Users.txt"
    private val users = mutableListOf<User>()
    private val usersToWrite = mutableListOf<String>()

    init {
        val fileLines = FileAccess.read(USERS_FILE)
        fileLines.forEach { line ->
            val u = line.split(";")
            require (users.size <= 1000)
            users.add(User(u[0], u[1], u[2], u[3]))
        }
    }
    private fun getUserInfo(uin: String): User = users.first { user -> user.uin == uin }
    fun getUserPassword(uin: String): String = getUserInfo(uin).pin
    fun getUserName(uin: String): String = getUserInfo(uin).userName
    fun getUserMessage(uin: String): String = getUserInfo(uin).message
    fun addUser(password: String, userName: String): String {
        require(userName.length <= 16) { "Username must be less than 16 characters" }
        val lastUin = users.last().uin.toInt()
        val uin = if (users.isEmpty()) "000"
        else {
            if (lastUin + 1 >= 100) "${lastUin + 1}"
            else if (lastUin + 1 >= 10) "0${lastUin + 1}"
            else "00${lastUin + 1}"
        }
        users.add(User(uin, password, userName, ""))
        return uin
    }
    fun removeUser(uin: String) = users.removeIf { user -> user.uin == uin }
    fun changePassword(uin: String, newPassword: String) = users.first { user -> user.uin == uin }.apply { pin = newPassword }
    fun addMessageToUser(uin: String, newMessage: String) = users.first { user -> user.uin == uin }.apply { message = newMessage }
    fun writeUsers() {
        users.forEach {
            usersToWrite.add("${it.uin};${it.pin};${it.userName};${it.message}")
        }
        FileAccess.write(USERS_FILE, usersToWrite)
    }
    fun clearUsersFile() = FileAccess.clear(USERS_FILE)
}

fun main() {
    println(Users.getUserPassword("6"))
    println(Users.getUserName("6"))
    println(Users.getUserMessage("6") == "")
    FileAccess.read("Users.txt").forEach { println(it) }
    val uin = Users.addUser("1234", "Vasco Costa")
    Users.changePassword("2", "4321")
    Users.addMessageToUser(uin, "Your car is ready")
    Users.removeUser("6")
    Users.clearUsersFile()
    println(FileAccess.read("Users.txt").isEmpty())
    Users.writeUsers()
    FileAccess.read("Users.txt").forEach { println(it) }
}