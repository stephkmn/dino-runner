extends CharacterBody2D


const GRAVITY : int = 4200
const JUMP_SPEED : int = -1800
const FALL_ACC: int = 150

var curr_dino: String
var idle_state: String
var duck_state: String
var run_state: String
var jump_state: String


func _ready():
	if get_parent().has_signal("dino_changed"):
		get_parent().connect("dino_changed", _on_dino_changed)
	
	# Set up initial dino
	curr_dino = get_parent().current_dino.to_lower()
	update_dino_states()

func _physics_process(delta: float):
	curr_dino = get_parent().current_dino.to_lower()
	
	velocity.y += GRAVITY * delta  
	
	if get_parent().game_running:
		if is_on_floor():
			$RegularCol.disabled = false
			if Input.is_action_pressed("ui_accept") || Input.is_action_pressed("ui_up"):
				velocity.y = JUMP_SPEED
				$JumpSoundPlayer.play()
			elif Input.is_action_pressed("ui_down"):
				$RegularCol.disabled = true
				$DinoSprite.play(duck_state)
			else:
				$DinoSprite.play(run_state)
		else:
			$DinoSprite.play(jump_state)
			if Input.is_action_pressed("ui_down"):
				$RegularCol.disabled = true
				velocity.y += FALL_ACC
	else:
		$DinoSprite.play(idle_state)
		
			
	move_and_slide()

func _on_dino_changed(new_dino_name: String):
	curr_dino = new_dino_name.to_lower()
	update_dino_states()

func update_dino_states():
	curr_dino = get_parent().current_dino.to_lower()
	idle_state = curr_dino + "_idle"
	duck_state = curr_dino + "_duck"
	run_state = curr_dino + "_run"
	jump_state = curr_dino + "_jump"
	
	var current_anim = $DinoSprite.animation
	$DinoSprite.play(current_anim)
