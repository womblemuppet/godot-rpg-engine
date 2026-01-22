extends Node

var scene = null
@onready var overworld_scene = preload("uid://d0pgxsyty26ig")
  
func change_scene(new_scene):
  if scene:
    scene.queue_free()
    
  var created_scene = new_scene.instantiate()
  
  scene = created_scene
  add_child(created_scene)

func go_to_overworld():
  change_scene(overworld_scene)
