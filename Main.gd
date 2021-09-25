extends Node


# Declare member variables here.

# PowerUp Coins position array
var power_coin_pos = [
	Vector2(80, 80),
	Vector2(80, 1520),
	Vector2(1520, 80),
	Vector2(1520, 1520)
]

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.start($PlayerStartPosition.position)
	$Coin.start($CoinStartPosition.position)

	# Place power coins in the four corners
	var power_coin = preload("res://PowerCoin.tscn")
	for coin_pos in power_coin_pos:
		var coin = power_coin.instance()
		add_child(coin)
		coin.start(coin_pos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
