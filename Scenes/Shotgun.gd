extends RigidBody

onready var flash_mesh = $Shotgun_Flash
onready var raycasts = $Raycasts

const FLASH_TIME = 0.25
var flash_timer = 0

var BULLET_DAMAGE = 30

func _ready():
	flash_mesh.visible = false

func _physics_process(delta):
	if flash_timer > 0:
		flash_timer -= delta
		if flash_timer <= 0:
			flash_mesh.visible = false


# Called when the interact button is pressed while the object is held.
func interact():

	if flash_timer <= 0:

		flash_timer = FLASH_TIME
		flash_mesh.visible = true

		for raycast in raycasts.get_children():

			raycast.rotation_degrees = Vector3(90 + rand_range(10, -10), 0, rand_range(10, -10))

			raycast.force_raycast_update()
			if raycast.is_colliding():

				var body = raycast.get_collider()

				# If the body has the damage method, then use that; otherwise, use apply_impulse.
				if body.has_method("damage"):
					body.damage(raycast.global_transform, BULLET_DAMAGE)
				elif body.has_method("apply_impulse"):
					var direction_vector = raycast.global_transform.basis.z.normalized()
					body.apply_impulse((raycast.global_transform.origin - body.global_transform.origin).normalized(), direction_vector * 4)

		$AudioStreamPlayer3D.play()


func picked_up():
	pass


func dropped():
	pass
