extends Node

var characters = []
  
func _ready():
  var character_one = Character.new()
  character_one.type = preload("uid://cnl1t1k742ecs")
  var big_sword = Item.new()
  big_sword.type = preload("uid://b0kac0nen75m2")
  character_one.hold_weapon(big_sword, Character.WeaponSlot.WEAPON_MAIN)
  characters.push_front(character_one)
  
  var character_two = Character.new()
  character_two.type = preload("uid://rge0yx73wo4")
  characters.push_front(character_two)
  save()
  
func save():
  var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
  
  for character in characters:
    var json = JSON.stringify(character.to_dictionary())
    save_file.store_line(json)
    
    
