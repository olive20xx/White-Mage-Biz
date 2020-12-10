extends HBoxContainer

onready var portrait = $CenterContainer/Portrait
onready var username = $MarginContainer/VBoxContainer/Name

var my_npc: NpcData = null


func _ready():
	pass


func assign_npc(npc:NpcData):
	my_npc = npc
	
	# Create a unique AtlasTexture
	var new_atlas_texture = portrait.texture.duplicate()
	portrait.texture = new_atlas_texture
	
	# Pick a random portrait from the AtlasTexture
	var randomRegion = Vector2(randi() % 8, randi() % 8) * 48
	portrait.texture.region.position = randomRegion
	
	username.text = my_npc.username


func remove_npc():
	my_npc = null
	username.text = ''


func update_display():
	if my_npc:
		show()
	else:
		hide()
