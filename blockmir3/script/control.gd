extends Control
# Nakama client setup
#var nakama_client : NakamaClient
#var nakama_session : NakamaSession
#var username = ""

# UI elements
#var username_input : LineEdit
#var password_input : LineEdit
#var register_button : Button
@onready var register_button: Button = $Panel/Button
@onready var password_input: LineEdit = $Panel/LineEdit
@onready var username_input: LineEdit = $Panel/LineEdit2


# Nakama连接测试

var client : NakamaClient
var session : NakamaSession
var is_login : bool
#var _api_client : NakamaAPI.ApiClient

#@onready var socket = Nakama.create_socket_from(client)

func _ready():
	   # 创建客户端并连接
	client = await Nakama.create_client("defaultkey", "127.0.0.1", 7350, "http")
	client.timeout = 10
	#client.ssl=false
	

func login():
	print(username_input.text,password_input.text)
	var device_id = OS.get_unique_id()  # 获取设备的唯一 ID
	print(client)
	print(device_id)
	if client == null:
		print("Client is not initialized!")
	else:
		print("Client is initialized!")	
	# 使用设备 ID 进行身份验证
	session = await client.authenticate_device_async(device_id)
	
	if session.is_exception():
		print("An error occurred: %s" % session)
		return
	print("这里。")
	print("Successfully authenticated: %s" % session)
	print(typeof(session))	
	print(session.username)	
	# 创建 API client
	#_api_client = Nakama.create_api_client(client)
	is_login = true
	print("开始跳转")
	Global.client = client
	Global.session = session
	#Global._api_client = _api_client
	Global.is_login = true
	Global.username = session.username
	get_tree().change_scene_to_file("res://creat_h.tscn")
#func connect_to_nakama():
	#var options = NakamaAuthOptions.new()
	#options.username = "test_user"  # 设置用户名
	#options.create = true  # 如果不存在，则创建用户
#
	## 尝试登录到Nakama服务器
	#client.authenticate_device(options, "_on_authenticated")
#
## 认证回调
#func _on_authenticated(error: String, user: NakamaUser, session: NakamaSession):
	#if error != "":
		#print("Error during authentication: ", error)
		#return
	#print("Successfully authenticated as: ", user.username)
	#self.session = session

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	##username_input = $LineEdit2
	##password_input = $LineEdit
	##register_button = $Button
	#if register_button == null:
		#print("Error: Button node not found! Check the path: $Button")
	#else:
		#print("Button node found and initialized successfully.")
	#nakama_client = Nakama.create_client("default", "127.0.0.1", 7350, "http")
	#if register_button != null:
		#register_button.pressed.connect(_on_register_button_pressed)

## Called when the register button is pressed
#func _on_register_button_pressed() -> void:
	#print("join reg")
	#var username = username_input.text
	#var password = password_input.text
	#print(username,password)
	#if username.empty() or password.empty():
		#print("Username and password cannot be empty!")
		#return
	#
	## Register account with Nakama
	#print("发送注册")
	#await nakama_client.register_email_async(username, password, username, "", "")
	#print("Account registered successfully!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
