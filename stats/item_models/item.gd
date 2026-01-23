class_name Item

var type: ItemType

func init(item_data):
  type = ResourceManager.get_item_type(item_data.type)

func to_dictionary():
  var dictionary = {
    "type": type.id
  }
  return dictionary
