extends Control

onready var chatLog = $MarginContainer/VBoxContainer/RichTextLabel
onready var inputLabel = $MarginContainer/VBoxContainer/ColorRect/HBoxContainer/Label
onready var inputField = $MarginContainer/VBoxContainer/ColorRect/HBoxContainer/LineEdit
onready var cmdManager = $CommandManager
var rng = RandomNumberGenerator.new()

var has_focus = false

var groups = [
	{'name': 'General', 'color': '#e2a084'}, #peach
	{'name': 'Party',   'color': '#11b7d7'}, #light blue
	{'name': 'Whisper', 'color': '#9e11d7'}, #dark pink
]

var group_index = 0
var player_username

func _ready():
	Events.connect('teleport_requested', self, '_on_teleport_requested')
	Events.connect('party_member_added', self, '_on_party_member_added')
	
	randomize()
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


# Probably want to make a new Node to contain all the diff system messages
func _on_party_member_added(npc):
	add_system_log(npc.username + ' joined the party!')
	var randomf = rng.randf_range(1.0, 3.0)
	yield(get_tree().create_timer(randomf), 'timeout')
	var chat_text = 'Thanks for the add! My destination is ' + npc.destination['name']
	add_chat_message(npc.username, chat_text, 1)


func _on_teleport_requested(npc, destination):
	var text
	var username = npc.username
	var dest_name = destination['name']
	
	var random_text = randi() % 7
	match random_text:
		0: text = 'Can I get a TP to ' + dest_name + ' please'
		1: text = 'need ' + dest_name + ' tp help'
		2: text = '<' + dest_name + '> tptptptptp' 
		3: text = 'i would like to teleport to ' + dest_name
		4: text = 'any whm got tp for ' + dest_name + '?'
		5: text = 'hi cud i plaese hav tp 2 ' + dest_name + 'z'
		6: text = '<' + dest_name + '> <Teleport> <Please!>'
	add_chat_message(username, text)


# Send message from a specific user in a specified chat group (General, Party, etc)
# Default group is General if not specified
func add_chat_message(username, text, group = 0):
	var color = groups[group]['color']
	#var group_id = groups[group]['name'] UNFINISHED
	var final_text = '[' + username + ']: '
	final_text += text
	add_message(final_text, color)


# Send white system log (for logging commands, sys actions, etc.)
func add_system_log(text):
	var final_text = text
	add_message(final_text, 'white')


# Send red [ERROR] log
func add_error_log(text):
	var final_text = '[ERROR]: '
	final_text += text
	add_message(final_text, 'red')


# Add basic colored text to ChatLog. Should almost always be used as helper function.
func add_message(text, color):
	# Add leading linebreak only if chat box is empty 
	if chatLog.bbcode_text != '':
		chatLog.bbcode_text += '\n'
	chatLog.bbcode_text += '[color=' + color + ']'
	chatLog.bbcode_text += text
	chatLog.bbcode_text += '[/color]'


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
