extends CharacterBody3D

var direction : Vector3
var input_dir : Vector2

@onready var plr = $"../../CharacterBody3D"

const SPEED = 1.0
const JUMP_VELOCITY = 4.5

var isStunned = false

@onready var stunTimer = $Timers/Stun

func flatten(vector: Vector3) -> Vector3:
	return Vector3( vector.x, 0, vector.z)

func move() -> void:
	if direction and isStunned == false:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 5)
		velocity.z = move_toward(velocity.z, 0, 5)



func _physics_process(delta: float) -> void:
	if stunTimer.time_left > 0:
		isStunned = true
	else:
		isStunned = false
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	direction = (plr.position - position).normalized()
	move()

	move_and_slide()
