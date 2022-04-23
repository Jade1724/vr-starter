extends RigidBody

var start_transform

var reset_timer = 0
const RESET_TIME = 120

func _ready():
	start_transform = global_transform
	
func _physics_process(delta):
	reset_timer += delta
	if reset_timer >= RESET_TIME:
		global_transform = start_transform
		reset_timer = 0
		
func interact():
	get_tree().change_scene("res://Game.tscn")
	
func picked_up():
	pass
	
func dropped():
	global_transform = start_transform
	reset_timer = 0
