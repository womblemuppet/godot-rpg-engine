extends Node

var characters = []
  
func _ready():
  pass
  #var character_one = Character.new()
  #character_one.type = preload("uid://cnl1t1k742ecs")
  #var big_sword = Item.new()
  #big_sword.type = preload("uid://b0kac0nen75m2")
  #character_one.hold_weapon(big_sword, Character.WeaponSlot.WEAPON_MAIN)
  #characters.push_front(character_one)
  #
  #var character_two = Character.new()
  #character_two.type = preload("uid://rge0yx73wo4")
  #characters.push_front(character_two)

func create_character(character_data):
  var new_character = Character.new()
  new_character.init(character_data)
  
  characters.push_back(new_character)
  

    
    
