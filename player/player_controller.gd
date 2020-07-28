extends "res://human/map_human.gd"

signal made_player_step

var in_conversation = false

func custom_ready():
	self.is_player = true

func custom_process(delta):
	game_controller.scene().get_node("cam").position = self.position
	# first process the inputs
	# only check for pressed if no message active:
	if !game_controller.scene().is_message_active():
		for i in range(1,5):
			if(Input.is_action_pressed("ui_"+str(game_controller.action_names[i])) and walking_dir == 0):
				# Here do the tile handeling
				var sucess = perform_step(i, delta)

		if Input.is_action_pressed("ui_accept"):
			if walking_dir == 0 and !self.in_conversation:
				interact_forward()

func interact_forward():
	var looking_field = self.map_pos + game_controller.walk_matrix[self.looking_dir]
	var entity = game_controller.scene().entity_manager.interact_on_pos(looking_field)
	if entity != null:
		# First talk to that entity
		self.in_conversation = true
		game_controller.scene().message_system().display_text_portionwhise(entity.name)
		yield(game_controller.scene().message_system(), "dialogue_finalized")
		self.in_conversation = false
		# then maybe fight tat enemy
		if entity.agressor:
			# first start the fight scene
			print("to battle")
			game_controller.battle_scene(self, entity)
