package kuberpync

import "core:sys/unix"
import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"
import "core:math/rand"

main :: proc() {
    test()
    characterCreator()
}

test :: proc() {
    pc := character{}
    pc.name="jonny fingerhands"
    pc.stats[.INT]=6
    pc.skills["Accounting"]=4
    skillToCheck := "Accounting"
    skillCheckResult := verb(&pc, skillToCheck, 12)
    if skillCheckResult == true {
        fmt.printfln("%v succeeded at %v against a DV of %d", pc.name, skillToCheck, 12)
    } else {
        fmt.printfln("%v failed at %v against a DV of %d", pc.name, skillToCheck, 12)
    }
}

characterCreator :: proc() {
    new_pc := character{}
    fmt.println("initiating character creation")
    fmt.println("=============================")
    fmt.println("What is your character's name?")
    {
        buf: [128]byte
        n, err := os.read(os.stdin, buf[:])
        if err != nil {
            fmt.println("Error reading input.")
            return
        }
        new_pc.name = string(buf[:n-1])
    }
    
    fmt.println("What is your character's job?: ")
    for job,i in roles {
        fmt.printfln("%v %v ", i, job)
    }
//    {
//        buf: [128]byte
//        n, err := os.read(os.stdin, buf[:])
//        if err != nil {
//            fmt.println("Error reading input.")
//            return
//        }
//        roleSelection := strings.trim_space(string(buf[:n]))
//        new_pc.role[roleSelection] = 4
//    }
    fmt.printfln("%v", new_pc)
}

rollTypes :: enum{
    StandardCheck, // dx + modifiers vs target
    OpposedCheck, // standard check vs standard check 
    SavingThrow, // roll under target
    TableLookup, // raw roll on table index
}

roll :: proc(d: int) -> int {
    return rand.int_range(0, d)
}

verb :: proc(subject: ^character, action: string, target: int) -> bool {
    skill_stat := skillMap[action]
    statMOD := subject.stats[skill_stat]
    skillMOD, ok := subject.skills[action]
    if !ok {skillMOD = 0}
    if roll(10) + statMOD + skillMOD > target {
        return true
    } else {
        return false
    }
}
