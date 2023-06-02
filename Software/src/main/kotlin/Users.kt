object Users {

    data class User(val uin: String, var pin: String, val userName: String, var message: String)
    private const val USERS_FILE = "Users.txt"
    private val users = mutableListOf<User>()
    private val usersToWrite = mutableListOf<String>()

    fun init() {
        val fileLines = FileAccess.read(USERS_FILE)
        fileLines.forEach { line ->
            val u = line.split(";")
            require (users.size <= 1000)
            users.add(User(u[0], encryptAndDecryptPin(u[1]), u[2], u[3]))
        }
    }
    fun isUser(uin: String, pin: String): Boolean = users.any { user -> user.uin == uin && user.pin == pin }
    private fun getUserInfo(uin: String): User = users.first { user -> user.uin == uin }
    fun getUserPin(uin: String): String = getUserInfo(uin).pin
    fun getUserName(uin: String): String = getUserInfo(uin).userName
    fun getUserMessage(uin: String): String = getUserInfo(uin).message
    fun addUser(pin: String, userName: String): String {
        val lastUin = users.last().uin.toInt()
        val uin = if (users.isEmpty()) "000"
        else {
            if (lastUin + 1 >= 100) "${lastUin + 1}"
            else if (lastUin + 1 >= 10) "0${lastUin + 1}"
            else "00${lastUin + 1}"
        }
        users.add(User(uin, pin, userName, ""))
        return uin
    }
    fun removeUser(uin: String) = users.removeIf { user -> user.uin == uin }
    fun changeUserPin(uin: String, newPassword: String) = users.first { user -> user.uin == uin }.apply { pin = newPassword }
    fun changeUserMessage(uin: String, newMessage: String) = users.first { user -> user.uin == uin }.apply { message = newMessage }
    private fun toString(user: User): String = "${user.uin};${encryptAndDecryptPin(user.pin)};${user.userName};${user.message}"
    private fun encryptAndDecryptPin(pin: String): String {
        var pinToReturn = ""
        pin.forEach { c ->
            pinToReturn += (c.code xor 1).toChar()
        }
        return pinToReturn
    }
    fun writeUsers() {
        FileAccess.clear(USERS_FILE)
        users.forEach {
            usersToWrite.add(toString(it))
        }
        FileAccess.write(USERS_FILE, usersToWrite)
    }
}

fun main() {
    println(Users.getUserPin("6"))
    println(Users.getUserName("6"))
    println(Users.getUserMessage("6") == "")
    FileAccess.read("Users.txt").forEach { println(it) }
    val uin = Users.addUser("1234", "Vasco Costa")
    Users.changeUserPin("2", "4321")
    Users.changeUserMessage(uin, "Your car is ready")
    Users.removeUser("6")
}