extends StaticBody2D


func _on_collecter_body_entered(body: Node2D) -> void:
	if body.is_in_group("Pineapple"):
		$List.play()
		body.queue_free()
		Data.pineapple += 1
