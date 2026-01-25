extends Node

var ITEM_RESOURCES_PATH = "res://stats/items/"
var CHARACTER_RESOURCES_PATH = "res://stats/characters/"
var MOVES_RESOURCES_PATH = "res://stats/moves/"
var item_types = {}
var character_types = {}
var move_types = {}

func _ready():
  for filename in DirAccess.get_files_at(ITEM_RESOURCES_PATH):
    var item_type = load(ITEM_RESOURCES_PATH + filename)
    item_types[item_type.id] = item_type
    
  for filename in DirAccess.get_files_at(CHARACTER_RESOURCES_PATH):
    var character_type = load(CHARACTER_RESOURCES_PATH + filename)
    character_types[character_type.id] = character_type

  for filename in DirAccess.get_files_at(MOVES_RESOURCES_PATH):
    if ".tres" not in filename:
      continue
      
    var move_type = load(MOVES_RESOURCES_PATH + filename)
    move_types[move_type.id] = move_type    
    
func get_item_type(item_id: int):
  assert(item_types[item_id], "Unknown item type %s" % item_id)
  return item_types[item_id]

func get_character_type(character_type_id: int):
  assert(character_types[character_type_id], "Unknown character type %s" % character_type_id)
  return character_types[character_type_id]

func get_move_type(move_type_id: int):
  assert(move_types[move_type_id], "Unknown move type %s" % move_type_id)
  return move_types[move_type_id]
