class_name Character
extends Node

var type: CharacterType

var hp: int
enum Status { ALIVE, FAINTED }
var status: Status

var insp: int
var fren: int
var comf: int
var conf: int
var hung: int

enum ArmourSlot { ARMOUR_TOP, ARMOUR_BOTTOM }
var held_armour: Dictionary[ArmourSlot, Item]

enum WeaponSlot { WEAPON_MAIN, WEAPON_OFFHAND }
var held_weapons: Dictionary[WeaponSlot, Item]

func init(character_data):
  hp = character_data.hp
  status = character_data.status
  insp = character_data.insp
  fren = character_data.fren
  comf = character_data.comf
  conf = character_data.conf
  hung = character_data.hung
  
  for armour_slot in character_data.held_armour:
    var armour = character_data.held_armour[armour_slot] # this will error?
    if armour:
      var new_armour = Item.new()
      new_armour.init(armour)
      hold_armour(new_armour, armour_slot)
    
      
  #held_weapons = character_data.head_weapons

func to_dictionary():
  var held_armour_dict = {}
  
  for armour_slot in held_armour:
    var held_armour_in_slot = held_armour[armour_slot]
    if held_armour_in_slot:
      held_armour_dict[armour_slot] = held_armour_in_slot.to_dictionary()
    else:
      held_armour_dict[armour_slot] = null
      
  var held_weapon_dict = {}  
    
  for weapon_slot in held_weapons:
    var held_weapon_in_slot = held_weapons[weapon_slot]
    if held_weapon_in_slot:
      held_weapon_dict[weapon_slot] = held_weapon_in_slot.to_dictionary()
    else:
      held_weapon_dict[weapon_slot] = null
  
  var dictionary = {
    "hp": hp,
    "status": status,
    "insp": insp,
    "fren": fren,
    "comf": comf,
    "conf": conf,
    "hung": hung,
    "held_armour": held_armour_dict,
    "held_weapons": held_weapon_dict,
  }
  
  return dictionary

func hold_armour(item: Item, item_slot: ArmourSlot):
  held_armour[item_slot] = item

func hold_weapon(item: Item, item_slot: WeaponSlot):
  held_weapons[item_slot] = item
