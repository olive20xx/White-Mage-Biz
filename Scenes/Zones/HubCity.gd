extends Node2D

onready var npcManager = $NpcManager
onready var chatBox = $CanvasLayer/UI/ChatBox
onready var commandManager = $CanvasLayer/UI/ChatBox/CommandManager
onready var partyInterface = $CanvasLayer/UI/PartyInterface

export(int) var base_payment = 500

func _ready():
	pass
