extends Node
# responsibe to switch level scenes and swith to battle mode

func start_battle(p1, p2):
	# first save the current scene
	var scene_context = game_controller.scene()
	game_controller.root().remove_child(scene_context)
	# initiate battle scene
	var battle_scene = load("res://battle/battle_view.tscn").instance()
	battle_scene.init(p1, p2)
	game_controller.root().add_child(battle_scene)
	game_controller.tree().set_current_scene(battle_scene)
