package kuberpync

import "core:fmt"
// import "core:strconv"
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
