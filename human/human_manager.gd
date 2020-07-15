extends Node

# central manager for all human entities on the map
var entities = Array()

func start():
	# first load all humans, indexed by the map position
	self.entities = game_controller.scene().get_node("entity_container").get_children()
	print(entities)
	for i in range(len(self.entities)):
		print(i)
		self.entities[i].ID = i

var blocked_entities = []
func add_blocked_entity(e):
	e.blocked_by_player = true
	blocked_entities.append(e)

func unblock_humans():
	for h in blocked_entities:
		h.blocked_by_player = false

func enter_tile_enemy_check(pos):
	for e in self.entities:
		print(e.map_pos)
		print(game_controller.scene().get_player().map_pos)
		if e.map_pos == pos:
			print(e)
			return true
	return false

func interact_on_pos(pos): # TODO: make more unique
	# called by player
	for e in self.entities:
		if e.map_pos == pos:
			return e
