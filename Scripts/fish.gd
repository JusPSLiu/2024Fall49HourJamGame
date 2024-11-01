extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var EXPLODE_ON_IMPACT : bool = false
@export var ExploPoly : explodeablePolygon
@export var AnimatedBody : AnimatedSprite2D
@export var fishSound : AudioStreamPlayer
@export var animator : AnimationPlayer
@export var joey : Node

var currAnimation : int = 0
var dead : bool = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	if Input.is_action_just_pressed("restart"):
		var current_scene = get_tree().get_current_scene()
		get_tree().reload_current_scene()
	if(dead):
		return
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if is_on_floor():
		if(EXPLODE_ON_IMPACT):
			ExploPoly.show()
			AnimatedBody.hide()
			ExploPoly.explode()
			$DuhText.visible = true
			dead = true
		velocity.y = JUMP_VELOCITY
		#animation
		var rando : int = randi_range(1,4)
		if (rando >= currAnimation):
			rando+=1
		currAnimation = rando
		animator.play(str(randi_range(0,4)))
		fishSound.play()
		AnimatedBody.play("flop"+str(rando))

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func jumpedOff(body, jumpedRight):
	EXPLODE_ON_IMPACT = true
	joey.show()
	if(!jumpedRight):
		joey.position.x = -1191


func escape_ending(body: Node2D) -> void:
	$TextureRect.visible = true
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://Scenes/Screens/CreditScreen.tscn")
