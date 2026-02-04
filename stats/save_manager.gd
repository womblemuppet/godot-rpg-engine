extends Node


var save_path = "user://savegame.save"
var player

func _input(event):
  if Input.is_action_pressed("Load Game"):
    SaveManager.load_game()
  if Input.is_action_pressed("Save Game"):
    SaveManager.save_game()
  
func register_player(p_player):
  player = p_player

func save_game():
  print("saving game!")
  
  var save_file = FileAccess.open(save_path, FileAccess.WRITE)
  
  var combine_characters_into_dictionary = func(acc, character: Character):
    var character_key = "Character" + str(character.type.id)
    acc[character_key] = character.to_dictionary()
    
    return acc
    
  var character_data = CharacterManager.characters.reduce(
    combine_characters_into_dictionary,
    {}
  )
  
  var player_data = {
    "x": player.position.x,
    "y": player.position.y,
  }
  
  var other_data = {
    "Inventory": InventoryManager.get_inventory(),
    "Player": player_data
  }
  
  var data_to_save = character_data.merged(other_data)
  var yaml = YAML.dump(data_to_save)
  save_file.store_line(yaml)

func load_game():
  print("loading game!")
  
  var save_file = FileAccess.open(save_path, FileAccess.READ)
  var loaded_data: Dictionary = YAML.load(save_file.get_as_text())
  assert(loaded_data != null, "Failed to load save file")
  
  var character_keys = loaded_data.keys().filter(func(key): return ("Character" in key))
  
  for key in character_keys:
    var character_data = loaded_data[key]
    var character_type_id = int(key.lstrip("Character"))
    var character_type = ResourceManager.get_character_type(character_type_id)
    character_data["type"] = character_type
    
    CharacterManager.create_character(character_data)

  if loaded_data.has("Inventory"):
    var inventory_data: Array = loaded_data["Inventory"]
    InventoryManager.set_inventory_data(inventory_data)
  
  if loaded_data.has("Player"):
    var player_data = loaded_data["Player"]
    
    SceneManager.set_player_spawn_position(Vector2(player_data.x, player_data.y))
