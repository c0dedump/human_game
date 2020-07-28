extends Node
# the base script for a human residing on the game map

var walking_dir = 0 # holds the walking direction
var looking_dir = 3
var walk_speed = 120.0*2.0 # in pixel per second
var distance_passed = 0.0

var ID = 0

var is_player = false # false for all non humans
var blocked_by_player = false

export var map_pos = Vector2(0.0, 0.0)

export var agressor = false # is that human wants to fight

export var entity_initializer = "" # for easy level creation a string is used to save all humans a enitie has for battle
var entities = Array()

var walk_matrix = game_controller.walk_matrix

func _ready():
	self.position = map_pos * game_controller.globals.tile_size
	self.custom_ready()
	#random_predifined_entites()
	load_entities_from_string()
	print_entities_json()

func custom_ready():
	pass # to be overwritten

func _process(delta):
	custom_process(delta)
	process_walking(delta)

func load_entities_from_string():
	if entity_initializer != "":
		var estrings = JSON.parse(entity_initializer).result
		for e in estrings:
			var e_raw = game_controller.battle_entities.get_bentity_by_name(e["name"]).duplicate()
			e_raw.init_by_dict(e)
			entities.append(e_raw)

func print_entities_json():
	var res = Array()
	for e in entities:
		res.append(e.print_json())
	# prints the current player entites as json string
	return JSON.print(res)

func random_predifined_entites():
	# helper method to make some entities
	var raw_entity = game_controller.battle_entities.get_bentity_by_name("default")
	raw_entity.level = 5
	raw_entity.health = 100
	entities.append(raw_entity)
	entities.append(raw_entity)
	entities.append(raw_entity)
	# print(print_entities_json())
	# self.entities.append()

func process_walking(delta):
	if(walking_dir != 0):
		var x_dist = walk_speed * walk_matrix[walking_dir].x * delta
		var y_dist = walk_speed * walk_matrix[walking_dir].y * delta
		# multiply delta so framerate independent
		self.position.x += x_dist
		self.position.y += y_dist
		distance_passed += abs(x_dist) + abs(y_dist) # one always 0
		if(distance_passed < 64.0):
			pass
		else:
			make_pos_exact()
			distance_passed = 0.0
			walking_dir = 0
			# change animation to idle/ pause on first fra
			$animation.stop()

func make_pos_exact():
	self.position.x = map_pos.x * game_controller.globals.tile_size
	self.position.y = map_pos.y * game_controller.globals.tile_size

func custom_process(delta): # new process method that can be overwritten
	pass

func perform_step(dir ,delta):
	var proposed_pos = map_pos + walk_matrix[dir]
	var next_tile_id = game_controller.scene().get_node("base_map").get_cell(int(proposed_pos.x), int(proposed_pos.y))
	var tile = game_controller.scene().tile_manager.get_map_tile_by_id(next_tile_id)
	var entity_on_field = false
	if self.is_player:
		entity_on_field = game_controller.scene().entity_manager.enter_tile_enemy_check(proposed_pos) # TODO: I only check collison enemy for player
	else:
		entity_on_field = game_controller.scene().get_player().map_pos == proposed_pos

	if(tile.is_walkable() and !entity_on_field):
		self.looking_dir = dir
		walking_dir = dir
		$animation.play()
		$animation.animation = "walk_" + str(game_controller.action_names[dir])
		self.map_pos = proposed_pos
		return true
	else:
		$animation.animation = "walk_" + str(game_controller.action_names[dir])
		self.looking_dir = dir
		return false


