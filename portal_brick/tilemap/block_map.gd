extends TileMap
#In order to use this block map object you have to connect 
#the ball node to it.

#_on_brick_found(pos : Vector2)
#	Deletes the tile in position "pos". This function is the handler 
#	for "brick_found" signal in the ball.
#	param:
#		pos: Contact point between thhe ball and some tile
#		in this tilemap

func _on_Ball_brick_found(pos):
	print("banggg")
	var tile_pos : Vector2 = world_to_map(pos)
	set_cellv(tile_pos, -1);
