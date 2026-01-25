class_name EnemyType
extends Resource

var status = Character.Status.ALIVE

@export var display_name: String
@export var hp: int
@export var base_attack: int
@export var movelist: Array[MoveType] = []
@export var fight_sprites: Dictionary
