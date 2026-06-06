extends Node2D


@export var apple_scene: PackedScene
@export var blueberry_scene: PackedScene
@export var banana_scene: PackedScene
@export var watermellon_scene: PackedScene
@export var pineapple_scene: PackedScene



@onready var spawn_points = $Spawn_points.get_children()


func _ready():
	randomize()
	spawn_loop()
	if Data.blueberryunlocked == true:
		$backround/bbcounter.show()
	if Data.bananaunlocked == true:
		$backround/bananacounter.show()
	if Data.watermellonunlocked == true:
		$backround/watermelloncounter.show()
	if Data.pineappleunlocked == true:
		$backround/pineapplecounter.show()
func spawn_loop() -> void:
	while true:
		await get_tree().create_timer(randf_range(Data.time1, Data.time2)).timeout
		var marker = spawn_points.pick_random()
		var occupied = false
		for fruit in get_tree().get_nodes_in_group("fruit"):
			if not is_instance_valid(fruit):
				continue
			# Only block if fruit is still near the spawn point
			if fruit.global_position.distance_to(marker.global_position) < 20:
				occupied = true
				break
		if occupied:
			continue	
		var apple = apple_scene.instantiate()
		add_child(apple)
		apple.global_position = marker.global_position

func _physics_process(delta: float) -> void:
	$backround/Apple_counter.text = " • Apples - " + (str(Data.Apples))
	$backround/bbcounter.text = " • Blueberrys - " + (str(Data.blueberrys))
	$backround/bananacounter.text = "• Bananas - " + (str(Data.bananas))
	$backround/watermelloncounter.text = " • Watermellons - " + (str(Data.watermellons))
	$backround/pineapplecounter.text = " • Pineapples - " + (str(Data.pineapple))
	$backround/cash_counter.text = " • Cash - $%.2f" % Data.cash
func _on_shop_pressed() -> void:
	get_tree().change_scene_to_file("res://shop.tscn") 
