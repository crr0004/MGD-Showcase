
extends KinematicBody2D

# member variables here, example:
# var a=2
# var b="textvar"

export var GRAVITY = 1000.0
export var WALK_SPEED = 200.0
export var JUMP_SPEED = 2000.0
export var DOUBLE_TAP_GAP = 10.0
export var FART_GAP = 1.0

var jumpCount = 2
var walkAnimationNode
var playerSprite
var soundPlayer
var fartPoint
var fartPos
var fartScene
var farting = false
var particles
var timeSinceLastFart = 0.0
var direction = 0

var particleRot
var particelPos

var pressedActions = []

var velocity = Vector2()
var thread

func printHi(p):
	print("hi")
	return

func _ready():
	set_fixed_process(true)
	walkAnimationNode = get_node("Walk_Animation")
	playerSprite = get_node("Player_Sprite")
	soundPlayer = get_node("SamplePlayer2D")
	fartPoint = get_node("Player_Sprite/FartPoint")
	fartScene = load("res://scenes/fart.scn")
	particles = get_node("Particles2D")
	particelPos = particles.get_pos()
	particleRot = particles.get_rot()
	fartPos = fartPoint.get_pos()
	thread = Thread.new()
	
	

	
func movePlayer(delta, direction):
	velocity.x = direction * WALK_SPEED
	particles.set_emitting(true)
	if(self.direction != direction):
		self.direction = direction
		
		#abs(fartPos.x) * -direction
		particelPos.x = abs(particelPos.x) * -direction
		particleRot = abs(particleRot) * -direction
		particles.set_pos(particelPos)
		particles.set_rot(particleRot)
		playerSprite.set_flip_h(bool(-direction + 1))
		
	if(!walkAnimationNode.is_playing()):
		walkAnimationNode.play("Walk")

func _fixed_process(delta):
	
	velocity.y += delta * GRAVITY
	if(velocity.y < 0):
		walkAnimationNode.stop(false)
	if(Input.is_action_pressed("left")):
		movePlayer(delta, -1)
		
		pressedActions.append(InputMap.get_action_id("left"))
		
	elif(Input.is_action_pressed("right")):
		movePlayer(delta, 1)
	else:
		velocity.x = 0
		particles.set_emitting(false)
	if(farting):
		if(velocity.x != 0):
			velocity.x *= 2
		timeSinceLastFart -= delta
		if(timeSinceLastFart <= 0):
			farting = false
			timeSinceLastFart = 0
		
		
	if(Input.is_action_pressed("sprint") && timeSinceLastFart <= 0):
		Input.is_key_pressed(10)
		farting = true
		timeSinceLastFart = FART_GAP
		soundPlayer.play("fart")
		fartPos.x = abs(fartPos.x) * -direction
		fartPoint.set_pos(fartPos)
		fartPoint.add_child(fartScene.instance())
	
	
	
	if(velocity.y > 0 && jumpCount > 0 && Input.is_action_pressed("jump")):
		if(!thread.is_active()):
				print(thread.start(self, "printHi"))
		velocity.y = -JUMP_SPEED
		jumpCount -= 1
		soundPlayer.play("phaseJump1")
		
	var motion = velocity * delta
	move(motion)
	if (is_colliding()):
		var n = get_collision_normal()
		if(n == Vector2(0, -1)):
			jumpCount = 2
		
		motion = n.slide( motion ) 
		velocity = n.slide( velocity )
		move( motion )
	pressedActions.clear()