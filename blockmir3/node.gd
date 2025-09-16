extends Node

func _ready():
	# 直接访问 Web3Global 单例的 wallet_manager
	var wallet = Web3Global.wallet_manager
	
	# 连接信号
	wallet.wallet_connected.connect(_on_wallet_connected)
	wallet.wallet_disconnected.connect(_on_wallet_disconnected)
	wallet.balance_updated.connect(_on_balance_updated)
	wallet.wallet_error.connect(_on_wallet_error)
	
	# 点击按钮连接钱包
	#$ConnectButton.pressed.connect(func():
	wallet.connect_wallet()
	#)


func _on_wallet_connected(address: String):
	print("钱包已连接:", address)

func _on_wallet_disconnected():
	print("钱包已断开")

func _on_balance_updated(balance: String):
	print("余额更新:", balance)

func _on_wallet_error(error: String):
	print("钱包错误:", error)
