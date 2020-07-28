extends Node

# Manges Human fights:
# 1 - spawn the individual players fist humans

var p1
var p2

func init(_p1, _p2):
	# p1 is to be the player
	# p2 the opponent
	self.p1 = _p1
	self.p2 = _p2
	print("battle_init")
	print(p1)

func _ready():
	# fist make the first entities take their positions
	print(p2.entities)
	add_entity_pos(p1.entities[0].duplicate(), 1)
	add_entity_pos(p2.entities[0].duplicate(), 2)
	print("added entities to battle")
	pass # Replace with function body.

func add_entity_pos(e, pos):
	# TODO: First delete all other childs
	get_node("place" + str(pos)).add_child(e)
	e.init_animations_for_pos(pos)

