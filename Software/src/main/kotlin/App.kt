import kotlin.system.exitProcess

object App {
    init {
        M.init()
        DoorMechanism.init()
        TUI.init()
        Users.init()
        Log.init()
    }

    fun run() {
        while (true) {
            while (!M.verify()) {
                //
            }
            println("Turn M key to off, to terminate the maintenance mode.")
            println("Commands: NEW, DEL, MSG, or OFF")
            while (true) {
                print("Maintenance> ")
                when (readln().toUpperCase()) {
                    "NEW" -> {
                        Others.exceptionHandler { addUser() }
                    }
                    "DEL" -> {
                        Others.exceptionHandler { deleteUser() }
                    }
                    "MSG" -> {
                        Others.exceptionHandler { addMessage() }
                    }
                    "OFF" -> {
                        Others.exceptionHandler { turnOff() }
                        exitProcess(0)
                    }
                    else -> {
                        println("Unknown command.")
                    }
                }
            }
        }
    }

    private fun access() {}
    private fun changePIN() {}
    private fun addUser() {
        print("User name? ")
        val userName = readln()
        require(userName.length <= 16) { "Username must be less or equal than 16 characters." }
        print("PIN? ")
        val pin = readln()
        require(pin.length == 4 && pin.all { char -> char.isDigit() }) { "Pin must have 4 numbers." }
        val user = Users.addUser(pin, userName)
        println("Adding user $user:$userName")
    }
    private fun deleteUser() {
        print("UIN? ")
        val uin = readln()
        val userName = Users.getUserName(uin)
        println("Removing user $uin:$userName")
        print("Y/N? ")
        when (readln().toUpperCase()) {
            "Y" -> {
                Users.removeUser(uin)
                println("User $uin:$userName removed.")
            }
            "N" -> {
                println("Command aborted.")
            }
            else -> {
                println("Unknown command.")
            }
        }

    }
    private fun addMessage() {
        println("MSG")
    }
    private fun turnOff() {
        Users.clearUsersFile()
        Users.writeUsers()
    }

}

fun main() {
    App.run()
}