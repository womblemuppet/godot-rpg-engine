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

var inventory = [[]] # placeholder, should use class


func hold_weapon(item: Item, item_slot: WeaponSlot):
  held_weapons[item_slot] = item
