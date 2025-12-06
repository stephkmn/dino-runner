extends Node

# preload scenes
var barrel_scene = preload("res://scenes/barrel.tscn")
var rock_scene = preload("res://scenes/rock.tscn")
var stump_scene = preload("res://scenes/stump.tscn")
var bird_scene = preload("res://scenes/bird.tscn")
var obstacle_scenes := [barrel_scene, rock_scene, stump_scene]
var obstacles_created: Array
var bird_heights := [200, 390]

signal dino_changed(new_dino_name)

# game variables
const DINO_START_POS = Vector2i(150, 485)
const CAM_START_POS = Vector2i(576, 324)
const GAME_COLLISION_LAYER = 1
const WARDROBE_COLLISION_LAYER = 2

const START_SPEED : float = 10.0
const MAX_SPEED = 25.0
const SCORE_MODIFIER = 10
const SPEED_MODIFIER = 5000
const MAX_DIFFICULTY: int = 3
const DINO_OPTIONS := ["Mort", "Doux", "Tard", "Vita"]
const WARDROBE_DINO_Y = 79
const GROUND_OFFSET = 5
const OBSTACLE_SPAWN_DISTANCE = 100
const MIN_OBSTACLE_GAP = 300
const MAX_OBSTACLE_GAP = 500
const WARDROBE_Y_OFFSET = 79

var score: int
var high_score: int
var speed : float
var difficulty: int

var current_dino: String = "Doux"
var screen_size : Vector2i
var ground_height: int 
var game_running: bool
var last_obs

# functions
func _ready() -> void:
	screen_size = get_window().size
	ground_height = $Ground.get_node("GroundSprite").texture.get_height()
	$GameOverScreen.get_node("RestartButton").pressed.connect(new_game)
	
	$HUD.get_node("WardrobeButton").pressed.connect(show_wardrobe)
	$WardrobeScreen.get_node("CloseButton").pressed.connect(hide_wardrobe)
	$WardrobeScreen.hide()
	
	new_game()

func new_game():
	# reset variables
	score = 0
	update_score()
	game_running = false
	get_tree().paused = false
	difficulty = 1
	
	#remove obstacles
	for obs in obstacles_created:
		obs.queue_free()
	obstacles_created.clear()
	
	#set up collision layers
	setup_collision_layers()
	
	# reset nodes
	$Dino.position = DINO_START_POS
	$Dino.velocity = Vector2i(0, 0)
	$MainCam.position = CAM_START_POS
	$Ground.position = Vector2i(0, 0)
	
	# reset hud and game over screen
	$HUD.get_node("PressToPlayLabel").show()
	$HUD.get_node("WardrobeButton").show()
	$GameOverScreen.hide()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_running:
		# adjust speed and difficulty
		speed = START_SPEED + score / SPEED_MODIFIER
		if speed > MAX_SPEED:
			speed = MAX_SPEED
		
		adjust_difficulty()
		
		# move dino and camera
		$Dino.position.x += speed
		$MainCam.position.x += speed
		
		# update score
		score += speed
		update_score()
		
		#generate obstacles
		generate_obs()

		# update ground position
		if $MainCam.position.x - $Ground.position.x > screen_size.x * 1.5:
			$Ground.position.x += screen_size.x
			
		#remove past obstacles
		for obs in obstacles_created:
			if obs.position.x < ($MainCam.position.x - screen_size.x):
				remove_obs(obs)
			
	else:
		if Input.is_action_pressed("ui_accept") or Input.is_action_pressed("ui_up"):
			game_running = true;
			$HUD.get_node("PressToPlayLabel").hide()
			$HUD.get_node("WardrobeButton").hide()
			
func generate_obs():
	#generate ground obstacles
	if obstacles_created.is_empty() or last_obs.position.x < score + randi_range(300, 500):
		var obs_type = obstacle_scenes[randi() % obstacle_scenes.size()]
		var obs		
		var max_obs = difficulty
		for i in range(randi() % max_obs + 1):
			obs = obs_type.instantiate()
		
			var obs_height = obs.get_node("Sprite2D").texture.get_height()
			var obs_scale = obs.get_node("Sprite2D").scale
			var obs_x : int = screen_size.x + score + MIN_OBSTACLE_GAP + (i * OBSTACLE_SPAWN_DISTANCE)
			var obs_y : int = screen_size.y - ground_height - (obs_height * obs_scale.y / 2) + GROUND_OFFSET
			
			last_obs = obs
			add_obs(obs, obs_x, obs_y)
		
		#birb generation
		if difficulty == MAX_DIFFICULTY:
			if(randi() % 2) == 0:
				obs = bird_scene.instantiate()
				var obs_x = screen_size.x + score + 100
				var obs_y = bird_heights[randi() % bird_heights.size()]
				add_obs(obs, obs_x, obs_y)
		

func add_obs(obs, x, y):
	obs.position = Vector2i(x, y)
	obs.body_entered.connect(hit_obs)
	add_child(obs)
	obstacles_created.append(obs)

func remove_obs(obs):
	if obstacles_created.has(obs):
		obstacles_created.erase(obs)
		obs.queue_free()

func hit_obs(body):
	if body.name == "Dino":
		game_over()

func update_score():
	$HUD.get_node("ScoreLabel").text = "SCORE: " + str(score / SCORE_MODIFIER)

func check_high_score():
	if score > high_score:
		high_score = score
		$HUD.get_node("HighScoreLabel").text = "HIGH SCORE: " + str(high_score / SCORE_MODIFIER)

func adjust_difficulty():
	difficulty = (score / SPEED_MODIFIER) + 1
	if difficulty > MAX_DIFFICULTY:
		difficulty = MAX_DIFFICULTY
		
func game_over():
	get_tree().paused = true
	game_running = false
	$GameOverScreen.show()
	check_high_score()
	
func setup_collision_layers():
	# Configure main dino
	$Dino.collision_layer = 1 << (GAME_COLLISION_LAYER - 1)  # Layer 1
	$Dino.collision_mask = 1 << (GAME_COLLISION_LAYER - 1)   # Only detects layer 1
	
	# Configure wardrobe platforms (if they exist)
	var wardrobe_platform = $WardrobeScreen.get_node_or_null("WardrobePlatform")
	if wardrobe_platform and wardrobe_platform.has_method("set_collision_layer"):
		wardrobe_platform.collision_layer = 1 << (WARDROBE_COLLISION_LAYER - 1)  # Layer 2
	
func show_wardrobe():
	# Pause game
	get_tree().paused = true
	game_running = false
	
	# Hide HUD, show wardrobe
	$HUD.get_node("WardrobeButton").hide()
	$WardrobeScreen.show()
	
	# Position dino options
	for node_name in DINO_OPTIONS:
		var dino_node = $WardrobeScreen.get_node_or_null(node_name)
		if dino_node:
			dino_node.position.y = WARDROBE_DINO_Y

func hide_wardrobe():
	# Show HUD, hide wardrobe
	$WardrobeScreen.hide()
	$HUD.get_node("WardrobeButton").show()
	
	# Resume game
	get_tree().paused = false
	
func update_dino(new_dino_name: String):
	current_dino = new_dino_name
	emit_signal("dino_changed", new_dino_name)
