extends Node2D

@onready var enemySpawner = $EnemySpawner
@onready var player = $Player
@onready var itemSpawner = $ItemSpawner
@onready var enemy = preload("res://scenes/slime.tscn")
@onready var item = preload("res://scenes/item.tscn")
@onready var levelUpGui = $LevelUpGui

var MIN_RANGE: int = 200
var MAX_RANGE: int = 400

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.PlayerLeveledUpSignal.connect(handlePlayerLeveledUp)
	levelUpGui.hide()
	levelUpGui.optionSelectedSignal.connect(handleLevelUpOptionSelected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawnEnemy():
	var spawnRange: int = 20
	var enemyPos: Vector2 = Vector2(randf_range(spawnRange * -1,spawnRange), randf_range(spawnRange * -1,spawnRange))
	var enemyDistance: float = randf_range(MIN_RANGE, MAX_RANGE)
	enemyPos = enemyPos.normalized()
	enemyPos *= enemyDistance
	var enemyInstance = enemy.instantiate()
	enemyInstance.global_position = player.position + enemyPos
	enemySpawner.add_child(enemyInstance)
	enemyInstance.spawnItemSignal.connect(spawnItem)
	enemyInstance.itemDropChance = 2


func _on_spawn_timer_timeout():
	spawnEnemy()

func spawnItem(itemPosition: Vector2):
	var itemInstance = item.instantiate()
	itemInstance.global_position = itemPosition
	itemSpawner.add_child(itemInstance)

func handlePlayerLeveledUp():
	get_tree().paused = true
	levelUpGui.show()
	levelUpGui.button1.text = "Option 1: text here"
	levelUpGui.button2.text = "Option 2: text here"
	levelUpGui.button3.text = "Option 3: text here"

func handleLevelUpOptionSelected(index: int):
	get_tree().paused = false
	levelUpGui.hide()
