extends Node
# is shared by all script instances, because in autoload

var tile_data = preload("res://tiles/base_tiles.tscn").instance()
var globals = preload("res://values/globals.gd")

var battle_entities = preload("res://human/battle_entities/entity_battle_col.tscn").instance()
var battle_animator = preload("res://battle/battle_view_animator.tscn").instance()
var walk_matrix = Array()

var action_names = ["none","up","right","down","left"]
var action_letters = ["n", "u", "r", "d", "l"]
var action_letter_index = {"n": 0, "u": 1, "r": 2, "d": 3, "l": 4}

var scene_switcher = load("res://game_controller/scene_switcher.gd").new()

func _ready():
	# load all the default stuff like tile scripts and co...
	self.walk_matrix.append(Vector2(0.0, 0.0))
	self.walk_matrix.append(Vector2(0.0, -1.0)) # up
	self.walk_matrix.append(Vector2(1.0, 0.0)) # right 
	self.walk_matrix.append(Vector2(0.0, 1.0)) # down 
	self.walk_matrix.append(Vector2(-1.0, 0.0)) # left

	# get_tree().get_root().add_child(scene_switcher) # TODO: maybe use management scene here

func scene():
	return get_tree().get_current_scene()

func get_tile(id):
	var tile = tile_data.find_node("tile" + str(id) + "_*")
	if tile == null:
		return tile_data.get_node("tile0_defaultTile")
	else:
		return tile

func get_tile_prop_string(id):
	# takes the tileset of the current game set and searces for name with following pattern:
	# #ID:1|:1,2,3,4
	return scene().get_node("base_map").tile_set.tile_get_name(id)


func battle_scene(p1, p2):
	scene_switcher.start_battle(p1, p2)

func root():
	return get_tree().get_root()

func tree():
	return get_tree()
