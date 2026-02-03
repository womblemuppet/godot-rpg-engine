extends Node2D

@onready var health_label = $HealthLabel
@onready var name_label = $NameLabel
@onready var sprite_2d = $Sprite2D

signal fainted(fighter)

var display_name: String
var hp: int
var attack: int
var status: Character.Status
var movelist: Array[MoveType]

var fight_sprites: Dictionary


func init(fighter_data):
  sprite_2d = $Sprite2D
  health_label = $HealthLabel
  name_label = $NameLabel ## shouldn't do this should use callback init()
  
  display_name = fighter_data.display_name
  hp = fighter_data.hp
  attack = fighter_data.attack
  status = fighter_data.status
  movelist = fighter_data.movelist
  fight_sprites = fighter_data.fight_sprites
  
  if fight_sprites.has("idle"):
    sprite_2d.texture = fight_sprites["idle"]
    
  name_label.text = display_name
  update_hp(hp)

func take_damage(damage):
  update_hp(hp - damage)
    
func update_hp(new_hp):
  hp = new_hp
  health_label.text = str(hp)
  if hp <= 0:
    faint()
    
func faint():
  status = Character.Status.FAINTED
  fainted.emit(self)
