extends Control

onready var display1 = $MarginContainer/VBoxContainer/PartyMemberDisplay1
onready var display2 = $MarginContainer/VBoxContainer/PartyMemberDisplay2
onready var display3 = $MarginContainer/VBoxContainer/PartyMemberDisplay3
onready var display4 = $MarginContainer/VBoxContainer/PartyMemberDisplay4

onready var displays = [display1, display2, display3, display4]

func _ready():
	for display in displays:
		display.hide()

func _on_party_member_added(npc: NpcData):
	for display in displays:
		if not display.visible:
			display.update_display(npc)
			display.show()
			return

func _on_party_member_removed(npc: NpcData):
	for display in displays:
		if display.visible and display.username.text == npc.username:
			display.hide()
			return
