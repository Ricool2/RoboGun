extends RigidBody2D

#onready var target = get_node_or_null("res://chars/robo/Robo.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
#	hide()
#	print(get_path_to($Robo))
	$AnimatedSprite.play()
	$AnimatedSprite.animation = 'static'


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#for quit with esc
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	$AnimatedSprite.animation = 'move'
#	move()
	var velocity = Vector2(3, 0).rotated(rotation)
	position += velocity
	
func move(speed = 3):
#	look_at(vector)
#	var velocity = Vector2.ZERO
	var velocity = Vector2(speed, 0).rotated(rotation)
	position += velocity

func _on_Bug_body_entered(body):
	if body.is_in_group('robobullet'):
		queue_free()
