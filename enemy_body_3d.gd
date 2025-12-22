extends CharacterBody3D

var direction : Vector3
var input_dir : Vector2

@onready var plr = $"../../CharacterBody3D"

const SPEED = 1.0
const JUMP_VELOCITY = 4.5

@onready var camPiv = $CamPivot

@onready var AttackFuncs = $"../GameFunctions/Attacks"

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
	# Add the gravity.
	if stunTimer.time_left > 0:
		isStunned = true
		print(stunTimer.time_left)
	else:
		isStunned = false
	
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	direction = (plr.position - position).normalized()
	move()

	move_and_slide()
