extends Node


var bug = preload("res://chars/bug/Bug.tscn")
var spawn_timer = 1
var spawn_countdown = 0.0
var spawn_distance = 600
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print(has_node('/chars/bug/Bug.tscn'))
	$Robo.position = $Position2D.position
	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawn_countdown -= delta
	if spawn_countdown <= 0:
		var bug_ins = spawn_bug()
		bug_ins.look_at($Robo.global_position)
		spawn_countdown = spawn_timer
		

func _on_Robo_hit():
	pass

func _on_Robo_fire(bullet, bullet_speed, gun, rot_d, rot):
	var bullet_instance = bullet.instance()
	add_child(bullet_instance)
	bullet_instance.position = gun
	bullet_instance.rotation_degrees = rot_d
#	bullet_instance.velocity = bullet_instance.velocity.rotated(rot)
	bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rot))

func spawn_bug():
	var bug_instance = bug.instance()
	var pos = random_point_around_robo()
	bug_instance.position = pos
#	bug_instance.move(target)
#	bug_instance.look_at($Robo.global_position)
	add_child(bug_instance)
	
	return bug_instance
	
func random_point_around_robo():
	var angle = rand_range(0, 360)
	var offset = Vector2(spawn_distance, 0).rotated(angle)
	return $Robo.position + offset
