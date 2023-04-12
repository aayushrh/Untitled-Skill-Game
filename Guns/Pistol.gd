extends PGun

func _ready():
	super._initialize(5, 2)

func shoot_over(angle):
	super.shoot(angle, true)

func _on_Timer_timeout():
	can_shoot = true
