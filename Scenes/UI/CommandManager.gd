extends Node

signal command_msg_logged(text)
signal error_msg_logged(text)
signal cmd_invite(target)
signal cmd_kick(target)


func on_command_entered(text : String):
	# there's probably a way to make CommandChecking less manual
	if text.substr(1, 6) == 'invite' or text.substr(1, 3) == 'inv':
		cmd_invite(text)
	elif text.substr(1, 4) == 'kick':
		cmd_kick(text)
	else:
		log_error_bad_cmd(text)
		print('on_command_entered error')


## /INVITE


func cmd_invite(text):
	# Error Checks
	if text == '/invite' or text == '/inv' or text == '/invite ' or text == '/inv ':
		var msg = '/invite command must include a valid player to invite.'
		emit_signal('error_msg_logged', msg)
		return
#	elif not ' ' in text: #THIS ISNT WORKING, STILL RECOGNIZES /INVTIE or /INVTEI
#		var msg = 'You must insert a space between /invite and the player\'s name'
#		emit_signal('error_msg_logged', msg)
#		return
	elif not (text.substr(1, 7) == 'invite ' or text.substr(1, 4) == 'inv '):
		log_error_bad_cmd(text)
		return
	
	# Find Target
	var target = text.split(' ')[1]
	
	if target.length() < 2:
		var msg = '/invite command must include a valid player to invite.'
		emit_signal('error_msg_logged', msg)
	else:
		emit_signal('cmd_invite', target)


func _on_cmd_invite_processed(target: String, status):
	var msg
	match status:
		-1: # Target not found
			msg = 'Player "' + target + '" not found in this zone.'
		0: # NO_TP
			msg = target + ' declined.'
		1: # CUSTOMER
			msg = 'You invited ' + target + ' to join the party.'
		2: # STOLEN
			msg = target + ' is already in another party.'
		3: # IN_PARTY
			msg = target + ' is already in the party.'
	
	emit_signal('command_msg_logged', msg)


## /KICK


func cmd_kick(text):
	# Error Checks
	if text == '/kick' or text == '/kick ':
		var msg = '/kick command must include a valid player to kick.'
		emit_signal('error_msg_logged', msg)
		return
	elif not text.substr(1, 5) == 'kick ':
		log_error_bad_cmd(text)
		return
	
	# Find Target
	var target = text.split(' ')[1]
	
	if target.length() < 2:
		var msg = '/kick command must include a valid player to kick.'
		emit_signal('error_msg_logged', msg)
	else:
		emit_signal('cmd_kick', target)


func _on_cmd_kick_processed(target: String, in_party: bool):
	var msg
	
	if in_party:
		msg = target + ' kicked from party.'
		emit_signal('command_msg_logged', msg)
	else:
		msg = 'Cannot kick ' + target + '. They are not in the party.'
		emit_signal('error_msg_logged', msg)


func log_error_bad_cmd(text):
	var bad_cmd = text.split(' ')[0]
	var msg = 'Command "' + bad_cmd + '" not recognized. Type /cmds for a complete list of available commands.'
	emit_signal('error_msg_logged', msg)
