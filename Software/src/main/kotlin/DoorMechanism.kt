// Controla o estado do mecanismo de abertura da porta.
object DoorMechanism {
    // Inicia a classe, estabelecendo os valores iniciais.
    fun init() {
        SerialEmitter.init()
    }
    // Envia comando para abrir a porta, com o parâmetro de velocidade
    fun open(velocity: Int) {
        while (!finished()) {
            Thread.sleep(1000)
        }
        SerialEmitter.send(SerialEmitter.Destination.DOOR, 1 shl 4 or velocity)
    }
    // Envia comando para fechar a porta, com o parâmetro de velocidade
    fun close(velocity: Int) {
        while (!finished()) {
            Thread.sleep(1000)
        }
        SerialEmitter.send(SerialEmitter.Destination.DOOR, 0 shl 4 or velocity)
    }
    // Verifica se o comando anterior está concluído
    private fun finished() : Boolean = !SerialEmitter.isBusy()
}