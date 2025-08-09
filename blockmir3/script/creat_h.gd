extends Node2D
@onready var check: Sprite2D = $newHero
@onready var hero_name: LineEdit = $newHero/heroName
@onready var zhanshi: Button = $newHero/zhanshi/zhanshi
@onready var fashi: Button = $newHero/fashi/fashi
@onready var daoshi: Button = $newHero/daoshi/daoshi
@onready var hero_ani: AnimatedSprite2D = $heroAni
@onready var sex: Sprite2D = $sex
@onready var submitS: Sprite2D = $submit
#var heroName= ""
var sex1 ="man"
var job = "zhanshi"
var attributes = {}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(typeof(attributes))
	
	check.visible = false
	hero_ani.visible = false
	 # Replace with function body.
	var file = FileAccess.open("res://data/legendary_attributes.json", FileAccess.READ)
	if file:
		var json_text = file.get_as_text()
		attributes = JSON.parse_string(json_text)
		if attributes:
			var level_10_warrior_hp = attributes["zhanshi"]["10"]["hp"]
			print("Warrior Lv10 HP:", level_10_warrior_hp)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func cheacS()->void:
	print("跳转到开门场景")
	get_tree().change_scene_to_file("res://Scen/zz.tscn")
	
	#get_tree().change_scene_to_file("res://enemy.tscn")
	
func creatHero()->void:
	hero_ani.play("zhanshi")
	if !check.visible:
		hero_ani.visible = true
		check.visible= true
		
	else:
		check.visible = false
	
		
func cheakZhanshi()->void:
	job = "zhanshi"
	if sex1 == "man":
		hero_ani.play("zhanshi")
	else:
		hero_ani.play("womanZhanshi")	
func cheakFashi()->void:
	job = "fashi"
	if sex1 == "man":
		hero_ani.play("fashi")
	else:
		hero_ani.play("womanFashi")
		
func cheakDaoshi()->void:
	job = "daoshi"
	if sex1 == "man":
		hero_ani.play("daoshi")
	else:
		hero_ani.play("womanDaoshi")
func generate_uuid() -> String:
	var uuid = ""
	var chars = "abcdef0123456789"
	var r = RandomNumberGenerator.new()
	r.randomize()
	for i in 32:
		uuid += chars[r.randi_range(0, chars.length() - 1)]
		if i in [7, 11, 15, 19]:
			uuid += "-"
	return uuid					

func submit()->void:		
	
	print("提交创建英雄")
	print(job)
	print(typeof(attributes))
	attributes[job]["1"]["level"] = 2
	attributes[job]["1"]["job"] = job
	attributes[job]["1"]["sex"] = sex1
	attributes[job]["1"]["name"] = hero_name.text

	var character_data:Dictionary = attributes[job]["1"]
	var ca = JSON.stringify(character_data) 
	#var unique_key = generate_uuid()
	#print("uuid",unique_key)
	var object_write = NakamaWriteStorageObject.new("newHero", hero_name.text, 2, 1, ca, "")

	#var simple_obj = {
	#"collection": "test",
	#"key": "simple_key",
	#"value": {"test_field": "test_value"},
	#"permission_read": 2,
	#"permission_write": 1
	#}
	#print(simple_obj)
	var result = await Global.client.write_storage_objects_async(Global.session, [object_write])
	if result.acks.size() > 0:
		print("写入成功！共 %d 项" % result.acks.size())
		print(result)
		for ack in result.acks:
			print("保存成功：collection=%s, key=%s" % [ack.collection, ack.key])
	else:
		print("没有写入任何数据")
		print(result)
#func create_character(name: String):
	#var payload = "{\"name\":\"剑圣小明\", \"extra_data\":{\"职业\":\"战士\", \"性别\":\"男\", \"等级\":1}}"
#
	#var json = JSON.stringify(payload)
	#var rpc_result = await Global.client.rpc_async(Global.session, "create_character", payload)
#
	#if rpc_result.is_exception():
		#print("RPC failed: ", rpc_result)
		#return
#
	#var result_data = JSON.parse_string(rpc_result.payload)
	#print("RPC Success: ", result_data)
	#
##func submit()->void:		
	##create_character("aabb")
	##return
	##print("提交创建英雄")
	##print(job)
	##print(typeof(attributes))
	##attributes[job]["1"]["level"] = 2
	##attributes[job]["1"]["job"] = job
	##attributes[job]["1"]["sex"] = sex1
	##attributes[job]["1"]["name"] = hero_name.text
##
	##var character_data:Dictionary = attributes[job]["1"]
	##var ca = JSON.stringify(character_data) 
	##var unique_key = generate_uuid()
	##print("uuid",unique_key)
##
	##
	##var result = await Global.client.rpc_async(Global.session,"create_character",ca )
	##if result.acks.size() > 0:
		##print("写入成功！共 %d 项" % result.acks.size())
		##for ack in result.acks:
			##print("保存成功：collection=%s, key=%s" % [ack.collection, ack.key])
	##else:
		##print("没有写入任何数据")
##
##

func _on_check_man_pressed() -> void:
	sex1="man"
	hero_ani.play(job)

	# Replace with function body.


func _on_check_w_oman_pressed() -> void:
	sex1 = "woman"
	match job:
		"zhanshi":
			hero_ani.play("womanZhanshi")
		"fashi":
			hero_ani.play("womanFashi")
		"daoshi":
			hero_ani.play("womanDaoshi")		
	# Replace with function body.
