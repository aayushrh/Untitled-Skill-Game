extends PGun

func _ready():
	super._initialize(2, 1)

func shoot_over(angle, pore = true):
	super.shoot(angle + 25, false, false, pore)
	super.shoot(angle + 10, false, false, pore)
	super.shoot(angle, false, false, pore)
	super.shoot(angle - 10, false, false, pore)
	super.shoot(angle - 25, true, false, pore)

func _on_Timer_timeout():
	can_shoot = true
