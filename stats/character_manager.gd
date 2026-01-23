extends Node

var characters = []
  
func create_character(character_data):
  var new_character = Character.new()
  new_character.init(character_data)
  
  characters.push_back(new_character)
  

    
    
