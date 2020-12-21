extends Control

onready var PlayerLabel = $MarginContainer/VBoxContainer/PlayerLabel
onready var ManaLabel = $MarginContainer/VBoxContainer/ManaLabel
onready var RepLabel = $MarginContainer/VBoxContainer/RepLabel
onready var WalletLabel = $MarginContainer/VBoxContainer/WalletLabel
onready var ZoneLabel = $MarginContainer/VBoxContainer/ZoneLabel


func _ready():
	set_name_and_level('Kroan', 38)
	set_zone_name('HubCity')
	update_mana(500, 500)
	update_rep(0)
	update_wallet(500)


func update_rep(value):
	RepLabel.text = 'Rep: ' + str(value)

func update_wallet(value):
	WalletLabel.text = 'Wallet: ' + str(value) + 'g'

func update_mana(value1, value2):
	ManaLabel.text = 'Mana: ' + str(value1) + '/' + str(value2)

func set_name_and_level(_name, level):
	PlayerLabel.text = _name + ' - L' + str(level)

func set_zone_name(_name):
	ZoneLabel.text = _name
