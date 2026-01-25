extends Node2D


var display_name: String
var hp: int
var status: Character.Status
var movelist: Array[MoveType]

var fight_sprites: Dictionary


func init(fighter_data):
  var sprite_2d = $Sprite2D
  
  display_name = fighter_data.display_name
  hp = fighter_data.hp
  status = fighter_data.status
  movelist = fighter_data.movelist
  fight_sprites = fighter_data.fight_sprites
  if fight_sprites.has("idle"):
    sprite_2d.texture = fight_sprites["idle"]
