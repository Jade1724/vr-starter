extends RigidBody

onready var flash_mesh = $Pistol_Flash
onready var laser_sight_mesh = $LaserSight
onready var raycast = $RayCast

const FLASH_TIME = 0.25
var flash_timer = 0

var BULLET_DAMAGE = 20

func _ready():
	flash_mesh.visible = false
	laser_sight_mesh.visible = false

func _physics_process(delta):
	if flash_timer > 0:
		flash_timer -= delta
		# If the flash has been visible enough, then make the flash mesh invisible.
		if flash_timer <= 0:
			flash_mesh.visible = false


# Called when the interact button is pressed while the object is held.
func interact():

	if flash_timer <= 0:

		flash_timer = FLASH_TIME
		flash_mesh.visible = true

		raycast.force_raycast_update()
		if raycast.is_colliding():

			var body = raycast.get_collider()

			if body.has_method("damage"):
				body.damage(raycast.global_transform, BULLET_DAMAGE)
			elif body.has_method("apply_impulse"):
				var direction_vector = raycast.global_transform.basis.z.normalized()
				body.apply_impulse((raycast.global_transform.origin - body.global_transform.origin).normalized(), direction_vector * 1.2)

		$AudioStreamPlayer3D.play()


# Called when the object is picked up.
func picked_up():
	laser_sight_mesh.visible = true


# Called when the object is dropped.
func dropped():
	laser_sight_mesh.visible = false
