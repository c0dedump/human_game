extends "res://human/map_human.gd"

export var path = "ddlluurr" # a string with directions for that human to walk
var current_dir_pos = 0

func custom_process(delta):
	if not self.path == null:
		# Then continie walking the default path
		if walking_dir == 0:
			# then do the next move
			var proposed_dir_pos = ( current_dir_pos + 1 ) % (len(self.path))
			var action = path.substr(proposed_dir_pos, 1)
			#print(action)
			var i = game_controller.action_letter_index[action]
			var sucess = perform_step(i,delta)
			if sucess:
				self.current_dir_pos = proposed_dir_pos

