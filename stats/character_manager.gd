extends Node

var characters = []
var character_dict = {}
  
func create_character(character_data):
  var new_character = Character.new()
  new_character.init(character_data)
  
  characters.push_back(new_character)
  character_dict[new_character.type.id] = new_character
  
func get_characters():
  return characters
    
func set_character_hp(character_id, new_hp):
  character_dict[character_id].hp = new_hp
