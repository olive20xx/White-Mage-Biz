extends Node

signal command_msg_logged(text)
signal error_msg_logged(text)
#signal cmd_invite(target)

func on_command_entered(text : String):
	# there's probably a way to make CommandChecking less manual
	if text.substr(1, 7) == 'invite ' or text.substr(1, 4) == 'inv ':
		var target = text.split(' ')[1]
		if target.length() < 2:
			var msg = '/invite command must include a valid player to invite. Ex: "/invite errico"'
			emit_signal('error_msg_logged', msg)
		# if target exists and is not in a party: emit_signal("cmd_invite", target)
		else:
			var msg = 'You invited ' + target + ' to join your party.'
			emit_signal('command_msg_logged', msg)
	else:
		var bad_cmd = text.split(' ')[0]
		var msg = 'Command "' + bad_cmd + '" not recognized. Type /cmds for a complete list of available commands.'
		emit_signal('error_msg_logged', msg)
#/invite
