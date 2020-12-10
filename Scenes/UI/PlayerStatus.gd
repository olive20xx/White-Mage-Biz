extends Control

onready var PlayerLabel = $MarginContainer/VBoxContainer/PlayerLabel
onready var ManaLabel = $MarginContainer/VBoxContainer/ManaLabel
onready var RepLabel = $MarginContainer/VBoxContainer/RepLabel
onready var WalletLabel = $MarginContainer/VBoxContainer/WalletLabel
onready var ZoneLabel = $MarginContainer/VBoxContainer/ZoneLabel


func _ready():
	set_name_and_level()
	set_zone_name()
	update_mana()
	update_rep()
	update_wallet()


func update_rep():
	RepLabel.text = 'Rep: ' + str(Player.rep)

func update_wallet():
	WalletLabel.text = 'Wallet: ' + str(Player.wallet) + 'g'

func update_mana():
	ManaLabel.text = 'Mana: ' + str(Player.current_mana) + '/' + str(Player.max_mana)

func set_name_and_level():
	PlayerLabel.text = Player.username + ' - L' + str(Player.level)

func set_zone_name():
	var root = get_tree().get_root()
	var current_scene = root.get_child(root.get_child_count() - 1)
	ZoneLabel.text = current_scene.name
