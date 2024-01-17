extends CharacterBody3D

const SPEED = 5;
const jump_VELOCITY = 4.5;

#get input from the project settings to be synced with the RigidBody nodes
#var gravity = ProjectSettings.get_setting("physic/3d/default.gravity")
var gravity = 9;

func _physics_process(delta):
	#Add the gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	#Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_VELOCITY
	
	#Get the input direction and handle the movement/deceleration
	var input_dir = Input.get_vector("move_forward", "move_backward", "move_left", "move_right")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.x = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()
