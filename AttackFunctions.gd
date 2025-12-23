extends Node

@onready var Player = $"../../CharacterBody3D"
@onready var plrHitboxes = $"../../CharacterBody3D/CharacterContainer/Hitboxes"
@onready var Projectiles = $"../../Projectiles"

@onready var box = preload("res://Player_hitbox.tscn")

@onready var projectile = preload("res://Projectile_hitbox.tscn")

@onready var reactions = $"../Reactions"


func Atk1() -> void:
	#Player.velocity.z = -0
	var new = box.instantiate()
	new.reaction = reactions.Atk1
	plrHitboxes.add_child(new)

func Gun1() -> void:
	
	var new = projectile.instantiate()
	new.reaction = reactions.Gun1
	new.position = Player.bulletSpawn.global_position #Player.position
	new.direction = (-Player.camPiv.basis.z).normalized()
	new.upVec = -(Player.camPiv.basis.y).normalized()
	Projectiles.add_child(new)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Attack"):
		Gun1()
	if Input.is_action_just_pressed("Shoot"):
		Gun1()
