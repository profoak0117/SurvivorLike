extends CharacterBody2D

class_name EnemyBase

@onready var health = $Health
@onready var hitbox = $Hitbox
@onready var sprite = $Sprite2D
@onready var animationPlayer = $AnimationPlayer
@onready var flashTimer = $FlashTimer
@onready var flashLengthTimer = $FlashLengthTimer

@export var speed: int = 25
@export var itemDropChance: int = 5
var flashing: bool = false
var flashActive: bool = false
var isKnockedBack: bool = false

var direction: Vector2 = Vector2.ZERO

signal spawnItemSignal(deathPosition: Vector2)

# Called when the node enters the scene tree for the first time.
func _ready():
	hitbox.HitSignal.connect(hit)
	health.HealthDepletedSignal.connect(die)

func die():
	if randi() % itemDropChance == 1:
		spawnItemSignal.emit(global_position)
	queue_free()

func hit(attack: Attack):
	health.hit(attack)
	var tween = get_tree().create_tween()
	isKnockedBack = true
	tween.tween_property(self, "position", position + (attack.knockbackDirection * attack.knockback), 0.05)
	tween.connect("finished", knockbackDone)
	flashing = true
	toggleHitFlash()
	flashTimer.stop()
	flashTimer.start()
	flashLengthTimer.stop()
	flashLengthTimer.start()
	
func knockbackDone():
	print("knockback done")
	isKnockedBack = false

func toggleHitFlash():
	flashActive = !flashActive
	sprite.material.set_shader_parameter("active", flashActive)


func _on_flash_timer_timeout():
	if flashing:
		toggleHitFlash()


func _on_flash_length_timer_timeout():
	flashing = false
	flashTimer.stop()
	if flashActive:
		toggleHitFlash()



