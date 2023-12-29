extends CharacterBody2D

@export var speed : int = 500
@onready var animatedSprite = $AnimatedSprite2D
enum AttackType {BULLET, SIDE_SWIPE}

var attackList: Array[AttackType] = []
var previousDirection : Vector2 = Vector2.ZERO
var previousX: float = 1
var attackPaths = {
	AttackType.BULLET : "res://scenes/bullet.tscn",
	AttackType.SIDE_SWIPE : "res://scenes/side_swipe.tscn"
}

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

func _ready():
	attackList.append(AttackType.SIDE_SWIPE)
	attackList.append(AttackType.BULLET)

func _process(delta):
	get_input()
	set_animation()
	move_and_slide()
	Globals.PlayerPosition = global_position


func _on_attack_timer_timeout():
	for attack in attackList:
		var attackInstance = load(attackPaths[attack]).instantiate()
		if attackInstance.followPlayer:
			add_child(attackInstance)
		else:
			attackInstance.global_position = global_position
			add_sibling(attackInstance)
			
		if previousX != 0:
			attackInstance.setAttackDirection(Vector2(previousX, 0).normalized())
		else:
			attackInstance.setAttackDirection(Vector2(1, 0).normalized())
