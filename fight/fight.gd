class_name Fight
extends Node

var turn_count: int = 0
var allies: Array
var enemies: Array

func init(p_allies, p_enemies):
  allies = p_allies
  enemies = p_enemies
