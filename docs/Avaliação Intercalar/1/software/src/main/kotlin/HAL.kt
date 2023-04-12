import isel.leic.UsbPort

// Virtualiza o acesso ao sistema UsbPort
object HAL {

    private var lastWriting = 0

    // Inicia a classe
    fun init() {
        UsbPort.write(lastWriting)
    }

    // Retorna true se o bit tiver o valor lógico ‘1’
    fun isBit(mask: Int): Boolean {
        val temp = mask and UsbPort.read()
        return mask == temp
    }

    // Retorna os valores dos bits representados por mask presentes no UsbPort
    fun readBits(mask: Int): Int = mask and UsbPort.read()

    // Escreve nos bits representados por mask o valor de value
    fun writeBits(mask: Int, value: Int) {
        val a = mask and value
        val b = mask.inv() and lastWriting
        val c = a or b
        UsbPort.write(c)
        lastWriting = c
    }

    // Coloca os bits representados por mask no valor lógico ‘1’
    fun setBits(mask: Int) {
        writeBits(mask,0xFF)
    }

    // Coloca os bits representados por mask no valor lógico ‘0’
    fun clearBits(mask:Int) {
        writeBits(mask,0x00)
    }
}