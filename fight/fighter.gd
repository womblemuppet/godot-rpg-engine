class_name Fighter
extends Node

var hp: int
var status: Character.Status

func init_from_character(character):
  hp = character.hp
  status = character.status
