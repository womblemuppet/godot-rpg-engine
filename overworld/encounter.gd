extends Node

@onready var area_2d = $Area2D
@onready var fight_scene = preload("uid://d2beb6vhden60")

func _ready():
  area_2d.body_entered.connect(on_collision)

func on_collision(body):
  if body.name == "Player":
    go_to_encounter()
    
func go_to_encounter():
  var new_fight = fight_scene.instantiate()
  
  var allies = CharacterManager.get_characters()
  
  var small_boar_enemy_resource = preload("uid://02qost67u7ml")
  var small_boar_enemy = Enemy.new()
  small_boar_enemy.init(small_boar_enemy_resource)
  var enemies = [small_boar_enemy]
  
  new_fight.init(allies, enemies)
  
  SceneManager.queue_children([new_fight])
  
  SceneManager.go_to_fight_room()
  
