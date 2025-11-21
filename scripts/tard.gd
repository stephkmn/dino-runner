extends CharacterBody2D

const CLICK_JUMP_FORCE = -800
const GRAVITY = 4200

var dino_name: String
var lower_dino_name: String
var should_jump_on_click := false


func _ready():
	dino_name = name
	lower_dino_name = dino_name.to_lower()
	
	var area = $Area2D
	area.mouse_entered.connect(_on_mouse_entered)
	area.mouse_exited.connect(_on_mouse_exited)
	area.input_event.connect(_on_get_input_event)
	print(name)

func _on_mouse_entered():
	$AnimatedSprite2D.play(lower_dino_name + "_run")

func _on_mouse_exited():
	$AnimatedSprite2D.play(lower_dino_name + "_idle")

func _on_get_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			print("Selected: " + dino_name + ".")
			get_parent().update_dino(dino_name)
			
			should_jump_on_click = true

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	
	if should_jump_on_click:
		velocity.y = CLICK_JUMP_FORCE
		should_jump_on_click = false
	
	move_and_slide()  
