extends Node3D

var speed = 7;
var acceleration= 20;
var gravity = 9.8;
var jump = 5;

var mouse_sensitivity = 0.05;

var direction = Vector3();
var velocity = Vector3();
var fall = Vector3();

@onready var head = $Head;

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity));
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity));
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-90), deg_to_rad(90));

#updates the game every frame
func _process(delta):
	
	#Pressing "esc" stops your cursor from locking in the screen
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
	
	#WASD Controlls for the player
	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z
	
