extends Node

var ITEM_RESOURCES_PATH = "res://stats/items/"
var CHARACTER_RESOURCES_PATH = "res://stats/characters/"
var item_types = {}
var character_types = {}

func _ready():
  for filename in DirAccess.get_files_at(ITEM_RESOURCES_PATH):
    var item_type = load(ITEM_RESOURCES_PATH + filename)
    item_types[item_type.id] = item_type
    
  for filename in DirAccess.get_files_at(CHARACTER_RESOURCES_PATH):
    var character_type = load(CHARACTER_RESOURCES_PATH + filename)
    character_types[character_type.id] = character_type
    
    

func get_item_type(item_id):
  assert(item_types[item_id], "Unknown item type %s" % item_id)
  return item_types[item_id]

func get_character_type(character_type_id):
  assert(character_types[character_type_id], "Unknown character type %s" % character_type_id)
  return character_types[character_type_id]
