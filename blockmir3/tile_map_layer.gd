extends TileMapLayer

func _ready():
	print("aa")
	var file: = FileAccess.open("res://data/aa.json", FileAccess.READ)
	if file == null:
		push_error("❌ 无法打开 JSON 文件 (res://map.json)")
		return
	
	var raw_text := file.get_as_text()
	file.close()

	# 如果 JSON 外层带引号（像你的文件），去掉并替换转义符
	if raw_text.begins_with('"') and raw_text.ends_with('"'):
		raw_text = raw_text.substr(1, raw_text.length() - 2)
		raw_text = raw_text.replace('\\"', '"')
	print("bb")
	# 解析 JSON
	var data = JSON.parse_string(raw_text)
	var second_parse = JSON.parse_string(data)
	print(typeof(second_parse))
	data = 	second_parse
	if typeof(data) != TYPE_DICTIONARY:
		push_error("❌ JSON 解析失败")
		return
	var grid: Array = data["data"]
	var rows: int = data["gh"]
	var cols: int = data["gl"]

	print("✅ JSON 加载成功, 行:", rows, " 列:", cols)
	print("cc")
	# 遍历格子
	for y in range(rows):
		for x in range(cols):
			draw_rect(Rect2(x*48, y*32, 48, 32), Color(1,0,0,0.2))
			var tile_id: int = grid[y][x]
			if tile_id != 0: # 0 表示空格子
				# 注意 TileSet ID 从 0 开始，JSON 里的数字可能从 1 开始
				var final_id := tile_id - 1
				set_cell(Vector2i(x, y), final_id)
				# 调试打印
				print("格子位置:", Vector2i(x, y), " JSON tile_id:", tile_id, " -> TileSet ID:", final_id)

	print("✅ 地图绘制完成！")
