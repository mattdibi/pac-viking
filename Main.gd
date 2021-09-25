extends Node


# Declare member variables here.

# PowerUp Coins position array
var power_coin_pos = [
	Vector2(  80,  160),
	Vector2(1520,  160),
	Vector2(  80, 1200),
	Vector2(1520, 1200)
]

# Standard Coins position array
var std_coin_pos = [
	[1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
	[0, 0, 1, 0, 0, 0, 0, 1, 0, 0],
	[0, 0, 1, 0, 0, 0, 0, 1, 0, 0],
	[0, 0, 1, 0, 0, 0, 0, 1, 0, 0],
	[1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
]

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.start($PlayerStartPosition.position)

	# Place coins in their positions
	var std_coin = preload("res://Coin.tscn")
	for row in range(0, std_coin_pos.size()):
		for col in range(0, std_coin_pos[row].size()):
			if std_coin_pos[row][col]:
				var start_pos = Vector2(col * 160 + 80, row * 160 + 80)
				var coin = std_coin.instance()
				add_child(coin)
				coin.start(start_pos)

	# Place power coins in the four corners
	var power_coin = preload("res://PowerCoin.tscn")
	for coin_pos in power_coin_pos:
		var coin = power_coin.instance()
		add_child(coin)
		coin.start(coin_pos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
