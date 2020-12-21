extends ColorRect

# Reference to the AnimationPlayer node
onready var animPlayer := $AnimationPlayer


func _ready():
	#fade_in()
	pass


func fade_out():
	# Play the fade animation and wait until it finishes
	animPlayer.play('fade')
	yield(animPlayer, 'animation_finished')
	Events.emit_signal('fadeout_finished')

func fade_in():
	# Plays the animation backward to fade in
	animPlayer.play_backwards('fade')
	yield(animPlayer, 'animation_finished')
	Events.emit_signal('fadein_finished')
