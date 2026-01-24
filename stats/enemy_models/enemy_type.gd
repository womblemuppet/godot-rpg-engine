class_name EnemyType
extends Resource

var status = Character.Status.ALIVE

@export var hp: int
@export var movelist: Array[MoveType] = []
@export var fight_sprites: Dictionary
