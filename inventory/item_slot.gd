class_name ItemSlot
extends TextureRect

signal pressed(item_slot)

@onready var item_slot_button = $ItemSlotButton

var empty_texture: Texture2D
var is_weapon: bool
var is_armour: bool
var character: Character
var weapon_slot
var armour_slot
var item: Item = null
var equip: Callable
var unequip: Callable

func _ready():
  item_slot_button.pressed.connect(on_button_pressed)

func init(p_position, p_character, p_empty_texture, p_weapon_slot, p_armour_slot):
  position = p_position
  character = p_character
  empty_texture = p_empty_texture
  texture = empty_texture
  
  is_weapon = p_weapon_slot != null
  is_armour = p_armour_slot != null
  
  weapon_slot = p_weapon_slot
  armour_slot = p_armour_slot
  
  if is_weapon:
    equip = func(p_item):
      character.hold_weapon(p_item, weapon_slot)
      set_item(p_item)
    unequip = func():
      character.remove_weapon(weapon_slot)
      clear()
      
  else:
    equip = func(p_item):
      character.hold_armour(p_item, armour_slot)
      set_item(p_item)
    unequip = func():
      character.remove_armour(armour_slot)
      clear()
    
func set_item(p_item: Item):
  item = p_item
  texture = item.type.inventory_sprite

func clear():
  item = null
  texture = empty_texture

func on_button_pressed():
  pressed.emit(self)
