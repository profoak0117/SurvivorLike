extends Node2D

class_name AttackBase

@onready var attack = $Attack
@onready var sprite = $Sprite2D
@onready var hitbox = $Hitbox
var direction : Vector2 = Vector2.RIGHT
var destroySelfOnHit : bool = false
var followPlayer: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_hitbox_area_entered(area):
	if area is Hitbox:
		if area.has_method("hit"):
			area.hit(attack)
			print("hitting hitbox")
			if destroySelfOnHit:
				queue_free()
		
func setAttackDirection(dir: Vector2):
	attack.knockbackDirection = dir
	direction = dir
	if dir.x <= 0:
		scale.x = -1
