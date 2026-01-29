extends VBoxContainer

@onready var fight_room_button_scene = preload("uid://b3y2b0s3qf6jt")

var target_buttons = []

signal target_chosen(target)

func _ready():
  visible = false

func enable():
  visible = true
  
func disable():
  visible = false

func load_targets(targets):
  for target_button in target_buttons:
    target_button.queue_free()
    
  target_buttons = []
    
  for i in range(targets.size()):
    var target = targets[i]
    var new_target_button = fight_room_button_scene.instantiate()
    target_buttons.push_back(new_target_button)
    add_child(new_target_button)
    new_target_button.text = target.display_name
    new_target_button.position.x += 200
    new_target_button.position.y += 200 + i * 200
    
    new_target_button.pressed.connect(func(): target_chosen.emit(target))
    
