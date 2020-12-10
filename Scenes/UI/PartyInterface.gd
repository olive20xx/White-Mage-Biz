extends Control

onready var display1 = $MarginContainer/VBoxContainer/PartyMemberDisplay1
onready var display2 = $MarginContainer/VBoxContainer/PartyMemberDisplay2
onready var display3 = $MarginContainer/VBoxContainer/PartyMemberDisplay3
onready var display4 = $MarginContainer/VBoxContainer/PartyMemberDisplay4

onready var displays = [display1, display2, display3, display4]

func _ready():
	var _index = 0
	for npc in Player.party_members:
		var d = displays[_index]
		d.assign_npc(npc)
		d.show()
		_index += 1


func _on_party_member_added(npc: NpcData):
	for display in displays:
		if not display.visible:
			display.assign_npc(npc)
			display.show()
			return


func _on_party_member_removed(npc: NpcData):
	for display in displays:
		if display.visible and display.my_npc == npc:
			display.hide()
			display.remove_npc()
			return
