extends Node

@onready var area_2d = $Area2D


func _ready():
  area_2d.body_entered.connect(on_collision)
  
func on_collision(body):
  if body.name == "Player":
    heal_player()
    
func heal_player():
  for character: Character in CharacterManager.get_characters():
    character.hp = character.type.base_hp

  print("healed!")
