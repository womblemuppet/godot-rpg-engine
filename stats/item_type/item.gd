class_name Item

var type: ItemType

func init(item_data):
  var item_resource = ResourceManager.get_item_type(item_data.type)
  type = item_resource.type

func to_dictionary():
  var dictionary = {
    "type": type.id
  }
  return dictionary
