extends Button

@onready var texture_rect = $TextureRect
var item: Item


func init(p_item):
  item = p_item
  text = item.type.name
  texture_rect.texture = item.type.inventory_sprite
