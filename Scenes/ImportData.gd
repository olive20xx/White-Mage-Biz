extends Node

var chat_dialog

func _ready():
	# Set up Chat Dialog dictionary
	var chatdialog_file = File.new()
	var cd_filepath = 'res://Data/ChatDialog.json'
	assert(chatdialog_file.file_exists(cd_filepath)) # check that it exists
	
	chatdialog_file.open(cd_filepath, File.READ)
	var chatdialog_json = JSON.parse(chatdialog_file.get_as_text())
	chatdialog_file.close()
	chat_dialog = chatdialog_json.result
