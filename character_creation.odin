package kuberpync

import "core:fmt"
import "core:os"
import "core:time"
import "core:bufio"
import "core:slice"

import "cli"

STDELAY :: time.Millisecond * 100

characterCreator :: proc() {
	new_pc := character{}
	fmt.println("initiating character creation")
	fmt.println("=============================")
	fmt.println("What is your character's name?")
	input: bufio.Reader
	bufio.reader_init(&input, os.to_reader(os.stdin))
	defer bufio.reader_destroy(&input)
	new_pc.name, _ = cli.input_string(&input)
	fmt.println("What is your character's job?: ")
	for job,i in Roles {
		fmt.printfln("%v %v ", i, job)
	}
	selected_role, _ := cli.input_enum(&input, Roles)
	new_pc.role[selected_role] = 4
	fmt.println("Rolling for stats (d10, floor of 3):")
	stat_rolls: [dynamic]int
	for len(stat_rolls) < 10 {
		for j := 0; j < 3; j += 1 {
			fmt.print(". ")
			time.sleep(STDELAY)
		}
		result := roll(10)
		fmt.printfln("\nRolled %d", result)
		if result <= 2 {
			fmt.println("Too low, rerolling.")
		} else {
			append(&stat_rolls, result)
		}
	}
	fmt.printfln("Rolls: %v", stat_rolls[:])
	for i in stat_rolls {
		fmt.printfln("Choose a stat to assign %d to:", stat_rolls[i])
		pretty_print_stats(&new_pc)
		selected_stat, _ := cli.input_enum(&input, Stat)
		new_pc.stats[selected_stat] = stat_rolls[i]
	}
	skill_points := 40
	for ; skill_points > 0; {
		fmt.printfln("Allocate skill points to a skill from this list:\n%v", Skill_List)
		if skill_selection, _ := cli.input_string(&input); slice.contains(Skill_List[:], skill_selection) {
			available_skill_points := 10
			if skill_points < 10 {
				available_skill_points = skill_points
			}
			fmt.printfln("Allocate up to %d skill points, you have %d skill points remaining:", available_skill_points, skill_points)
			allocated_skill_points, _ := cli.input_int(&input, 1, available_skill_points)
			new_pc.skills[skill_selection] = allocated_skill_points
			skill_points -= allocated_skill_points
		}
	}
	
	
	pretty_print_character(&new_pc)
}
