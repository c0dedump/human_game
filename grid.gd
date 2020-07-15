tool

extends Node2D

export var width = 7
export var height = 9

export var x = 0
export var y = 0

var viewportsize

var globals = preload("res://values/globals.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	# For desktop we have to get the screen coodrinates from the settings
	viewportsize = Vector2(ProjectSettings.get_setting("display/window/size/width"), \
							ProjectSettings.get_setting("display/window/size/height"))
	print(viewportsize)
	print("correct indent")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()
	
func center():
	# Simply centers the gird on the screen after creation
	position.x = viewportsize.x / 2 - width * globals.tile_size * 0.5
	position.y = viewportsize.y / 2 - height * globals.tile_size * 0.5
	print((position.x as String)+ " was " + (position.y as String))

func _draw():
	for i in range(height + 1):
		draw_line(Vector2( x, y + i * globals.tile_size), \
		Vector2( x + width * globals.tile_size, y + i * globals.tile_size), Color.red)
		
	for i in range(width + 1):
		draw_line(Vector2( x + i * globals.tile_size, y), \
		Vector2( x + i * globals.tile_size, y + height * globals.tile_size), Color.red)

func get_actual_width():
	return width * globals.tile_size

func get_actual_height():
	return height * globals.tile_size

