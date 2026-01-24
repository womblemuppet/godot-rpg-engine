class_name Character
extends Node

@onready var fighter_scene = preload("uid://0wuliejp0ovh")

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

var movelist: Array[MoveType] = []

func init(character_data):
  type = character_data.type
  hp = character_data.hp
  status = character_data.status
  insp = character_data.insp
  fren = character_data.fren
  comf = character_data.comf
  conf = character_data.conf
  hung = character_data.hung
  
  for armour_slot: ArmourSlot in character_data.held_armour:
    var armour = character_data.held_armour[armour_slot]
    if armour:
      var new_armour = Item.new()
      new_armour.init(armour)
      hold_armour(new_armour, armour_slot)

  for weapon_slot: WeaponSlot in character_data.held_weapons:
    var weapon = character_data.held_weapons[weapon_slot]
    if weapon:
      var new_weapon = Item.new()
      new_weapon.init(weapon)
      hold_weapon(new_weapon, weapon_slot)
      
  for move_type: MoveType in character_data.movelist:
    movelist.push_front(move_type)
      
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
    "type": type,
    "hp": hp,
    "status": status,
    "insp": insp,
    "fren": fren,
    "comf": comf,
    "conf": conf,
    "hung": hung,
    "held_armour": held_armour_dict,
    "held_weapons": held_weapon_dict,
    "movelist": movelist
  }
  
  return dictionary

func to_fighter():
  var new_fighter = fighter_scene.instantiate()
  
  new_fighter.init(
    {
      "display_name": type.display_name,
      "hp": hp,
      "attack": type.base_attack,
      "status": status,
      "movelist": movelist,
      "fight_sprites": type.fight_sprites,
    }
  )
  
  return new_fighter

func hold_armour(item: Item, item_slot: ArmourSlot):
  held_armour[item_slot] = item

func hold_weapon(item: Item, item_slot: WeaponSlot):
  held_weapons[item_slot] = item
