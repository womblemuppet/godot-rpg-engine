extends VBoxContainer

@onready var fight_room_button_scene = preload("uid://b3y2b0s3qf6jt")

var movelist_buttons = []

signal move_chosen(move)

func _ready():
  visible = false

func load_movelist(new_movelist):
  for movelist_button in movelist_buttons:
    movelist_button.queue_free()
  
  movelist_buttons = []
  
  for i in range(new_movelist.size()):
    var move: MoveType = new_movelist[i]
    var new_movelist_button = fight_room_button_scene.instantiate()
    movelist_buttons.push_back(new_movelist_button)
    add_child(new_movelist_button)
    new_movelist_button.text = move.name
    new_movelist_button.position.x += 200
    new_movelist_button.position.y += 200 + i * 200
    
    new_movelist_button.pressed.connect(func(): move_chosen.emit(move))
    
func enable():
  visible = true
  for movelist_button: Button in movelist_buttons:
    movelist_button.disabled = false

  
func disable():
  visible = false
  for movelist_button: Button in movelist_buttons:
    movelist_button.disabled = true
