extends Node

var empty_slot_textures = {
  "main_weapon_empty_slot": preload("uid://c4rspb3sg4ho5"),
  "offhand_weapon_empty_slot": preload("uid://dyeeedxqbaw3w"),
  "top_armour_empty_slot": preload("uid://cb8gimce7bmah"),
  "bottom_armour_empty_slot": preload("uid://byr3h4054jh8l")
}

@onready var character_sprite = $CharacterSprite
@onready var main_weapon_slot = $MainWeaponSlot
@onready var offhand_weapon_slot = $OffhandWeaponSlot
@onready var top_armour_slot = $BottomArmourSlot
@onready var bottom_armour_slot = $TopAmourSlot
@onready var name_label = $NameLabel

func init(character: Character):
  character_sprite.texture = character.type.fight_sprites["idle"]
  name_label.text = character.type.display_name
  
  if character.get_main_weapon():
    main_weapon_slot.texture = character.get_main_weapon().type.inventory_sprite
  else:
    main_weapon_slot.texture = empty_slot_textures["main_weapon_empty_slot"]
  
  if character.get_offhand_weapon():
    offhand_weapon_slot.texture = character.get_offhand_weapon().type.inventory_sprite
  else:
    offhand_weapon_slot.texture = empty_slot_textures["offhand_weapon_empty_slot"]
    
  if character.get_top_armour():  
    top_armour_slot.texture = character.get_top_armour().type.inventory_sprite
  else:
    top_armour_slot.texture = empty_slot_textures["top_armour_empty_slot"]
    
  if character.get_bottom_armour():
    bottom_armour_slot.texture = character.get_bottom_armour().type.inventory_sprite
  else:
    bottom_armour_slot.texture = empty_slot_textures["bottom_armour_empty_slot"]
