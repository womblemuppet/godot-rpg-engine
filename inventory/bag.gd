extends Node

var bag_item_scene = preload("uid://ofaj42rgxp0v")

var bag_item_buttons = []

func set_bag_items(new_bag_items: Array):
  for bag_item in bag_item_buttons:
    bag_item.queue_free()
    
  for i in range(new_bag_items.size()):
    var item = new_bag_items[i]
    var new_bag_item = bag_item_scene.instantiate()
    add_child(new_bag_item)
    
    new_bag_item.init(item)
    new_bag_item.position.x += 50
    new_bag_item.position.y += 100 + i * 120

    new_bag_item.pressed.connect(on_bag_item_pressed.bind(new_bag_item))
    
func on_bag_item_pressed(button):
  print("on_bag_item_pressed %s" % button)
