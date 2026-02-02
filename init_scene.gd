extends Node

func _ready():
  SaveManager.load_game()
  SceneManager.go_to_overworld_room()
