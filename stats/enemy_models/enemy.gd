class_name Enemy
extends Node

@onready var fighter_scene = preload("uid://0wuliejp0ovh")

var type: EnemyType

func init(p_type: EnemyType):
  type = p_type

func to_fighter():
  var new_fighter = fighter_scene.instantiate()
  
  new_fighter.init(
    {
      "display_name": type.display_name,
      "hp": type.hp,
      "attack": type.base_attack,
      "status": type.status,
      "movelist": type.movelist,
      "fight_sprites": type.fight_sprites,
    }
  )
  
  return new_fighter
