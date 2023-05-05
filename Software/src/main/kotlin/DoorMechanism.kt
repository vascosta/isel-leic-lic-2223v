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
        SerialEmitter.send(SerialEmitter.Destination.DOOR, velocity shl 1 or 1)
    }
    // Envia comando para fechar a porta, com o parâmetro de velocidade
    fun close(velocity: Int) {
        while (!finished()) {
            Thread.sleep(1000)
        }
        SerialEmitter.send(SerialEmitter.Destination.DOOR, velocity shl 1 or 0)
    }
    // Verifica se o comando anterior está concluído
    private fun finished() : Boolean = !SerialEmitter.isBusy()
}

fun main() {
    DoorMechanism.init()
    println("Finished DoorMechanism.init()")
    Thread.sleep(1000)
    //DoorMechanism.open(1)
    DoorMechanism.close(4)
}