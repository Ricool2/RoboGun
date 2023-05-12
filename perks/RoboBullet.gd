extends RigidBody2D

var velocity = Vector2.ZERO
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("fire")


func _process(delta):
#	position += velocity * delta * 1000
	pass

func _on_RoboBullet_body_entered(body):
	if !body.is_in_group('player'):
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
