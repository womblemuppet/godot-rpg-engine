class_name Fight
extends Node

var turn_count: int = 0
var allies: Array
var enemies: Array

func init(p_allies, p_enemies):
  allies = p_allies
  enemies = p_enemies

func _ready():
  for i in range(allies.size()):
    var character: Character = allies[i]
    print("making ally %s" % character)
    
    var new_ally_fighter = character.to_fighter()
    add_child(new_ally_fighter)
    new_ally_fighter.position.x += 200
    new_ally_fighter.position.y += 200 + (i * 200)
    
  for i in range(enemies.size()):
    var enemy: Enemy = enemies[i]
    print("making enemy %s" % enemy)
    var new_enemy_fighter = enemy.to_fighter()
    add_child(new_enemy_fighter)
    new_enemy_fighter.position.x += 1200
    new_enemy_fighter.position.y += 200 + (i * 200)
    
