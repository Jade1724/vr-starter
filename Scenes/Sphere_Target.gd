extends StaticBody

var destroyed = false
var destroyed_timer = 0
const DESTROY_WAIT_TIME = 80

var health = 80

const RIGID_BODY_TARGET = preload("res://Assets/RigidBody_Sphere.scn")

func _ready():
	set_physics_process(false)

func _physics_process(delta):
	destroyed_timer += delta
	if destroyed_timer >= DESTROY_WAIT_TIME:
		queue_free()


func damage(bullet_global_transform, damage):

	if destroyed:
		return

	health -= damage

	if health <= 0:

		$CollisionShape.disabled = true
		$Sphere_Target.visible = false

		var clone = RIGID_BODY_TARGET.instance()
		add_child(clone)
		clone.global_transform = global_transform

		destroyed = true
		set_physics_process(true)

		$AudioStreamPlayer.play()
		get_tree().root.get_node("Game").remove_sphere()
