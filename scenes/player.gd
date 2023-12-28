extends CharacterBody2D

@export var speed : int = 500
@onready var animatedSprite = $AnimatedSprite2D
var bullet = preload("res://scenes/bullet.tscn")
var sideSwipe = preload("res://scenes/side_swipe.tscn")
var previousDirection : Vector2 = Vector2.ZERO
var previousX: int = 1

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	if input_direction != Vector2.ZERO:
		previousDirection = input_direction
		if previousDirection.x != 0:
			previousX = previousDirection.x
	
func set_animation():
	var animationName : String = "idle"
	var flipAnimation : bool = false
	if velocity.y < 0: 
		animationName = "walk_up"
	elif velocity.y > 0:
		animationName = "walk_down"
	if velocity.x > 0:
		animationName = "walk_right"
	elif velocity.x < 0:
		animationName = "walk_right"
		flipAnimation = true
	if velocity == Vector2.ZERO:
		if previousDirection.y < 0:
			animationName = "idle_up"
		if previousDirection.x != 0:
			animationName = "idle_right"
		if previousDirection.x < 0:
			flipAnimation = true
			
	animatedSprite.animation = animationName
	animatedSprite.flip_h = flipAnimation
	animatedSprite.play()

func _process(delta):
	get_input()
	set_animation()
	move_and_slide()
	Globals.PlayerPosition = global_position


func _on_attack_timer_timeout():
	var sideSwipeInstance =  sideSwipe.instantiate()
	#var bulletInstance = bullet.instantiate()
	#add_sibling(bulletInstance)
	add_child(sideSwipeInstance)
	#bulletInstance.global_position = global_position
	sideSwipeInstance.global_position = global_position
	#if previousX != 0:
		#bulletInstance.setBulletDirection(Vector2(previousX, 0).normalized())
	#else:
		#bulletInstance.setBulletDirection(Vector2(1, 0).normalized())
