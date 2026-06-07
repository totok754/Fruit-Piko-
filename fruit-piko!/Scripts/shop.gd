extends Node2D

var appletotalsell = 0
var bbtotalsell = 0
var bananatotalsell = 0
var watermellontotalsell = 0
var pptotalsell = 0

func _ready() -> void:
	if Data.blueberryunlocked:
		$backround/bbcounter.show()
	if Data.bananaunlocked:
		$backround/bananacounter.show()
	if Data.watermellonunlocked:
		$backround/watermelloncounter.show()
	if Data.pineappleunlocked:
		$backround/pineapplecounter.show()


func _physics_process(delta: float) -> void:
	$backround/Apple_counter.text = " • Apples - " + (str(Data.Apples))
	$backround/bbcounter.text = " • Blueberrys - " + (str(Data.blueberrys))
	$backround/bananacounter.text = "• Bananas - " + (str(Data.bananas))
	$backround/watermelloncounter.text = " • Watermellons - " + (str(Data.watermellons))
	$backround/pineapplecounter.text = " • Pineapples - " + (str(Data.pineapple))
	
	$backround/cash_counter.text = " • Cash - $%.2f" % Data.cash
	$"buttons/Growth speed/Label".text = "Growth 
	speed
	upgrade
	$%.0f" % Data.gscost
	$"buttons/Fruit Value/Label".text = "Fruit
	value
	upgrade
	$%.0f" % Data.fruitvalcost
	
	if Data.blueberryunlocked == true:
		$"buttons/blue berry/Label".text = "Unlocked
	blueberry"
	
	
	if Data.bananaunlocked == true:
		$buttons/banana/Label.text = "Unlocked
banana"
	
	if Data.watermellonunlocked == true:
		$buttons/watermellon/Label.text = "   Unlocked
watermellon"

	if Data.pineappleunlocked == true:
		$buttons/pineapple/Label.text = " Unlocked
pneapple"
	if Data.gsgot >= 4:
		$"buttons/Growth speed".disabled = true
		$"buttons/Growth speed/Label".text = "Max 
		upgrade
		reached!"
	if Data.vgot >= 4:
		$"buttons/Fruit Value".disabled = true
		$"buttons/Fruit Value/Label".text = "Max 
		upgrade
		reached!"


func _on_tree_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene's/growing.tscn")
	
func _on_sell_pressed() -> void:
	appletotalsell = Data.Apples * Data.appleval
	Data.Apples = 0
	Data.cash += appletotalsell
	appletotalsell = 0
	
	bbtotalsell = Data.blueberrys * Data.blueberryval
	Data.blueberrys = 0
	Data.cash += bbtotalsell
	bbtotalsell = 0
	
	bananatotalsell = Data.bananas * Data.bananaval
	Data.bananas = 0
	Data.cash += bananatotalsell
	bananatotalsell = 0
	
	watermellontotalsell = Data.watermellons * Data.watermellonval
	Data.watermellons = 0
	Data.cash += watermellontotalsell
	watermellontotalsell = 0
	
	pptotalsell = Data.pineapple * Data.pineapplevar
	Data.pineapple = 0
	Data.cash += pptotalsell
	pptotalsell = 0

func _on_growth_speed_pressed() -> void:
	if Data.cash >= Data.gscost and Data.gsgot <= 4:
		Data.cash -= Data.gscost
		Data.time1 *= 0.8
		Data.time2 *= 0.8
		Data.gscost *= 1.5
		Data.gsgot += 1

func _on_fruit_value_pressed() -> void:
	if Data.cash >= Data.fruitvalcost and Data.vgot <= 3:
		Data.cash -= Data.fruitvalcost
		Data.appleval *= 1.3
		Data.bananaval *= 1.6
		Data.blueberryval *= 1.5
		Data.watermellonval *= 1.4
		Data.pineapplevar *= 1.2
		Data.fruitvalcost *= 2
		Data.vgot += 1

func _on_blue_berry_pressed() -> void:
	if Data.cash >= 10 and Data.blueberryunlocked == false:
		Data.blueberryunlocked = true
		Data.cash -= 10
		


func _on_banana_pressed() -> void:
	if Data.cash >= 30 and Data.bananaunlocked == false:
		Data.bananaunlocked = true
		Data.cash -= 30


func _on_watermellon_pressed() -> void:
	if Data.cash >= 50 and Data.watermellonunlocked == false:
		Data.watermellonunlocked = true
		Data.cash -= 50


func _on_pineapple_pressed() -> void:
	if Data.cash >= 100 and Data.pineappleunlocked == false:
		Data.pineappleunlocked = true
		Data.cash -= 100
