extends KinematicBody2D

var is_moving_left = true

var gravity = 10
var velocity = Vector2(0,0)

var speed = 32

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationEnemy.play("Run")
	scale.x = -scale.x

func _process(delta):
	if $AnimationEnemy.current_animation == "Attack":
		return
	move_character()
	detect_turn_around()

func move_character():
	velocity.x = -speed if is_moving_left else speed
	velocity.y += gravity
	
	velocity = move_and_slide(velocity,Vector2.UP)
func detect_turn_around():
	if not $RayCast2D.is_colliding() and is_on_floor():
		is_moving_left = !is_moving_left
		scale.x = -scale.x

func hit():
	$AttackDetector.monitoring = true
	
func end_of_hit():
	$AttackDetector.monitoring = false
	
func start_walk():
	$AnimationEnemy.play("Run")
	
#func _on_PlayerDetector_body_entered(body):
#	$AnimationEnemy.play("Attack")


#func _on_AttackDetector_body_entered(body):
#	get_tree().reload_current_scene()
