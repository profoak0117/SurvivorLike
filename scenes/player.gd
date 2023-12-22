extends CharacterBody2D

@export var speed : int = 500
@onready var animatedSprite = $AnimatedSprite2D
var bullet = preload("res://scenes/bullet.tscn")
var previousDirection : Vector2 = Vector2.ZERO

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	if input_direction != Vector2.ZERO:
		previousDirection = input_direction
	
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


func _on_attack_timer_timeout():
	var bulletInstance = bullet.instantiate()
	if previousDirection.x != 0:
		bulletInstance.direction = Vector2(previousDirection.x, 0)
	add_child(bulletInstance)
