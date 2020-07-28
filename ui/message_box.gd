extends Label

var animating = false

signal animation_finalized
signal confirmed
signal dialogue_finalized

var active_message = true

var awaiting_confirmation
var animation_depth = 0
const max_chars = 150

const test_text = "adfadf dfa was geht denn so adfadf dfa was geht denn so adfadf dfa was geht denn so adfadf dfa was geht denn so adfadf dfa was geht denn so adfadf dfa was geht denn so adfadf dfa was geht denn sowhile aanimation_depth > 0:dfadf dfa was geht denn soA  animation_depth > 0:dfadf dfa was geht denn so panimation_depth > 0:dfadf dfa was geht denn soA Animation_depth > 0:dfadf dfa was geht denn soA"

var hidden = false

func _ready():
	# when loading the label test how many lines can display
	#self.linecount = self.get_visible_line_count()
	#print(self.get_line_height())
	hide_m(0) # TODO: make hidden by default
	self.active_message = false

func _process(delta):
	if awaiting_confirmation:
		if Input.is_action_pressed("ui_accept"):
			emit_signal("confirmed")

func display_text_portionwhise(text):
	self.active_message = true
	# displays many text blocks after another animated, always fitting the mesage box
	var charamnt = len(text)
	for i in range(0, int(charamnt / self.max_chars + 1)):
		print("showed")
		hide_change_show(text.substr(self.max_chars*i, self.max_chars*(i+1) if self.max_chars*(i+1) < charamnt else charamnt ))
		while animation_depth > 0:
			yield(self, "animation_finalized")
		awaiting_confirmation = true
		yield(self, "confirmed")
		print("hidden")
	while animation_depth > 0:
		yield(self, "animation_finalized")
	awaiting_confirmation = true
	yield(self, "confirmed")
	hide_m(0)
	while animation_depth > 0:
		yield(self, "animation_finalized")
	self.active_message = false
	emit_signal("dialogue_finalized")

func hide_m(depth):
	# Hides the message box, by playing hide animation
	assert(self.animation_depth == depth)
	var ani =  get_parent().get_node("box_animations")
	self.animation_depth += 1
	ani.play("hide")
	yield(ani,"animation_finished")
	self.animating = false
	self.animation_depth -= 1
	self.hidden = true
	emit_signal("animation_finalized")
	

func show_m(depth):
	# Displays the message box, by reverse hiding
	assert(self.animation_depth == depth) 
	var ani = get_parent().get_node("box_animations")
	self.animation_depth += 1
	ani.play_backwards("hide")
	yield(ani,"animation_finished")
	self.animating = false
	self.animation_depth -= 1
	self.hidden = false
	emit_signal("animation_finalized")

func hide_change_show(text):
	# does function name
	# only hide if hidden
	self.animation_depth += 1
	if !hidden:
		hide_m(self.animation_depth)
		while animation_depth > 1:
			yield(self, "animation_finalized")
	self.text = text
	show_m(self.animation_depth)
	self.animation_depth -= 1
	emit_signal("animation_finalized")
