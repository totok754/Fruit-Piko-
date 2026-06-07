extends RigidBody2D

@export var grab_force := 25.0
@export var max_speed := 1000.0
@export var throw_force := 500.0
var spawn_marker: Marker2D
var grabnum = 0

var held := false

func _physics_process(_delta):
	if held:
		freeze = false
		var target = get_global_mouse_position()
		var offset = target - global_position

		var spring_strength = 30.0
		var damping = 8.0

		var force = offset * spring_strength
		force -= linear_velocity * damping

		apply_central_force(force)

func _input(event):
	if event is InputEventMouseButton:

		# Pick up
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			
			var space = get_world_2d().direct_space_state
			var query = PhysicsPointQueryParameters2D.new()
			query.position = get_global_mouse_position()

			var result = space.intersect_point(query)

			for hit in result:
				if hit.collider == self:
					held = true
					if grabnum == 0:
						$Pick.play()
						grabnum = 1
					break
					

		# Drop
		if event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
			held = false

		# Throw
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed and held:
			held = false
			$Throw.play()

			var dir = (
				get_global_mouse_position() - global_position
			).normalized()

			apply_central_impulse(dir * throw_force)


func _ready() -> void:
	$AnimatedSprite2D.play("grow")
	freeze = true
