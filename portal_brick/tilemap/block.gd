extends TileMap


# delete_block(position : Vector2) -> void:
#	Change the current block with an empty block
# 	param: block's collision position with the ball. 
func delete_block( pos : Vector2 ) -> void:
	print("A eliminar en: ", pos)
	set_cellv( pos, -1);


func _on_RigidBody2D_brick_found(pos):
	var tile_pos : Vector2 = world_to_map(pos)
	print("Tocaron el tile:", get_cellv(tile_pos));
	set_cellv(tile_pos, 2);
	pass # Replace with function body.
