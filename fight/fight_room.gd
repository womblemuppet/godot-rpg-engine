extends Node

@onready var current_fighter_label = $"CurrentFighterLabel"
@onready var movelist_menu = $MovelistMenu
@onready var target_menu = $"TargetMenu"

var fight
var move_chosen
var target_chosen

func _ready():
  movelist_menu.move_chosen.connect(on_move_chosen)
  target_menu.target_chosen.connect(on_target_chosen)

func set_current_fighter(fighter):
  current_fighter_label.text = fighter.display_name

func show_movelist_menu_for_fighter(fighter):
  movelist_menu.enable()
  movelist_menu.load_movelist(fighter.movelist)

func on_move_chosen(move: MoveType):
  movelist_menu.disable()
  
  var targets = fight.get_targets(move) # This is two-way binding now!?
  target_menu.enable()
  target_menu.load_targets(targets)

  move_chosen = move

func on_target_chosen(target):
  target_chosen = target
  
  fight.receive_move_details({
    "move": move_chosen,
    "target": target_chosen
  })
  
  move_chosen = null
  target_chosen = null

  target_menu.disable()
