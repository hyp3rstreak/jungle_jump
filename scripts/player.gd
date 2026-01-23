extends CharacterBody2D

@onready var animator: AnimatedSprite2D = $AnimatedSprite2D
@export var thrownItem_scene: PackedScene
@export var throwStr := 600.0

signal openTreasure()

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const DBL_JUMP_VELOCITY = -400.0
var is_attacking := false
var is_interacting := false
var is_dbl_jump := false
var treasure_area := false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and  is_on_floor():
		velocity.y = JUMP_VELOCITY
		animator.play("jump")
		is_dbl_jump = false
	elif Input.is_action_just_pressed("jump") and !is_on_floor():
		if !is_dbl_jump:
			velocity.y = DBL_JUMP_VELOCITY
			animator.play("jump")
			is_dbl_jump = true
		
	if Input.is_action_just_pressed("attack"):
		is_attacking = true
		animator.play("attack")
		throw_item(get_global_mouse_position())
		#get_tree().get_first_node_in_group("treasure").open_chest()
	
	
	
		
	if Input.is_action_just_pressed("interact"):
		if treasure_area:
			is_interacting = true
			animator.play("interact")
			emit_signal("openTreasure")
			#treasure.AnimatedSprite2D.play("open")
			
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("moveL", "moveR")
	
	#print(get_viewport().get_visible_rect().size.x/2)
	#print(get_local_mouse_position())
	#if get_local_mouse_position().x < 0:
		#animator.flip_h = true
	#else:
		#animator.flip_h = false
	
	if direction:
		if direction < 0:
			animator.flip_h = true
		elif direction > 0:
			animator.flip_h = false
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if !is_attacking and !is_interacting:
		if is_on_floor():
			if direction == 0:
				animator.play("idle")
			else:
				animator.play("run")
		else:
			animator.play("jump")
		
	move_and_slide()


func _on_animated_sprite_2d_animation_finished() -> void:
	if is_attacking:
		is_attacking = !is_attacking
	elif is_interacting:
		is_interacting = !is_interacting
	print("anim finish")
	
func throw_item(target_pos: Vector2) -> void:
		var item = thrownItem_scene.instantiate()
		var spawn_offset := 24
		var direction = (target_pos-global_position).normalized()
		
		item.global_position = global_position + direction * spawn_offset
		item.global_position.y -= 25
		get_tree().current_scene.add_child(item)
	
		item.throw(direction*throwStr)	
	
	
	
	
	
	
	
	
	
	
	
	
