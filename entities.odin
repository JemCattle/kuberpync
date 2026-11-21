#+feature dynamic-literals

package kuberpync

import "core:fmt"

Stat :: enum {
	INT,
	REF,
	TECH,
	COOL,
	ATTR,
	LUCK,
	MOVE,
	BODY,
	EMP,
}

Roles :: enum {
	SOLO,
	ROCKER,
	NETRUNNER,
	MEDIA,
	NOMAD,
	FIXER,
	COP,
	CORP,
	TECHIE,
	MEDTECH,
}

bodyPart :: enum {
	HEAD,
	TORSO,
	R_ARM,
	L_ARM,
	R_LEG,
	L_LEG,
}

skillMap := map[string]Stat {
    // ATTR
    "Personal Grooming" = .ATTR,
    "Wardrobe & Style" = .ATTR,
    // BODY
    "Endurance" = .BODY,
    "Strength feat" = .BODY,
    "Swimming" = .BODY,
    "COOL/WILL" = .BODY,
    "Interrogation" = .BODY,
    "Intimidate" = .BODY,
    "Oratory" = .BODY,
    "Resist Torture/Drugs" = .BODY,
    "Streetwise" = .BODY,
    "EMPATHY" = .BODY,
    "Human Perception" = .BODY,
    "Interview" = .BODY,
    "Leadership" = .BODY,
    "Seduction" = .BODY,
    "Social" = .BODY,
    "Persuasion & Fast Talk" = .BODY,
    "Perform" = .BODY,
    // INT
    "Accounting" = .INT,
    "Anthropology" = .INT,
    "Awareness/Notice" = .INT,
    "Biology" = .INT,
    "Botany" = .INT,
    "Chemistry" = .INT,
    "Composition" = .INT,
    "Diagnose Illness" = .INT,
    "Education & Gen.Know" = .INT,
    "Expert" = .INT,
    "Gamble" = .INT,
    "Geology" = .INT,
    "Hide/Evade" = .INT,
    "History" = .INT,
    "Know Language (choose)" = .INT,
    "Library Search" = .INT,
    "Mathematics" = .INT,
    "Physics" = .INT,
    "Programming" = .INT,
    "Shadow/Track" = .INT,
    "Stock Market" = .INT,
    "System Knowledge" = .INT,
    "Teaching" = .INT,
    "Wilderness Survival" = .INT,
    "Zoology" = .INT,
    // REF
    "Archery" = .REF,
    "Athletics" = .REF,
    "Brawling" = .REF,
    "Dance" = .REF,
    "Dodge & Escape" = .REF,
    "Driving" = .REF,
    "Fencing" = .REF,
    "Handgun" = .REF,
    "Heavy Weapons" = .REF,
    "Martial Alt (choose type)" = .REF,
    "Melee" = .REF,
    "Motorcycle" = .REF,
    "Operate Hvy. Machinery" = .REF,
    "Pilot (Gyro)" = .REF,
    "Pilot (Fixed Wing)" = .REF,
    "Pilot (Dirigible)" = .REF,
    "Pilot (Vect.Thrust Vehicle)" = .REF,
    "Rifle" = .REF,
    "Stealth" = .REF,
    "Submachinegun" = .REF,
    // TECH
    "Aero Tech" = .TECH,
    "AV Tech" = .TECH,
    "Basic Tech" = .TECH,
    "Cryotank Operation" = .TECH,
    "Cyberdeck Design" = .TECH,
    "CyberTech" = .TECH,
    "Demolitions" = .TECH,
    "Disguise" = .TECH,
    "Electronics" = .TECH,
    "Elect. Security" = .TECH,
    "First Aid" = .TECH,
    "Forgery" = .TECH,
    "Gyro Tech" = .TECH,
    "Paint or Dtaw" = .TECH,
    "Photo & Film" = .TECH,
    "Pharmaceuticals" = .TECH,
    "Pick Lock" = .TECH,
    "Pick Pocket" = .TECH,
    "Play Instrument" = .TECH,
    "Weaponsmith" = .TECH,
}

