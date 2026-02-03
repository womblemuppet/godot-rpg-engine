extends Node


var inventory_page
var inventory = []


func _input(_event):
  if Input.is_action_pressed("Toggle Inventory"):
    if inventory_page.visible:
      hide_inventory()
    else:
      show_inventory()

func set_inventory_page(p_inventory_page):
  inventory_page = p_inventory_page

func get_inventory():
  return inventory

func load_inventory(inventory_data: Array):
  inventory = inventory_data

func show_inventory():
  inventory_page.visible = true
  
func hide_inventory():
  inventory_page.visible = false
