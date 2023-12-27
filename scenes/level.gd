extends Node2D

@onready var enemySpawner = $EnemySpawner
@onready var player = $Player
@onready var enemy = preload("res://scenes/enemy.tscn")
@onready var item = preload("res://scenes/item.tscn")
var MIN_RANGE: int = 200
var MAX_RANGE: int = 400

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for enemyChild in enemySpawner.get_children():
		enemyChild.direction = $Player.position - enemyChild.position

func spawnEnemy():
	var spawnRange: int = 20
	var enemyPos: Vector2 = Vector2(randf_range(spawnRange * -1,spawnRange), randf_range(spawnRange * -1,spawnRange))
	var enemyDistance: float = randf_range(MIN_RANGE, MAX_RANGE)
	enemyPos = enemyPos.normalized()
	enemyPos *= enemyDistance
	var enemyInstance = enemy.instantiate()
	enemySpawner.add_child(enemyInstance)
	enemyInstance.global_position = $Player.position + enemyPos
	enemyInstance.spawnItemSignal.connect(spawnItem)
	enemyInstance.itemDropChance = 2


func _on_spawn_timer_timeout():
	spawnEnemy()

func spawnItem(itemPosition: Vector2):
	var itemInstance = item.instantiate()
	itemInstance.global_position = itemPosition
	add_child(itemInstance)
	print("spawning item at: ")
	print(itemPosition)
