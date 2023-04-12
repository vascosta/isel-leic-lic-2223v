import isel.leic.utils.Time

// Envia tramas para os diferentes módulos Serial Receiver.
object SerialEmitter {

    // USB PORT
    private const val clk:Long = 100

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
        if (addr == Destination.DOOR) {
            while (isBusy()) {
                Thread.sleep(1000)
            }
        }
        val destineMask = if (addr == Destination.LCD) nLCDsel_MASK else nSDCsel_MASK
        HAL.clearBits(destineMask)
        HAL.clearBits(SCLK_MASK)
        for (i in 4 downTo 0) {
            HAL.clearBits(SCLK_MASK)
            val sdx = (data shr i) and 1
            if (sdx == 1) HAL.setBits(SDX_MASK) else HAL.clearBits(SDX_MASK)
            Time.sleep(clk)
            HAL.setBits(SCLK_MASK)
        }
        Time.sleep(clk)
        HAL.setBits(destineMask)
        HAL.clearBits(SCLK_MASK)
    }

    // Retorna true se o canal série estiver ocupado
    fun isBusy(): Boolean = HAL.isBit(BUSY_MASK)
}
