extends Node2D

@export var apple_scene: PackedScene
@export var blueberry_scene: PackedScene
@export var banana_scene: PackedScene
@export var watermelon_scene: PackedScene
@export var pineapple_scene: PackedScene

var Fruitspawn = 0

@onready var spawn_points = $Spawn_points.get_children()

func _ready():
	randomize()
	spawn_loop()
	# Optional Tip: You can shorten "if Data.blueberryunlocked == true:" to just this:
	if Data.blueberryunlocked:
		$backround/bbcounter.show()
	if Data.bananaunlocked:
		$backround/bananacounter.show()
	if Data.watermellonunlocked:
		$backround/watermelloncounter.show()
	if Data.pineappleunlocked:
		$backround/pineapplecounter.show()

func spawn_loop() -> void:
	while true:
		await get_tree().create_timer(randf_range(Data.time1, Data.time2)).timeout
		
		var marker = spawn_points.pick_random()
		var occupied = false
		
		for fruit in get_tree().get_nodes_in_group("fruit"):
			if not is_instance_valid(fruit):
				print("F")
				continue
				
			if fruit.global_position.distance_to(marker.global_position) < 20:
				occupied = true
				break
				
		if occupied:
			continue    
		
		var fruit_to_spawn: Node2D = null
		
		# This loop keeps running until fruit_to_spawn is successfully set
		while fruit_to_spawn == null:
			# Roll a number between 1 and 100
			Fruitspawn = randi_range(1, 5)
			
			# 50% chance for Apple (Always unlocked)
			if Fruitspawn == 1:
				fruit_to_spawn = apple_scene.instantiate()
				
			# 20% chance for Blueberry
			elif Fruitspawn == 2:
				if Data.blueberryunlocked:
					fruit_to_spawn = blueberry_scene.instantiate()
					
			# 15% chance for Banana
			elif Fruitspawn == 3:
				if Data.bananaunlocked:
					fruit_to_spawn = banana_scene.instantiate()
					
			# 10% chance for Watermelon
			elif Fruitspawn == 4:
				if Data.watermellonunlocked:
					fruit_to_spawn = watermelon_scene.instantiate()
					
			# 5% chance for Pineapple
			elif Fruitspawn == 5:
				if Data.pineappleunlocked:
					fruit_to_spawn = pineapple_scene.instantiate()

		# Once the inner loop breaks, we finally have an unlocked fruit to place!
		fruit_to_spawn.global_position = marker.global_position
		add_child(fruit_to_spawn)

func _physics_process(delta: float) -> void:
	$backround/Apple_counter.text = " • Apples - " + (str(Data.Apples))
	$backround/bbcounter.text = " • Blueberrys - " + (str(Data.blueberrys))
	$backround/bananacounter.text = "• Bananas - " + (str(Data.bananas))
	$backround/watermelloncounter.text = " • Watermellons - " + (str(Data.watermellons))
	$backround/pineapplecounter.text = " • Pineapples - " + (str(Data.pineapple))
	$backround/cash_counter.text = " • Cash - $%.2f" % Data.cash

func _on_shop_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene's/shop.tscn")
