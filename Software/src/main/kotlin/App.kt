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
                getAccess()
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
            val uinText = "???".toCharArray()
            TUI.writeText("UIN:${String(uinText)}", 1)
            val uin = getUin(uinText) ?: return
            if (uin == "???") getAccess()
            TUI.writeDate()
            val pinText = "????".toCharArray()
            TUI.writeText("PIN:${String(pinText)}", 1)
            val pin = getPin(pinText)
            if (pin == null) {
                TUI.writeFailedMessage("Login failed")
                return
            }
            if (pin == "????") getAccess()
            TUI.writeDate()
            if(!Users.isUser(uin, pin)) return
            access(uin)
        }
    }
    private fun getUin(uin: CharArray): String? {
        for (colIdx in 4..6) {
            uin[colIdx - 4] = TUI.waitForKey(5000)
            if (uin[colIdx - 4] == '*' || uin[colIdx - 4] == '#') return "???"
            TUI.writeText("${uin[colIdx - 4]}", 1, column = colIdx)
            if (uin[colIdx - 4] == 0.toChar()) return null
        }
        return String(uin)
    }
    private fun getPin(pin: CharArray): String? {
        for (colIdx in 4..7) {
            pin[colIdx - 4] = TUI.waitForKey(5000)
            if (colIdx == 4 && pin[0] == '#') return null
            if (pin[colIdx - 4] == '*') return "????"
            if (pin[colIdx - 4] == '#') pin[colIdx - 4] = '?'
            TUI.writeText("${pin[colIdx - 4]}", 1, column = colIdx)
            if (pin[colIdx - 4] == 0.toChar()) return null
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
            if (message != "") {
                if (message.length >= 17) {
                    TUI.writeText(message.substring(0, 16), 0)
                    TUI.writeCentralized(message.substring(17), 1, true)
                }
                else TUI.writeCentralized(message, 0, true)
                if (TUI.waitForKey(2000) == '*') Users.changeUserMessage(uin, "")

            }
        }
        if (TUI.waitForKey(2000) == '#') changePIN(uin)
        TUI.writeText(userName, 0, 0)

    }
    private fun doorManagement() {

    }

    private fun changePIN(uin: String) {
        val pinText = "????".toCharArray()
        val firstPin = getPin(pinText)
        if (firstPin == null) {
            TUI.writeFailedMessage("PINs do not match.")
            return
        }
        val secondPin = getPin(pinText)
        if (secondPin == null) {
            TUI.writeFailedMessage("PINs do not match.")
            return
        }
        Users.changeUserPin(uin, firstPin)
        TUI.writeText("New pin is $firstPin", 1)
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