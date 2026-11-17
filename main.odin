package kuberpync

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"
import "core:math/rand"

main :: proc() {
    
}


RollTypes :: enum{
    StandardCheck, // dx + modifiers vs target
    OpposedCheck, // standard check vs standard check 
    SavingThrow, // roll under target
    TableLookup, // raw roll on table index
}

roll :: proc(d: int) -> int {
    return rand.int_max(d)
}

verb :: proc() -> bool {
    
}
