extends Node2D

@onready var health = $Health
@onready var hitbox = $Hitbox
@onready var sprite = $AnimatedSprite2D
@onready var flashTimer = $FlashTimer
@onready var flashLengthTimer = $FlashLengthTimer

@export var speed: int = 25
var flashing: bool = false
var flashActive: bool = false

var direction: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play()
	hitbox.HitSignal.connect(hit)
	health.HealthDepletedSignal.connect(die)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction.normalized() * delta * speed

func die():
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
	print("flash timer timeout")
	if flashing:
		toggleHitFlash()


func _on_flash_length_timer_timeout():
	print("flash length timeout")
	flashing = false
	flashTimer.stop()
	if flashActive:
		toggleHitFlash()
