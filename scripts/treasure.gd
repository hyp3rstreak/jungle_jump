extends Area2D
@onready var animator: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: CharacterBody2D = $"../player"

var has_opened := false

func _on_body_entered(body: Node2D) -> void:
	body.treasure_area = true
	print(body.treasure_area)
	
func _on_body_exited(body: Node2D) -> void:
	body.treasure_area = false
	print(body.treasure_area)

func open_chest() -> void:
	animator.play("open")
	
func _ready():
	player.connect("openTreasure", _on_open_treasure)

func _on_open_treasure() -> void:
	print("OPEN SESAME") 
	if !has_opened:
		open_chest()  
		has_opened = !has_opened
	else:
		print("has been opened")
