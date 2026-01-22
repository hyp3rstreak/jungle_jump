extends Area2D
@onready var animator: AnimatedSprite2D = $AnimatedSprite2D


func _on_body_entered(body: Node2D) -> void:
	body.treasure_area = true
	print(body.treasure_area)
	
func _on_body_exited(body: Node2D) -> void:
	body.treasure_area = false
	print(body.treasure_area)

func open_chest() -> void:
	animator.play("open")
