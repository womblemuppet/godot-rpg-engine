extends CharacterBody2D
  
var is_moving = false
var direction = Vector2(0, 0)
var GRID_SIZE = 120

func _process(_delta):
  if !is_moving:
    var hdir = 0
    var vdir = 0  
    
    if Input.is_action_pressed("ui_left"):
      hdir = -1
    elif Input.is_action_pressed("ui_right"):
      hdir = 1
    
    if Input.is_action_pressed("ui_up"):
      vdir = -1
    elif Input.is_action_pressed("ui_down"):
      vdir = 1

    direction = Vector2(hdir, vdir)
    if direction != Vector2(0, 0):
      if !move_and_collide(direction * GRID_SIZE, true):
        move()

func move():
  is_moving = true
  
  var tween = create_tween()
  tween.tween_property(self, "position", position + (direction * GRID_SIZE), 0.05)
  tween.tween_callback(func(): is_moving = false)
