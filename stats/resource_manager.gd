extends Node

var ITEM_RESOURCES_PATH = "res://stats/items/"
var item_types = {}

func _ready():
  for filename in DirAccess.get_files_at(ITEM_RESOURCES_PATH):
    var item_type = load(ITEM_RESOURCES_PATH + filename)
    item_types[item_type.id] = item_type

func get_item_type(item_id):
  assert(item_types[item_id], "Unknown item type %s" % item_id)
  return item_types[item_id]
