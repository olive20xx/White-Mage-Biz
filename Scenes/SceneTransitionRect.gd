extends ColorRect

# Path to the next scene
var next_scene_path: String

# Reference to the AnimationPlayer node
onready var animPlayer := $AnimationPlayer


func _ready():
	# Plays the animation backward to fade in
	animPlayer.play_backwards('fade')


func transition_to(next_scene := next_scene_path) -> void:
	# Play the fade animation and wait until it finishes
	animPlayer.play('fade')
	yield(animPlayer, 'animation_finished')
	get_tree().change_scene(next_scene_path)
