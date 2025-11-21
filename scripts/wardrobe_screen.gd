extends CanvasLayer

const DINO_OPTIONS := ["Mort", "Doux", "Tard", "Vita"]
const DINO_Y = 79

var dino_label

func _ready():
	dino_label = get_node(get_parent().current_dino + "Name")
	dino_label.modulate = Color("73572c")

func _process(delta: float):
	if get_parent().game_running:
		disable_wardrobe_collisions()
	else:
		enable_wardrobe_collisions()

func disable_wardrobe_collisions():
	for node_name in DINO_OPTIONS:
		var dino_node = get_node_or_null(node_name)
		if dino_node:
			var collision_poly = dino_node.get_node_or_null("CollisionPolygon2D")
			if collision_poly:
				collision_poly.disabled = true
			
			var area_node = dino_node.get_node_or_null("Area2D")
			if area_node:
				var area_collision = area_node.get_node_or_null("CollisionPolygon2D")
				if area_collision:
					area_collision.disabled = true
	
	# Disable platform collision
	var platform = get_node_or_null("WardrobePlatform/CollisionShape2D")
	if platform:
		platform.disabled = true

func enable_wardrobe_collisions():
	for node_name in DINO_OPTIONS:
		var dino_node = get_node_or_null(node_name)
		if dino_node:
			var collision_poly = dino_node.get_node_or_null("CollisionPolygon2D")
			if collision_poly:
				collision_poly.disabled = false
			
			var area_node = dino_node.get_node_or_null("Area2D")
			if area_node:
				var area_collision = area_node.get_node_or_null("CollisionPolygon2D")
				if area_collision:
					area_collision.disabled = false
	
	# Enable platform collision
	var platform = get_node_or_null("WardrobePlatform/CollisionShape2D")
	if platform:
		platform.disabled = false

func update_dino(new_dino_name: String):
	dino_label.modulate = Color("ffffff")
	
	get_parent().update_dino(new_dino_name)
	dino_label = get_node(new_dino_name + "Name")
	dino_label.modulate = Color("73572c")
