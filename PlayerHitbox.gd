extends Area3D

@onready var hitboxes = $".." #all hitboxes

var reaction : Callable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area3D) -> void:
	if area.get_parent() == hitboxes: # Make sure it's not an other attack hitbox
		return
	if area.name == "Hurtbox":
		var enemy = area.get_parent()
		reaction.call(enemy)
		#print("AFarf")


func _on_lifetime_timeout() -> void:
	queue_free()
