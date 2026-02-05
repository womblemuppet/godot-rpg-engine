extends ColorRect

var item_slot_scene = preload("uid://40fliknrc3ga")

@onready var character_sprite = $CharacterSprite

var character: Character

var main_weapon_slot: ItemSlot
var offhand_weapon_slot: ItemSlot
var top_armour_slot: ItemSlot
var bottom_armour_slot: ItemSlot
var item_slots = [
  main_weapon_slot,
  offhand_weapon_slot,
  top_armour_slot,
  bottom_armour_slot 
]

@onready var name_label = $NameLabel

var empty_slot_textures = {
  "main_weapon_empty_slot": preload("uid://c4rspb3sg4ho5"),
  "offhand_weapon_empty_slot": preload("uid://dyeeedxqbaw3w"),
  "top_armour_empty_slot": preload("uid://cb8gimce7bmah"),
  "bottom_armour_empty_slot": preload("uid://byr3h4054jh8l")
}

func init(p_character: Character):
  character = p_character
  
  character_sprite.texture = character.type.fight_sprites["idle"]
  name_label.text = character.type.display_name
  
  var item_slot_x = size.x + 10
  var item_slot_height = 160 # with gap
  
  main_weapon_slot = create_item_slot(
    Vector2(item_slot_x, 0),
    "main_weapon_empty_slot",
    Character.WeaponSlot.WEAPON_MAIN,
    null
  )
  
  offhand_weapon_slot = create_item_slot(
    Vector2(item_slot_x, item_slot_height),
    "offset_weapon_empty_slot",
    Character.WeaponSlot.WEAPON_OFFHAND,
    null
  )
  
  top_armour_slot = create_item_slot(
    Vector2(item_slot_x, item_slot_height * 2),
    "top_armour_empty_slot",
    null,
    Character.ArmourSlot.ARMOUR_TOP,
  )
  
  bottom_armour_slot = create_item_slot(
    Vector2(item_slot_x, item_slot_height * 3),
    "bottom_armour_empty_slot",
    null,
    Character.ArmourSlot.ARMOUR_BOTTOM,
  )
  
  update_item_slot_items()

func create_item_slot(p_position, empty_slot_texture_name, weapon_slot, armour_slot):
  var new_item_slot = item_slot_scene.instantiate()
  new_item_slot.init(
    p_position,
    empty_slot_textures["main_weapon_empty_slot"],
    weapon_slot,
    armour_slot
  )
  
  add_child(new_item_slot)
  new_item_slot.pressed.connect(on_item_slot_pressed)
  
  return new_item_slot

func update_item_slot_items():
  if character.get_main_weapon():
    main_weapon_slot.set_item(character.get_main_weapon())
  else:
    main_weapon_slot.clear()
  
  if character.get_offhand_weapon():
    offhand_weapon_slot.set_item(character.get_offhand_weapon())
  else:
    offhand_weapon_slot.clear()
    
  if character.get_top_armour():
    top_armour_slot.set_item(character.get_top_armour())
  else:
    top_armour_slot.clear()

  if character.get_bottom_armour():
    bottom_armour_slot.set_item(character.get_bottom_armour())
  else:
    bottom_armour_slot.clear()

func on_item_slot_pressed(item_slot):
  pass
  #item_slot.clear()
