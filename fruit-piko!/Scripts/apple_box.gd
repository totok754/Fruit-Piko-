extends StaticBody2D


func _on_collecter_body_entered(body: Node2D) -> void:
	if body.is_in_group("Apple"):
		body.queue_free()
		Data.Apples += 1
