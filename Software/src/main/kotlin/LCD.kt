// Escreve no LCD usando a interface a 4 bits.
object LCD {
    // Dimensão do display.
    private const val LINES = 2
    private const val COLS = 16

    // Escreve um nibble de comando/dados no LCD em paralelo
    private fun writeNibbleParallel(rs: Boolean, data: Int) {
        val rsValue = if (rs) 1 else 0
        HAL.writeBits(LCD_DATA_MASK, data or rsValue)
        HAL.writeBits(LCD_RS_MASK, rsValue)
        HAL.writeBits(LCD_E_MASK, 1)
        Thread.sleep(1)
        HAL.writeBits(LCD_E_MASK, 0)
    }
    // Escreve um byte de comando/dados no LCD em série
    fun writeNibbleSerial(rs: Boolean, data: Int) {

    }

    // Escreve um nibble de comando/dados no LCD
    private fun writeNibble(rs: Boolean, data: Int) {
        writeNibbleParallel(rs, data)
    }

    // Escreve um byte de comando/dados no LCD
    fun writeByte(rs: Boolean, data: Int) {
        writeNibble(rs, data shr 4)
        writeNibble(rs, data)
    }

    // Escreve um comando no LCD
    fun writeCMD(data: Int) {
        writeByte(false, data)
    }

    // Escreve um dado no LCD
    fun writeDATA(data: Int) {
        writeByte(true, data)
    }

    // Envia a sequência de iniciação para comunicação a 4 bits.
    fun init() {
        HAL.init()

        Thread.sleep(16)  // Esperar x ms
        writeCMD(3)
        Thread.sleep(5)   // Esperar x ms
        writeCMD(3)
        Thread.sleep(1)   // Esperar x ms
        writeCMD(3)

        writeCMD(2)

        writeCMD(2)
        writeCMD(40)

        writeCMD(8)

        writeCMD(1)

        writeCMD(6)

        writeCMD(15)
    }

    // Escreve um caráter na posição corrente.
    private fun write(c: Char) {
        writeDATA(c.code)
    }

    // Escreve uma string na posição corrente.
    fun write(text: String) {
        for (c in text)
            write(c)
    }

    // Envia comando para posicionar cursor (‘line’:0..LINES-1 , ‘column’:0..COLS-1)
    fun cursor(line: Int, column: Int) {
        writeCMD((line * 0x40 + column) or 0x80)
    }

    // Envia comando para limpar o ecrã e posicionar o cursor em (0,0)
    fun clear() {
        writeCMD(1)
        cursor(0,0)
    }
}

fun main() {
    LCD.init()
    println(LCD.writeCMD(2))
}