// Envia tramas para os diferentes módulos Serial Receiver.
object SerialEmitter {

    enum class Destination {
        LCD,
        DOOR
    }

    // Inicia a classe
    fun init() {
        HAL.init()
        HAL.clearBits(nLCDsel_MASK)
        HAL.clearBits(SCLK_MASK)
        HAL.clearBits(SDX_MASK)
    }

    // Envia uma trama para o SerialReceiver identificado o destino em addr e os bits de dados em ‘data’.
    fun send(addr: Destination, data: Int) {
        while (isBusy()) {
            Thread.sleep(1000)
        }
        //val nSSMask = if (addr == Destination.LCD) nLCDsel_MASK else nSDCsel_MASK
        val nSSMask = nLCDsel_MASK
        HAL.clearBits(nSSMask)
        HAL.clearBits(SCLK_MASK)
        for (i in 4 downTo 0) {
            HAL.clearBits(SCLK_MASK)
            val sdx = (data shr i) and 1
            if (sdx == 1) HAL.setBits(SDX_MASK) else HAL.clearBits(SDX_MASK)
            HAL.setBits(SCLK_MASK)
        }
        HAL.setBits(nSSMask)
        HAL.clearBits(SCLK_MASK)
    }

    // Retorna true se o canal série estiver ocupado
    private fun isBusy(): Boolean = HAL.isBit(BUSY_MASK)
}

fun main() {
    SerialEmitter.init()
    for (i in 0..31) {
        SerialEmitter.send(SerialEmitter.Destination.LCD, i)
        Thread.sleep(250)
    }
}