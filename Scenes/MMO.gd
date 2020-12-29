class_name MMO
extends Node2D

onready var player = $Player
onready var npcManager = $NpcManager
onready var chatBox = $CanvasLayer1/GUI/ChatBox
onready var transitionEffect = $CanvasLayer2/SceneTransitionRect

var current_zone: Node2D


func _ready():
	Events.connect('cast_teleport', self, 'change_zones')
	Events.connect('cast_recall', self, 'load_hub')
	
	chatBox.player_username = player.username
	
	# Eventually, this will load the zone where you "logged off" if it exists
	load_hub()


func setup_npc_manager():
	npcManager.current_zone = current_zone
	npcManager.setup_npcs()


func change_zones(dest_dict):
	# Load next zone
	var dest_resource = load(dest_dict['path'])
	var dest = dest_resource.instance()
	
	# Delete current zone after transition effect (fade out)
	transitionEffect.fade_out()
	yield(Events, 'fadeout_finished')
	remove_child(current_zone)
	current_zone.call_deferred('free')
	
	# Show new zone with transition effect (fade in)
	add_child(dest)
	current_zone = dest
	setup_npc_manager()
	transitionEffect.fade_in()
	yield(Events, 'fadein_finished')
	Events.emit_signal('zone_change_completed', current_zone.name)


func load_hub():
	if current_zone:
		# Delete current zone after transition effect (fade out)
		transitionEffect.fade_out()
		yield(Events, 'fadeout_finished')
		
		remove_child(current_zone)
		current_zone.call_deferred('free')
	
	var hub_resource = load(Static.hubcity_path)
	var hub = hub_resource.instance()
	add_child(hub)
	current_zone = hub
	setup_npc_manager()
	transitionEffect.fade_in()
	yield(Events, 'fadein_finished')
	Events.emit_signal('zone_change_completed', current_zone.name)
