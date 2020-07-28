extends Node
# this is the base node for a human

# a human has these properties:

# - movement pattern, like a chess figure
# - attack list, up to 4 attachks like in pokemon
#And the fighting properties:
# - attack
# - health
# - speed
# ...

var level = 1
var health = 100
export var ename = "default"

func _ready():
	pass # Replace with function body.

func init_by_dict(res):
	# self.ename should be correct already because by that its loeaded from scene
	self.health = res["health"]
	self.level = res["level"]

func print_json():
	var res = {"name": ename,
			"level": level,
			"health": health}
	return res

func init_animations_for_pos(pos):
	pass # seems like animation tree doesnt like to be used modularily; playback empty if u duplicate that node. TODO: report bug?
	var animations = game_controller.battle_animator.get_node("place" + str(pos) + "/animations")
	animations.root_node = self.get_path() # now set this node as the animations actor and set right animation state
	var animation_tree = game_controller.battle_animator.get_node("place" + str(pos) + "/p" + str(pos) + "_default_animation_tree")
	# animation_tree.set_tree_root(game_controller.battle_animator.get_animation_tree_root(pos))
	self.add_child(animations)
	self.add_child(animation_tree)
