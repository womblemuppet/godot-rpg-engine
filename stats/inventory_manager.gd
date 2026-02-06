extends Node


var inventory_page
var bag_items = []


func _input(_event):
  if Input.is_action_pressed("Toggle Inventory"):
    if inventory_page.visible:
      hide_inventory()
    else:
      show_inventory()

func set_inventory_page(p_inventory_page):
  inventory_page = p_inventory_page

func set_inventory_data(inventory_data):
  bag_items = inventory_data
  
func load_inventory():
  inventory_page.set_bag_items(bag_items)

func get_bag_items():
  return bag_items

func add_bag_item(new_item):
  bag_items.push_back(new_item)
  inventory_page.set_bag_items(bag_items)
  
func remove_bag_item(item):
  var index = bag_items.find(item)
  if index > -1:
    bag_items.remove_at(index)
  inventory_page.set_bag_items(bag_items)
  
func show_inventory():
  inventory_page.visible = true
  
func hide_inventory():
  inventory_page.visible = false
