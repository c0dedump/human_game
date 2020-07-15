extends Node

# hadels the tile
# e.g: for non static tiles this returns a saved instance

# Default tiles
var loaded_tiles = {} # Holds tiles that are instanced

func get_tile(id):
	var tile = game_controller.tile_data.find_node("tile" + str(id) + "_*")
	return tile

func get_default_tile():
	return game_controller.tile_data.get_node("tile0_defaultTile")

func get_map_tile_by_id(id):
	# first check if that tile was loaded before:
	if id in loaded_tiles:
		if loaded_tiles[id].is_static():
			# then this doesnt have to be loaded again
			return loaded_tiles[id]
		else:
			pass # initiate a new one of these non statics TODO
	else:
		# first check the default props of that tile:
		var props = Array(game_controller.scene().get_node("base_map").tile_set.tile_get_name(id).split(','))
		if props.has("initp"): # init by property
			var tile = get_default_tile().duplicate()
			game_controller.scene().get_node("static_tile_pool").add_child(tile)

			if props.has("B"):
				# its a blocking tile, meaning non walkable
				tile.walkable = false

			if props.has("L2"):
				tile.z_index = 2

			loaded_tiles[id] = tile
			return tile
		else:
			# then this tile is made of completely default properties
			var tile = game_controller.get_tile(id)
			loaded_tiles[id] = tile
			return tile

