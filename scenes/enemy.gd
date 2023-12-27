extends Node2D
class_name Enemy

@onready var health = $Health
@onready var hitbox = $Hitbox
@onready var sprite = $AnimatedSprite2D
@onready var flashTimer = $FlashTimer
@onready var flashLengthTimer = $FlashLengthTimer

@export var speed: int = 25
@export var itemDropChance: int = 5
var flashing: bool = false
var flashActive: bool = false

var direction: Vector2 = Vector2.ZERO

signal spawnItemSignal(deathPosition: Vector2)

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play()
	hitbox.HitSignal.connect(hit)
	health.HealthDepletedSignal.connect(die)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction.normalized() * delta * speed

func die():
	if randi() % itemDropChance == 1:
		spawnItemSignal.emit(global_position)
	queue_free()

func hit(attack: Attack):
	health.hit(attack)
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", position + (direction.normalized() * -1 * attack.knockback), 0.05)
	flashing = true
	toggleHitFlash()
	flashTimer.stop()
	flashTimer.start()
	flashLengthTimer.stop()
	flashLengthTimer.start()
		
	
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



func _on_hitbox_area_entered(area):
	if area is Enemy:
		var newDirection = (direction + area.direction).normalized()
		direction = newDirection
		area.direction = newDirection
