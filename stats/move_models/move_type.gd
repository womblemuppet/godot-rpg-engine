class_name MoveType
extends Resource

@export var id: int
@export var name: String

enum TargetType { Enemy, AllEnemies, Allies, AllAllies }
@export var target_type: TargetType

@export var effect: GDScript
