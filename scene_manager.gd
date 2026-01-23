extends Node

var scene: Node
var children_queue: Array

@onready var overworld_room_scene = preload("uid://d0pgxsyty26ig")
@onready var fight_room_scene = preload("uid://wcdwceorq67r")
  
func _ready():
  scene = get_tree().current_scene
  
func change_scene(new_scene):
  if scene:
    scene.queue_free()
    
  var created_scene = new_scene.instantiate()
  
  scene = created_scene
  add_child(created_scene)
  
  for child in children_queue:
    created_scene.add_child(child)
  
  clear_children_queue()
  
  return created_scene

func queue_children(new_children: Array):
  children_queue.append_array(new_children)
  
func clear_children_queue():
  children_queue = []

func go_to_overworld_room():
  change_scene(overworld_room_scene)

func go_to_fight_room():
  change_scene(fight_room_scene)
