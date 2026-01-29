extends Node

@onready var fight_room = $"../../FightRoom"
@onready var timer = $Timer  # WIP testing purposes

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
  timer.timeout.connect(on_phase_ended)
  
  for i in range(allies.size()):
    var ally = allies[i]
    add_child(ally)
    ally.position.x += 200
    ally.position.y += 200 + (i * 300)
    ally.fainted.connect(on_fainted)
    
  for i in range(enemies.size()):
    var enemy = enemies[i]
    add_child(enemy)
    enemy.position.x += 1800
    enemy.position.y += 200 + (i * 300)
    enemy.fainted.connect(on_fainted)
  
  repopulate_turn_queues()
  
  fight_room.fight = self
  
  queue_phase(PHASES.PRE_TURN)
  
func queue_phase(new_phase: PHASES):
  # wait for animations etc
  timer.start(0.5)
  phase = new_phase
  fight_room.set_current_phase_label(PHASES.keys()[phase])

func on_phase_ended():
  match phase:
    PHASES.PRE_TURN:
      phase_pre_turn()
    PHASES.SELECT_FIGHTER:
      phase_select_fighter()
    PHASES.PRE_MOVE:
      phase_pre_move()
    PHASES.MOVE:
      phase_move()
    PHASES.ACTION:
      phase_action()
    PHASES.POST_MOVE:
      phase_post_move()
    PHASES.POST_TURN:
      phase_post_turn()
  
func on_fainted(_fighter):
  remove_fainted_from_queues()
  
func remove_fainted_from_queues():
  allies_attacker_queue = filter_fainted(allies_attacker_queue)
  enemies_attacker_queue = filter_fainted(enemies_attacker_queue)

func filter_fainted(fighters):
  return fighters.filter(func(fighter): return (fighter.status != Character.Status.FAINTED))

func repopulate_turn_queues():
  allies_attacker_queue = filter_fainted(allies.duplicate())
  enemies_attacker_queue = filter_fainted(enemies.duplicate())

func phase_pre_turn():
  turn_count += 1
  is_allies_turn = true
  repopulate_turn_queues()
  
  if allies_attacker_queue.is_empty():
    print("loss!")
    return
  if enemies_attacker_queue.is_empty():
    print("win!")
    return
  
  queue_phase(PHASES.SELECT_FIGHTER)

func phase_select_fighter():
  var next_fighter
  
  if is_allies_turn:
    next_fighter = allies_attacker_queue.pop_front()
    if !next_fighter:
      is_allies_turn = false
  
  if !next_fighter && !is_allies_turn:
    next_fighter = enemies_attacker_queue.pop_front()
    if !next_fighter:
      queue_phase(PHASES.POST_TURN)
      return
  
  set_current_fighter(next_fighter)
  queue_phase(PHASES.PRE_MOVE)
  
func set_current_fighter(new_current_fighter):
  current_fighter = new_current_fighter
  fight_room.set_current_fighter(new_current_fighter)
  # use signals instead?!? what are we doing
  
func get_targets(_move_type):
  var list_of_targets
  if is_allies_turn:
    list_of_targets = filter_fainted(enemies)
  else:
    list_of_targets = filter_fainted(allies)
    
  return list_of_targets
  
func phase_pre_move():
  queue_phase(PHASES.MOVE)

func phase_move():
  if is_allies_turn:
    fight_room.show_movelist_menu_for_fighter(current_fighter)
  else:
    enemy_take_move()

func enemy_take_move():
  var move_type = current_fighter.movelist[0]
  var valid_targets = get_targets(move_type)
  var target = valid_targets.pick_random()
  
  move_details = {
    "move": move_type,
    "target": target
  }
  
  queue_phase(PHASES.ACTION)
 
func receive_move_details(p_move_details):
  move_details = p_move_details
  
  queue_phase(PHASES.ACTION)

func phase_action():
  var move_type: MoveType = move_details.move
  var target = move_details.target
  
  var script_node = move_type.effect.new()
  script_node.do_effect.call(current_fighter, target)
  script_node.queue_free()
  
  queue_phase(PHASES.POST_MOVE)
  
func phase_post_move():
  queue_phase(PHASES.SELECT_FIGHTER)

func phase_post_turn():
  queue_phase(PHASES.PRE_TURN)
