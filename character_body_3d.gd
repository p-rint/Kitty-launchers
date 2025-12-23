extends CharacterBody3D

var direction : Vector3
var input_dir : Vector2


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var camPiv = $CamPivot

@onready var AttackFuncs = $"../GameFunctions/Attacks"

@onready var model = $CharacterContainer

var dt : float

@onready var animTree: AnimationTree = $AnimationTree

@onready var bulletSpawn = $CharacterContainer/Armature/Skeleton3D/BoneAttachment3D/catzooka/Cube/spawn

func flatten(vector: Vector3) -> Vector3:
	return Vector3( vector.x, 0, vector.z)

func move() -> void:
	model.rotation.y = lerp_angle(model.rotation.y, atan2(camPiv.basis.z.x, camPiv.basis.z.z), .2)
	if direction:
		velocity.x = lerp(velocity.x, direction.x * SPEED, .15 * 2)
		velocity.z = lerp(velocity.z, direction.z * SPEED, .15 * 2)
		#model.rotation.y = lerp_angle(model.rotation.y, atan2(-velocity.x, -velocity.z), .2)
	else:
		velocity.x = move_toward(velocity.x, 0, .15 * 3)
		velocity.z = move_toward(velocity.z, 0, .15 * 3)
	
	animTree.set("parameters/Run/blend_position", velocity.length()/SPEED)

func _physics_process(delta: float) -> void:
	dt = delta
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	input_dir = Input.get_vector("Left", "Right", "Up", "Down")
	direction = flatten($CamPivot.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	move()
	
	
	move_and_slide()
