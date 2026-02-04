extends Node

var character_display_scene = preload("uid://cb0c4iqvfckww")

@onready var bag = $Bag
@onready var character_displays = {}


func _ready():
  create_character_displays_per_character()

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

func set_bag_items(new_bag_items: Array):
  bag.set_bag_items(new_bag_items)
