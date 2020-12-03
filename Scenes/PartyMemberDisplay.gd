extends HBoxContainer

onready var portrait = $CenterContainer/Portrait
export(Array, Resource) var portraits


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	#var randomIndex = randi() % (portraits.size())
	#portrait.texture = portraits[randomIndex]
	var regionPos = Vector2(randi() % 8, randi() % 8) * 48
	portrait.texture.region.position = regionPos
