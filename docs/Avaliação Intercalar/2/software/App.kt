import kotlin.system.exitProcess

object App {
    fun init() {
        M.init()
        DoorMechanism.init()
        TUI.init()
        Users.init()
        Log.init()
    }

    fun run() {
        while (true) {
            DoorMechanism.close(10)
            TUI.writeText(TUI.dateFormatted, 0)
            while (!M.verify()) {
                TUI.writeDate()
                try {
                    getAccess()
                } catch (e: Exception) {
                    when(e.message) {
                        "Login failed" -> {
                            TUI.writeFailedMessage("Login failed")
                            getAccess()
                        }
                        "Command aborted" -> {
                            TUI.writeFailedMessage("Command aborted")
                            getAccess()
                        }
                        else -> getAccess()
                    }
                }
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
    private fun getAccess() {
        while (true) {
            TUI.writeDate()
            val uinText = "???".toCharArray()
            TUI.writeText("UIN:${String(uinText)}", 1)
            val uin = getUin(uinText)
            val pinText = "????".toCharArray()
            TUI.writeText("PIN:${String(pinText)}", 1)
            val pin = getPin(pinText)
            TUI.writeDate()
            require(Users.isUser(uin, pin)) { "Login failed" }
            access(uin)
            return
        }
    }
    private fun getUin(uin: CharArray): String {
        for (colIdx in 4..6) {
            uin[colIdx - 4] = TUI.waitForKey(5000)
            require(uin[colIdx - 4] != 0.toChar()) { "Command aborted" } // No key pressed
            require(uin[0] != '*') { "Command aborted" }
            require(uin[colIdx - 4] != '#') { "Invalid key" }
            TUI.writeText("${uin[colIdx - 4]}", 1, column = colIdx)
        }
        return String(uin)
    }
    private fun getPin(pin: CharArray): String {
        for (colIdx in 4..7) {
            pin[colIdx - 4] = TUI.waitForKey(5000)
            require(pin[colIdx - 4] != 0.toChar()) { "Command aborted" } //No key pressed
            require(pin[0] != '*') { "Command aborted" }
            require(pin[colIdx - 4] != '#') { "Invalid key" }
            TUI.writeText("*", 1, column = colIdx)
        }
        return String(pin)
    }
    private fun access(uin: String) {
        Log.addLog(uin)
        Log.writeLog()
        TUI.clearScreen()
        TUI.writeCentralized("Hello", 0)
        val userName = Users.getUserName(uin)
        TUI.writeCentralized(userName, 1)
        Users.getUserMessage(uin).also { message ->
            TUI.clearScreen()
            if (message != "") {
                if (message.length >= 17) {
                    TUI.writeCentralized(message.substring(0, 16), 0)
                    TUI.writeCentralized(message.substring(17), 1)
                }
                else TUI.writeCentralized(message, 0, true)
                TUI.clearScreen()
                if (TUI.waitForKey(2000) == '*') Users.changeUserMessage(uin, "")
            }
        }
        if (TUI.waitForKey(2000) == '#') changePIN(uin)
        TUI.writeText(userName, 0, 0)
        doorManagement()
    }
    private fun changePIN(uin: String) {
        try {
            val pinText = "????".toCharArray()
            val firstPin = getPin(pinText)
            val secondPin = getPin(pinText)
            require (firstPin == secondPin) { "PINs do not match" }
            Users.changeUserPin(uin, firstPin)
            TUI.writeText("New pin is $firstPin", 1)
        } catch (e: Exception) {
            when(e.message) {
                "Command aborted" -> return
                "Invalid key" -> changePIN(uin)
                "PINs do not match" -> {
                    TUI.writeFailedMessage("PINs do not match")
                    return
                }
            }
        }
    }
    private fun doorManagement() {
        TUI.writeCentralized("Door opening", 1)
        DoorMechanism.open(10)
        while (!DoorMechanism.finished()) {
            // waiting to open
        }
        TUI.clearLine(1)
        TUI.writeCentralized("Door open", 1)
        Thread.sleep(2000)
        TUI.clearLine(1)
        TUI.writeCentralized("Door closing", 1)
        DoorMechanism.close(5)
        while (!DoorMechanism.finished()) {
            // waiting to close
        }
        TUI.clearLine(1)
        TUI.writeCentralized("Door closed", 1)
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
    private fun turnOff() {
        Users.clearUsersFile()
        Users.writeUsers()
    }

}

fun main() {
    App.init()
    App.run()
}