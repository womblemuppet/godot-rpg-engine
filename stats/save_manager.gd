extends Node

var save_path = "user://savegame.save"

func _ready():
  #print("saving game!@")
  #save_game()
  print("loading game!")
  load_game()

func save_game():
  var save_file = FileAccess.open(save_path, FileAccess.WRITE)
  
  var combine_characters_into_dictionary = func(acc, character):
    acc[character.type.id] = character.to_dictionary()
    return acc
    
  var character_dictionary = CharacterManager.characters.reduce(
    combine_characters_into_dictionary,
    {}
  )
  
  var yaml = YAML.dump(character_dictionary)
  save_file.store_line(yaml)

func load_game():
  var save_file = FileAccess.open(save_path, FileAccess.READ)
  var loaded_data = YAML.load(save_file.get_as_text())
  assert(loaded_data != null, "Failed to load save file")
  
  for key in loaded_data:
    # key atm is just each character id
    CharacterManager.create_character(loaded_data[key])
      
  print("loading finished")
  print("characters:")
  print(CharacterManager.characters)
