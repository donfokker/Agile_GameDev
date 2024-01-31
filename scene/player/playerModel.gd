extends CharacterBody3D

const Default_Move_Speed = 5;
const jump_VELOCITY = 8;

var mouse_sens = 0.05;
@onready var head = $Head

#get input from the project settings to be synced with the RigidBody nodes
#var gravity = ProjectSettings.get_setting("physic/3d/default.gravity")
var gravity = 15;

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func _physics_process(delta):
	#Add the gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	#Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_VELOCITY
	
	#Get the input direction and handle the movement/deceleration
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * Default_Move_Speed
		velocity.z = direction.z * Default_Move_Speed
	else:
		velocity.x = move_toward(velocity.x, 0, Default_Move_Speed)
		velocity.z = move_toward(velocity.z, 0, Default_Move_Speed)
	move_and_slide()
	
	#Death screen upon touching floor
	
