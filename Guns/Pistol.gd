extends PGun

func _ready():
	super._initialize(5, 2)

func shoot_over(angle, pore = true):
	super.shoot(angle, true, true, pore)

func _on_Timer_timeout():
	can_shoot = true
