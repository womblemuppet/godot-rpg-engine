class_name Item

var type: ItemType
var freshness: int

func init(item_data):
  type = ResourceManager.get_item_type(item_data.type)
  freshness = 5

func to_dictionary():
  var dictionary = {
    "type": type.id,
    "freshness": freshness
  }
  return dictionary
