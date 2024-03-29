// INPUT PORT
const val D3__0_MASK        = 0b00001111 // I0-I3
const val DVAL_MASK         = 0b00010000 // I4
//const val _MASK        = 0b00100000 // I5
//const val _MASK       = 0b01000000 // I6
//const val _MASK          = 0b10000000 // I7

// OUTPUT PORT
const val LCD_DATA_MASK     = 0b00001111 // O0-O3
const val LCD_RS_MASK       = 0b00010000 // O4
const val LCD_E_MASK        = 0b00100000 // O5
const val nLCDsel_MASK      = 0b00000001 // O0
const val SCLK_MASK         = 0b00000010 // O1
const val SDX_MASK          = 0b00000100 // O2
const val BUSY_MASK         = 0b00001000 // O3
// const val nSDCsel_MASK      = 0b01000000 // O6
const val ACK_MASK          = 0b10000000 // O7