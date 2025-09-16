extends TileMapLayer

func _ready():
	var json_file = FileAccess.open("res://data/aa.json", FileAccess.READ)
	var data = JSON.parse_string(json_file.get_as_text())
	print(data)
	json_file.close()

	if typeof(data) != TYPE_DICTIONARY:
		push_error("JSON 解析失败")
		return

	var grid = data["data"]
	var rows = data["gh"]
	var cols = data["gl"]

	for y in range(rows):
		for x in range(cols):
			var tile_id = grid[y][x]
			if tile_id != 0: # 0 表示空，不放 Tile
				# TileMapLayer 用 (coords, source_id, atlas_coords, alternative_tile)
				set_cell(Vector2i(x, y), 0, Vector2i(tile_id, 0))
