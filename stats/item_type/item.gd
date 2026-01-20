class_name Item

var type: ItemType

func to_dictionary():
  var dictionary = {
    "type": type.id
  }
  return dictionary
