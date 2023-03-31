/*
import isel.leic.utils.Time

// Envia tramas para os diferentes módulos Serial Receiver.
object SerialEmitter {

    // USB PORT
    private const val clk:Long = 100

    enum class Destination {
        LCD,
    }

    // Inicia a classe
    fun init() {
        HAL.init()
        HAL.setBits(SS_MASK)
        HAL.clearBits(SCLK_MASK)
        HAL.clearBits(SDX_MASK)
    }

    // Envia uma trama para o SerialReceiver identificado o destino em addr e os bits de dados em ‘data’.
    fun send(addr: Destination, data: Int) {
        while (isBusy()) {
            Thread.sleep(1000)
        }

        HAL.clearBits(SS_MASK)
        HAL.clearBits(SCLK_MASK)

        val destino = if (addr == Destination.LCD) 0 else 1
        var trama = (data shl 1) or destino // adicionar TnL (bit 0)
        var bitParidade = 0

        // enviar 10 bits (trama)
        for (i in 0..9) {
            HAL.clearBits(SCLK_MASK)

            // enviar o bit menor peso
            val sdx = trama and 1
            if (sdx == 1) HAL.setBits(SDX_MASK) else HAL.clearBits(SDX_MASK)
            bitParidade = bitParidade xor sdx
            trama = trama.shr(1) // "eliminar" o bit menor peso (enviado agora)

            Time.sleep(clk)
            HAL.setBits(SCLK_MASK)
        }

        // enviar ultimo bit (paridade)
        HAL.clearBits(SCLK_MASK)
        Time.sleep(clk)
        if (bitParidade == 1) HAL.setBits(SDX_MASK) else HAL.clearBits(SDX_MASK)
        HAL.setBits(SCLK_MASK)

        Time.sleep(clk)
        HAL.setBits(SS_MASK)
        HAL.clearBits(SCLK_MASK)
    }

    // Retorna true se o canal série estiver ocupado
    fun isBusy(): Boolean = HAL.isBit(BUSY_MASK)
}

*/