Skill_List := [?]string{
    // ATTR
    "Personal Grooming",
    "Wardrobe & Style",
    // BODY
    "Endurance",
    "Strength feat",
    "Swimming",
    // COOL/WILL
    "Interrogation",
    "Intimidate",
    "Oratory",
    "Resist Torture/Drugs",
    "Streetwise",
    // EMPATHY
    "Human Perception",
    "Interview",
    "Leadership",
    "Seduction",
    "Social",
    "Persuasion & Fast Talk",
    "Perform",
    // INT
    "Accounting",
    "Anthropology",
    "Awareness/Notice",
    "Biology",
    "Botany",
    "Chemistry",
    "Composition",
    "Diagnose Illness",
    "Education & Gen.Know",
    "Expert",
    "Gamble",
    "Geology",
    "Hide/Evade",
    "History",
    "Know Language (choose)",
    "Library Search",
    "Mathematics",
    "Physics",
    "Programming",
    "Shadow/Track",
    "Stock Market",
    "System Knowledge",
    "Teaching",
    "Wilderness Survival",
    "Zoology",
    // REF
    "Archery",
    "Athletics",
    "Brawling",
    "Dance",
    "Dodge & Escape",
    "Driving",
    "Fencing",
    "Handgun",
    "Heavy Weapons",
    "Martial Alt (choose type)",
    "Melee",
    "Motorcycle",
    "Operate Hvy. Machinery",
    "Pilot (Gyro)",
    "Pilot (Fixed Wing)",
    "Pilot (Dirigible)",
    "Pilot (Vect.Thrust Vehicle)",
    "Rifle",
    "Stealth",
    "Submachinegun",
    // TECH
    "Aero Tech",
    "AV Tech",
    "Basic Tech",
    "Cryotank Operation",
    "Cyberdeck Design",
    "CyberTech",
    "Demolitions",
    "Disguise",
    "Electronics",
    "Elect. Security",
    "First Aid",
    "Forgery",
    "Gyro Tech",
    "Paint or Dtaw",
    "Photo & Film",
    "Pharmaceuticals",
    "Pick Lock",
    "Pick Pocket",
    "Play Instrument",
    "Weaponsmith",
}

character :: struct {
	name: string,
	role: [Roles]int,
	stats: [Stat]int,
	bodyloc: [bodyPart]int,
	skills: map[string]int,
}

role :: struct {
	name: string,
	level: int,
}

pretty_print_character :: proc(c: ^character) {
	fmt.printfln("Name:    %v", c.name)
	leveled_roles: [dynamic]role
	for lvl, i in c.role {
		if c.role[i] > 0 {
			role_name, _ := fmt.enum_value_to_string(i)
			append(&leveled_roles, role{role_name, lvl})
		}
	}
	fmt.printfln("Role:")
	for r in leveled_roles {
		fmt.printfln("  %v @ level %v", r.name, r.level)
	}
	pretty_print_stats(c)
}

pretty_print_stats :: proc(c: ^character) {
    fmt.printfln("Stats:")
    fmt.printfln("  INT:   %v", c.stats[.INT])
    fmt.printfln("  REF:   %v", c.stats[.REF])
    fmt.printfln("  TECH:  %v", c.stats[.TECH])
    fmt.printfln("  COOL:  %v", c.stats[.COOL])
    fmt.printfln("  ATTR:  %v", c.stats[.ATTR])
    fmt.printfln("  LUCK:  %v", c.stats[.LUCK])
    fmt.printfln("  MOVE:  %v", c.stats[.MOVE])
    fmt.printfln("  BODY:  %v", c.stats[.BODY])
    fmt.printfln("  EMP:   %v", c.stats[.EMP])
}

	// character sheet, set name and details as fields. Stats and skills string -> int maps (i8).Equipment struct for body parts and loadout slots.
