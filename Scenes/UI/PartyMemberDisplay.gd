extends HBoxContainer

onready var portrait = $CenterContainer/Portrait
onready var username = $MarginContainer/VBoxContainer/Name
export(Array, Resource) var portraits


# Called when the node enters the scene tree for the first time.
func _ready():
	#randomize()
	#var randomIndex = randi() % (portraits.size())
	#portrait.texture = portraits[randomIndex]
	var regionPos = Vector2(randi() % 8, randi() % 8) * 48
	portrait.texture.region.position = regionPos

func update_display(npc: NpcData):
	# Create a unique AtlasTexture
	var new_atlas_texture = portrait.texture.duplicate()
	portrait.texture = new_atlas_texture
	
	# Pick a random portrait from the AtlasTexture
	var randomRegion = Vector2(randi() % 8, randi() % 8) * 48
	portrait.texture.region.position = randomRegion
	
	username.text = npc.username
