extends Node


# Declare member variables here.


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.start($PlayerStartPosition.position)
	$Coin.start($CoinStartPosition.position)
	$PowerCoin.start($PowerCoinStartPosition.position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
