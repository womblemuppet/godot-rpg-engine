class_name Fight
extends Node

@onready var fight_room = $"../../FightRoom"

var turn_count: int = 0
var is_allies_turn: bool = true

enum PHASES { PRE_TURN, SELECT_FIGHTER, PRE_MOVE, MOVE, ACTION, POST_MOVE, POST_TURN }
var phase: PHASES

var allies: Array
var enemies: Array
var allies_attacker_queue: Array
var enemies_attacker_queue: Array

var current_fighter = null
var move_details = {
  "move": null,
  "target": null
}

func init(p_allies, p_enemies):
  allies = p_allies.map(func(character): return character.to_fighter())
  enemies = p_enemies.map(func(character): return character.to_fighter())

func _ready():
  for i in range(allies.size()):
    var ally = allies[i]
    add_child(ally)
    ally.position.x += 200
    ally.position.y += 200 + (i * 300)
    
  for i in range(enemies.size()):
    var enemy = enemies[i]
    add_child(enemy)
    enemy.position.x += 1800
    enemy.position.y += 200 + (i * 300)
  
  allies_attacker_queue = allies.duplicate()
  enemies_attacker_queue = enemies.duplicate()
  
  phase_pre_turn()
  fight_room.fight = self

func phase_pre_turn():
  phase = PHASES.PRE_TURN
  turn_count += 1
  phase_select_fighter()

func phase_select_fighter():
  phase = PHASES.SELECT_FIGHTER
  
  var next_fighter
  
  if is_allies_turn:
    next_fighter = allies_attacker_queue.pop_front()
    if !next_fighter:
      is_allies_turn = false
  
  if !next_fighter && !is_allies_turn:
    next_fighter = enemies_attacker_queue.pop_front()
    if !next_fighter:
      phase_post_turn()
  
  set_current_fighter(next_fighter)
  phase_move()
  
func set_current_fighter(new_current_fighter):
  current_fighter = new_current_fighter
  fight_room.set_current_fighter(new_current_fighter)
  # use signals instead?!? what are we doing
  
func get_targets(_move_type):
  var list_of_targets
  if is_allies_turn:
    list_of_targets = enemies
  else:
    list_of_targets = allies
    
  return list_of_targets

func phase_move():
  phase = PHASES.MOVE
  fight_room.show_movelist_menu_for_fighter(current_fighter)

func set_move_details(p_move_details):
  move_details = p_move_details
  
  phase_action()

func phase_action():
  phase = PHASES.ACTION
  var move_type: MoveType = move_details.move
  var target = move_details.target
  
  var script_node = move_type.effect.new()
  script_node.do_effect.call(current_fighter, target)
  script_node.queue_free()
  
  phase_post_turn()

func phase_post_turn():
  phase = PHASES.POST_TURN
  phase_pre_turn()
