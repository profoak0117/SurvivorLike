extends Node2D

@onready var animationPlayer = $AnimationPlayer
var moveTowardsPlayer: bool = false
var moveSpeed: float = 10
var ORIGINAL_SPEED: int = 10
var acceleration: float = 1.02

# Called when the node enters the scene tree for the first time.
func _ready():
	animationPlayer.play("idle")
	moveSpeed = ORIGINAL_SPEED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if moveTowardsPlayer:
		position += (Globals.PlayerPosition - position).normalized() * moveSpeed * delta
		moveSpeed *= acceleration


func _on_hitbox_body_entered(body):
	if body.is_in_group("Player"):
		Globals.incrementXP(1)
		queue_free()


func _on_attract_area_body_entered(body):
	if body.is_in_group("Player"):
		moveTowardsPlayer = true
		


func _on_attract_area_body_exited(body):
	if body.is_in_group("Player"):
		moveTowardsPlayer = false
		moveSpeed = ORIGINAL_SPEED
