extends Node

var bag_item_buttons = []

func set_bag_items(new_bag_items: Array):
  for bag_item_button in bag_item_buttons:
    bag_item_button.queue_free()
    
  for i in range(new_bag_items.size()):
    var item = new_bag_items[i]
    var new_button = Button.new()
    add_child(new_button)
    
    new_button.text = item.type.name
    new_button.size = Vector2(400, 100)
    new_button.position.x += 50
    new_button.position.y += 100 + i * 120
    new_button.pressed.connect(on_bag_item_pressed.bind(new_button))
    
func on_bag_item_pressed(button):
  print("on_bag_item_pressed %s" % button)
