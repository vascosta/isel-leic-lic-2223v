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
            TUI.writeCentralized("Out of service", 0, true)
            TUI.writeCentralized("Wait", 1)
            println("Turn M key to off, to terminate the maintenance mode.")
            println("Commands: NEW, DEL, MSG, or OFF")
            while (true) {
                print("Maintenance> ")
                when (readln().toUpperCase()) {
                    "NEW" -> Others.exceptionHandler { addUser() }
                    "DEL" -> Others.exceptionHandler { deleteUser() }
                    "MSG" -> Others.exceptionHandler { addMessage() }
                    "OFF" -> {
                        Others.exceptionHandler { turnOff() }
                        exitProcess(0)
                    }
                    else -> println("Unknown command.")
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
            "N" -> println("Command aborted.")
            else -> println("Unknown command.")
        }

    }
    private fun addMessage() {
        print("UIN? ")
        val uin = readln()
        val msg = Users.getUserMessage(uin)
        val userName = Users.getUserName(uin)
        if (msg != "") {
            println("User has this message: $msg.")
            print("Remove this message Y/N? ")
            when (readln().toUpperCase()) {
                "Y" -> {
                    Users.changeUserMessage(uin, "")
                    addNewMessage(uin, userName)
                }
                "N" -> println("Command aborted.")
                else -> println("Unknown command.")
            }
        }
        else {
            addNewMessage(uin, userName)
        }

    }
    private fun addNewMessage(uin: String, userName: String) {
        print("Message? ")
        val newMsg = readln()
        Users.changeUserMessage(uin, newMsg)
        println("The message \"$newMsg\" has been associated to $uin:$userName.")
    }
    private fun turnOff() {
        Users.clearUsersFile()
        Users.writeUsers()
    }

}

fun main() {
    App.run()
}