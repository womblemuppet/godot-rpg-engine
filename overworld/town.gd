extends Node

func on_collision(body):
  if body.name == "Player":
    heal_player()
    
func heal_player():
  for character: Character in CharacterManager.get_characters():
    character.hp = character.type.base_hp
