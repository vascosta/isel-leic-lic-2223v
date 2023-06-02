import kotlin.system.exitProcess

object App {
    fun init() {
        M.init()
        DoorMechanism.init()
        TUI.init()
        Users.init()
        Log.init()
    }

    private const val DOOR_OPEN_VELOCITY = 10
    private const val DOOR_CLOSE_VELOCITY = 15

    fun run() {
        while (true) {
            DoorMechanism.close(DOOR_CLOSE_VELOCITY)
            while (!M.verify()) {
                TUI.writeDate()
                try {
                    getAccess()
                } catch (e: Exception) {
                    when(e.message) {
                        "Login failed" -> {
                            TUI.writeFailedMessage("Login failed")
                            continue
                        }
                        "Command aborted" -> {
                            TUI.writeFailedMessage("Command aborted")
                            continue
                        }
                        else -> {
                            TUI.clearScreen()
                            continue
                        }
                    }
                }
            }
            TUI.clearScreen()
            TUI.writeCentralized("Out of service", 0)
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
    private fun getAccess() {
        while (true) {
            TUI.writeDate()
            val uin = getUin()
            val pin = getPin()
            TUI.writeDate()
            require(Users.isUser(uin, pin)) { "Login failed" }
            access(uin)
            return
        }
    }
    private fun getUin(): String {
        while (true) {
            displayLogin("UIN:???")
            val uinToReturn = "???".toCharArray()
            for (colIdx in 4..6) {
                uinToReturn[colIdx - 4] = getLogin(uinToReturn, colIdx) { getUin() }
                TUI.writeText("${uinToReturn[colIdx - 4]}", 1, column = colIdx)
            }
            return String(uinToReturn)
        }
    }
    private fun getPin(): String {
        while (true) {
            displayLogin("PIN:????")
            val pinToReturn = "????".toCharArray()
            for (colIdx in 4..7) {
                pinToReturn[colIdx - 4] = getLogin(pinToReturn, colIdx) { getPin() }
                TUI.writeText("*", 1, column = colIdx)
            }
            return String(pinToReturn)
        }
    }
    private fun displayLogin(loginText: String) {
        TUI.writeText(loginText, 1)
    }
    private fun getLogin(loginParam: CharArray, colIdx: Int, loginParamFunction: () -> String): Char {
        var key = '#'
        while (key == '#') { key = TUI.waitForKey(5000) }
        loginParam[colIdx - 4] = key
        require(loginParam[colIdx - 4] != 0.toChar()) { "Command aborted" } //No key pressed
        require(loginParam[0] != '*') { "Command aborted" }
        if(loginParam[colIdx - 4] == '*') loginParamFunction()
        return loginParam[colIdx - 4]
    }
    private fun access(uin: String) {
        Log.addLog(uin)
        Log.writeLog()
        TUI.clearScreen()
        TUI.writeCentralized("Hello", 0)
        val userName = Users.getUserName(uin)
        TUI.writeCentralized(userName, 1)
        displayUserMessage(uin)
        displayOptionMenu(uin)
        TUI.writeCentralized(userName, 0)
        doorManagement()
    }
    private fun displayUserMessage(uin: String) {
        Thread.sleep(3000)
        Users.getUserMessage(uin).also { message ->
            TUI.clearScreen()
            if (message != "") {
                if (message.length >= 17) {
                    TUI.writeCentralized(message.substring(0, 16), 0)
                    TUI.writeCentralized(message.substring(16), 1, true)
                }
                else TUI.writeCentralized(message, 0, true)
            }
        }
    }
    private fun displayOptionMenu(uin: String) {
        TUI.writeText("Delete Msg: *", 0)
        TUI.writeText("Change PIN: #", 1)
        when (TUI.waitForKey(3000)) {
            '#' -> {
                TUI.clearScreen()
                TUI.writeCentralized("Changing Pin", 0)
                changePIN(uin)
                Users.writeUsers()
                TUI.clearLine(0)
            }
            '*' -> {
                TUI.clearScreen()
                TUI.writeCentralized("Message deleted", 0, true)
                Users.changeUserMessage(uin, "")
                Users.writeUsers()
            }
            else -> { TUI.clearScreen() }
        }
    }
    private fun changePIN(uin: String) {
        try {
            val firstPin = getPin()
            val secondPin = getPin()
            require (firstPin == secondPin) { "PINs do not match" }
            Users.changeUserPin(uin, firstPin)
            TUI.clearLine(1)
            TUI.writeCentralized("New pin is $firstPin", 1, true)
        } catch (e: Exception) {
            when(e.message) {
                "Command aborted" -> {
                    TUI.clearScreen()
                    return
                }
                "PINs do not match" -> {
                    TUI.writeFailedMessage("PINs don't match")
                    return
                }
            }
        }
    }
    private fun doorManagement() {
        TUI.writeCentralized("Door opening", 1)
        DoorMechanism.open(DOOR_OPEN_VELOCITY)
        while (!DoorMechanism.finished()) {
            // waiting to open
        }
        TUI.clearLine(1)
        TUI.writeCentralized("Door open", 1)
        Thread.sleep(3000)
        TUI.clearLine(1)
        TUI.writeCentralized("Door closing", 1)
        DoorMechanism.close(DOOR_CLOSE_VELOCITY / 3)
        while (!DoorMechanism.finished()) {
            // waiting to close
        }
        TUI.clearLine(1)
        TUI.writeCentralized("Door closed", 1)
        Thread.sleep(3000)
        TUI.clearScreen()
    }
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
    private fun turnOff() = Users.writeUsers()

}

fun main() {
    App.init()
    App.run()
}