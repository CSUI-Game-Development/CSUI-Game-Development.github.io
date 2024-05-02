extends Node2D

onready var enemy = preload("res://Scenes/Enemy.tscn")

export (float) var spawn_rate = 0.3

var current_time = 0

func _ready():
	current_time = spawn_rate

func _process(delta):
	current_time -= delta
	if current_time <= 0:
		current_time = spawn_rate
		
		var new_enemy = enemy.instance()
		add_child(new_enemy)
