extends Node

@onready var area_2d = $Area2D

func _ready():
  area_2d.body_entered.connect(on_collision)

func on_collision(body):
  if body.name == "Player":
    go_to_encounter()
    
func go_to_encounter():
  var new_fight = Fight.new()
  SceneManager.queue_children([new_fight])
  
  SceneManager.go_to_fight_room()
  
