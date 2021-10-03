extends Node

var player_score = 0

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
	[0, 1, 1, 1, 1, 1, 1, 1, 1, 0],
	[1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
]

func _ready():
	# Set Player position so that the camera is centered
	# on the starting position
	$Player.set_position($PlayerStartPosition.position)

func new_game():
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

	# Reset score
	player_score = 0
	$HUD.update_score(player_score)

	# Show start message
	$HUD.show_message("Go!")

	# Enable PC
	$Player.start($PlayerStartPosition.position)
	$AkabeiMob.start($AkabeiStartPosition.position)

func game_over():
	# Remove PC
	$AkabeiMob.stop()
	$Player.stop()
	# Stop timer if it's running
	$MobRespawnTimer.stop()
	# Remove not-picked coins
	for obj in get_children():
		if obj.is_in_group("coin"):
			remove_child(obj)
			obj.queue_free()
	# Show game over message
	$HUD.show_game_over()

func _on_Player_update_score():
	player_score += 1
	$HUD.update_score(player_score)

	# If there's no more coins left game over
	if no_more_coins():
		game_over()

func no_more_coins():
	var coins = get_tree().get_nodes_in_group("coin")
	print("Coins left: ", coins.size())
	return coins.size() == 1 # FIXME

func _on_Player_mob_collision():
	handle_collision()

func _on_AkabeiMob_mob_collision():
	handle_collision()

func handle_collision():
	if($Player.powered_up):
		# Add +10 to the score
		player_score += 10
		$HUD.update_score(player_score)
		# Hide mob
		$AkabeiMob.stop()
		$MobRespawnTimer.start()
	else:
		game_over()

func _on_MobRespawnTimer_timeout():
	$AkabeiMob.start($AkabeiStartPosition.position)
