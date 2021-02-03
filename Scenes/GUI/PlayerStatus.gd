extends Control

onready var PlayerLabel = $MarginContainer/VBoxContainer/PlayerLabel
onready var ManaLabel = $MarginContainer/VBoxContainer/ManaLabel
onready var RepLabel = $MarginContainer/VBoxContainer/RepLabel
onready var WalletLabel = $MarginContainer/VBoxContainer/WalletLabel
onready var ZoneLabel = $MarginContainer/VBoxContainer/ZoneLabel

var username

func _ready():
	Events.connect('username_set', self, '_on_username_set')
	Events.connect('level_changed', self, '_on_level_changed')
	Events.connect('mana_changed', self, '_on_mana_changed')
	Events.connect('rep_changed', self, '_on_rep_changed')
	Events.connect('wallet_changed', self, '_on_wallet_changed')
	Events.connect('zone_change_completed', self, '_on_zone_changed')

func _on_username_set(_username):
	set_username(_username)

func _on_level_changed(old_level, new_level):
	update_level(new_level)

func _on_mana_changed(old_mana, new_mana, max_mana):
	update_mana(new_mana, max_mana)

func _on_rep_changed(old_rep, new_rep):
	update_rep(new_rep)

func _on_wallet_changed(old_wallet, new_wallet):
	update_wallet(new_wallet)

func _on_zone_changed(new_zone):
	update_zone_name(new_zone)


func set_username(_username):
	username = _username

func update_level(level):
	PlayerLabel.text = username + ' - L' + str(level)

func update_mana(current_mana, max_mana):
	ManaLabel.text = 'Mana: ' + str(current_mana) + '/' + str(max_mana)

func update_rep(value):
	RepLabel.text = 'Rep: ' + str(value)

func update_wallet(value):
	WalletLabel.text = 'Wallet: ' + str(value) + 'g'

func update_zone_name(_name):
	ZoneLabel.text = _name
