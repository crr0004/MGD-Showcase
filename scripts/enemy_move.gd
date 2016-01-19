
extends KinematicBody2D

# member variables here, example:
# var a=2
# var b="textvar"

export(NodePath) var animation

var walkNode
var sound
var velocity = Vector2(100, 0)
var speed = 100
var direction = -1
var sprite

func _ready():
	# Initialization here
	set_fixed_process(true)
	walkNode = get_node(animation)
	sound = get_node("SamplePlayer2D")
	sprite = get_node("Enemy")
	pass

func turnAround():
	direction *= -1
	sprite.set_flip_h(bool(direction + 1))

func _fixed_process(delta):
	velocity.y += delta * 2500
	velocity.x = speed * direction
	if(!sound.is_voice_active(0)):
		sound.play("slimMove")

	if(!walkNode.is_playing()):
		walkNode.play("Walk")

	var motion = velocity * delta
	move(motion)
	if (is_colliding()):
		var n = get_collision_normal()
		
		if(abs(n.x) == 1):
			turnAround()
			
		
		motion = n.slide( motion ) 
		velocity = n.slide( velocity )
		move( motion )
