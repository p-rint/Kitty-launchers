extends Node

@onready var Player = $"../../CharacterBody3D"
@onready var plrHitboxes = $"../../CharacterBody3D/CharacterContainer/Hitboxes"

@onready var box = preload("res://Player_hitbox.tscn")

@onready var reactions = $"../Reactions"


func Atk1() -> void:
	print("Attack1")
	Player.velocity.z = -0
	var new = box.instantiate()
	new.reaction = reactions.Atk1
	plrHitboxes.add_child(new)



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Attack"):
		Atk1()
