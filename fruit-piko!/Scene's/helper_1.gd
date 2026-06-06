extends StaticBody2D

func _on_button_button_down() -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	await get_tree().create_timer(1).timeout
	$CollisionShape2D.set_deferred("disabled", false)
