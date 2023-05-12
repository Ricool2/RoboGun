extends Area2D

signal hit
signal fire

var bullet = preload("res://perks/RoboBullet.tscn")
export var bullet_speed = 3000
export var fire_rate = 0.213
var can_fire = true
export var dir = 0

var screen_size
export var speed = 678

func _physics_process(delta):
	moves(delta)
	if Input.is_action_pressed("mouse_leftclick"):
		$AnimatedSprite.animation = 'fire'
		if can_fire:
			emit_signal('fire', bullet, bullet_speed, $Gun.global_position, rotation_degrees, dir.angle())
			can_fire = false
			yield(get_tree().create_timer(fire_rate), "timeout")
			can_fire = true
	else:
		$AnimatedSprite.animation = 'static'

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
#	hide()
	$AnimatedSprite.play()
	$AnimatedSprite.animation = "static"
#	screen_size = OS.get_screen_size()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	dir = (get_global_mouse_position() - position).normalized()
	rotation = dir.angle()
#	look_at(get_global_mouse_position())
	#for quit with esc
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
#
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func moves(delta):
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

#func fire(bullet, bullet_speed, gun, rot_d, rot):
#	var bullet_instance = bullet.instance()
#	bullet_instance.position = gun
#	bullet_instance.rotation_degrees = rot_d
#	bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rot))
#	get_tree().get_root().add_child(bullet_instance)

func _on_Robo_body_entered(body):
	hide()
	emit_signal('hit')
	$CollisionShape2D.set_deferred('disabled', true)
	$CollisionShape2D2.set_deferred('disabled', true)
