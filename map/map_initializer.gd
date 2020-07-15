extends Node # should extend level, with given width and height

var tile_manager = load("res://tiles/tile_manager.gd").new()
var entity_manager = load("res://human/human_manager.gd").new()

func _ready():
	# generally hast the task to initialize the ma
	entity_manager.start()

func get_player():
	return self.get_node("player")

func message_system():
	return self.get_node("cam/message_container/label")
