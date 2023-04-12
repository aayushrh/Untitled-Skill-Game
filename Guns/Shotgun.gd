extends PGun

func _ready():
	super._initialize(2, 1)

func shoot_over(angle):
	super.shoot(angle + 25, false, false)
	super.shoot(angle + 10, false, false)
	super.shoot(angle, false, false)
	super.shoot(angle - 10, false, false)
	super.shoot(angle - 25, true, false)

func _on_Timer_timeout():
	can_shoot = true
