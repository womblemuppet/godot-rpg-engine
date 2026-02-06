extends Node

var character_display_scene = preload("uid://cb0c4iqvfckww")

@onready var bag = $Bag
@onready var character_displays = {}

var selected_bag_item


func _ready():
  create_character_displays_per_character()
  bag.bag_item_pressed.connect(on_bag_item_pressed)

func create_character_displays_per_character():
  var characters = CharacterManager.get_characters()
  for i in range(characters.size()):
    var character = characters[i]
    var new_character_display = character_display_scene.instantiate()
    add_child(new_character_display)
    new_character_display.position.x = 200 + (i % 2) * 600
    new_character_display.position.y = 200 + ((i / 2) % 2) * 600
    
    new_character_display.init(character)
    character_displays[character.type.id] = new_character_display
    new_character_display.item_slot_pressed.connect(on_character_item_slot_pressed)

func set_bag_items(new_bag_items: Array):
  bag.set_bag_items(new_bag_items)
  
func set_selected_bag_item(bag_item):
  selected_bag_item = bag_item
  
func clear_selected_bag_item():
  selected_bag_item = null

func on_bag_item_pressed(bag_item):
  set_selected_bag_item(bag_item)

func on_character_item_slot_pressed(item_slot, character):
  if selected_bag_item:
    var item: Item = selected_bag_item.item
    item_slot.equip.call(item)
    clear_selected_bag_item()
    InventoryManager.remove_bag_item(item)
  else:
    var item = item_slot.item
    item_slot.unequip.call()
    InventoryManager.add_bag_item(item)
