object M {
    // verificar se o bit M está ativo através do HAL

    fun init() {
        HAL.init()
    }

    fun verify() = HAL.isBit(M_MASK)
}