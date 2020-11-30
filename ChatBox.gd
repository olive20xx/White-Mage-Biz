extends Control

onready var chatLog = get_node("VBoxContainer/RichTextLabel")
onready var inputLabel = get_node("VBoxContainer/ColorRect/HBoxContainer/Label")
onready var inputField = get_node("VBoxContainer/ColorRect/HBoxContainer/LineEdit")

var has_focus = false

var groups = [
	{'name': 'Party',   'color': '#11b7d7'}, #light blue
	{'name': 'Whisper', 'color': '#9e11d7'}, #dark pink
	{'name': 'General', 'color': '#e2a084'}  #peach
]

var group_index = 0
var user_name = "Kroan"

func _ready():
	inputField.connect("text_entered", self, "on_text_entered")
	inputField.connect("focus_entered", self, "on_focus_entered")
	inputField.connect("focus_exited", self, "on_focus_released")
	
	change_group(0)

func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("ui_accept"):
			inputField.grab_focus()
		if event.is_action_pressed("ui_cancel"):
			inputField.release_focus()
		if event.is_action_pressed("chat_channel_next") and has_focus:
			change_group(1)

func change_group(value):
	group_index += value
	if group_index > (groups.size() - 1 ):
		group_index = 0
	inputLabel.text = '[' + groups[group_index]['name'] + ']'
	inputLabel.set('custom_colors/font_color', Color(groups[group_index]['color']))

func add_message(username, text, group = 0):
	# Add leading linebreak only if chat box is empty 
	if chatLog.bbcode_text != '':
		chatLog.bbcode_text += '\n'
	chatLog.bbcode_text += '[color=' + groups[group]['color'] + ']'
	chatLog.bbcode_text += '[' + username + ']: '
	chatLog.bbcode_text += text
	chatLog.bbcode_text += '[/color]'

# Not sure how to make it so you can leave text in the inputfield, release focus
# then grab focus again with Enter without sending the leftover text
func on_text_entered(new_text):
	if new_text != '':
		print(new_text)
		add_message(user_name, new_text, group_index)
		inputField.text = ''

func on_focus_entered():
	has_focus = true

func on_focus_released():
	has_focus = false
