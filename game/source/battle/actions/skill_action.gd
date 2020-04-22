extends BattleAction
class_name SkillAction

var skill: Skill = null

func _ready() -> void:
	name = skill.name
	icon = skill.icon
	randomize()

func execute(targets):
	assert(initialized)
	if actor.party_member and not targets:
		return false
	
	actor.stats.sp -= skill.sp_cost
