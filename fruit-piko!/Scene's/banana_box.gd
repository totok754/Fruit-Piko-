extends StaticBody2D


func _on_collecter_body_entered(body: Node2D) -> void:
	if body.is_in_group("Banana"):
		$List.play()
		body.queue_free()
		Data.bananas += 1
