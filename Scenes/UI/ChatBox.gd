extends Control

onready var chatLog = $MarginContainer/VBoxContainer/RichTextLabel
onready var inputLabel = $MarginContainer/VBoxContainer/ColorRect/HBoxContainer/Label
onready var inputField = $MarginContainer/VBoxContainer/ColorRect/HBoxContainer/LineEdit
onready var cmdManager = $CommandManager

var has_focus = false

var groups = [
	{'name': 'General', 'color': '#e2a084'}, #peach
	{'name': 'Party',   'color': '#11b7d7'}, #light blue
	{'name': 'Whisper', 'color': '#9e11d7'}, #dark pink
]

var group_index = 0
var player_username = Player.username

func _ready():
	change_group(5)


func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed('ui_accept') or event.is_action_pressed('focus_chat_backslash'):
			inputField.grab_focus()
		if event.is_action_pressed('ui_cancel'):
			inputField.release_focus()
		if event.is_action_pressed('chat_channel_next') and has_focus:
			change_group(1)


func change_group(value):
	group_index += value
	if group_index > (groups.size() - 1 ):
		group_index = 0
	inputLabel.text = '[' + groups[group_index]['name'] + ']'
	inputLabel.set('custom_colors/font_color', Color(groups[group_index]['color']))


func add_message(text, color):
	# Add leading linebreak only if chat box is empty 
	if chatLog.bbcode_text != '':
		chatLog.bbcode_text += '\n'
	chatLog.bbcode_text += '[color=' + color + ']'
	chatLog.bbcode_text += text
	chatLog.bbcode_text += '[/color]'


func add_chat_message(username, text, group = 0):
	var color = groups[group]['color']
	#var group_id = groups[group]['name'] UNFINISHED
	var final_text = '[' + username + ']: '
	final_text += text
	add_message(final_text, color)


func add_system_log(text):
	var final_text = text
	add_message(final_text, 'white')


func add_error_log(text):
	var final_text = '[ERROR]: '
	final_text += text
	add_message(final_text, 'red')

# Probably want to make a new Node to contain all the diff system messages
func _on_party_member_added(npc):
	add_system_log(npc.username + ' joined the party!')

func _on_teleport_requested(npc):
	var username = npc.username
	var text
	
	var random_text = randi() % 6
	match random_text:
		0: text = 'Can I get a TP please'
		1: text = 'need tp help'
		2: text = 'tptptptptp'
		3: text = 'i would like to teleport'
		4: text = 'any whm got tp?'
		5: text = 'hi cud i plaese hav tp'
	add_chat_message(username, text)

# Not sure how to make it so you can leave text in the inputfield, release focus
# then grab focus again with Enter without sending the leftover text
func _on_LineEdit_text_entered(new_text):
	if new_text != '':
		if new_text[0] == '/':
			cmdManager.on_command_entered(new_text)
		else:
			add_chat_message(player_username, new_text, group_index)
		inputField.text = ''


func _on_CommandManager_command_msg_logged(text):
	add_system_log(text)

func _on_CommandManager_error_msg_logged(text):
	add_error_log(text)

func _on_LineEdit_focus_entered():
	has_focus = true

func _on_LineEdit_focus_exited():
	has_focus = false
