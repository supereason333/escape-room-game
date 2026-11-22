extends RigidBody3D
class_name Player

signal override
signal override_released

@onready var white_overlay:ColorRect = %WhiteOverlay

@onready var override_ui_base:Control = %OverrideUI
@onready var select_ray:RayCast3D = %SelectRay
@onready var cam_rotate:Node3D = $Rotate
@onready var cam_tilt:Node3D = $Rotate/Tilt
@onready var camera:Camera3D = %Camera
var camera_zoomed := false

@export var sens := 0.001
@export var walk_speed := 10.0
@export var sprint_speed := 15.0
@export var response := 10.0
@export var max_force := 600.0

var pos_reset_queued := false
var reset_pos:Vector2

var normal_height := 0.0
var crouch_height := -0.5
var crouching := false

var camera_override := false:
	set(value):
		if value != camera_override:
			camera_override = value
			if camera_override:
				override.emit()
			else:
				override_released.emit()

var has_drive := false:
	set(value):
		has_drive = value
		%DriveTexture.visible = has_drive

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	normal_height = cam_rotate.position.y
	camera_override = true
	await get_tree().create_timer(1).timeout
	await create_tween().tween_property(white_overlay, "color:a", 0, 0.3).finished
	white_overlay.queue_free()
	camera_override = false

func _physics_process(_dt: float) -> void:
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var target_speed := sprint_speed if Input.is_action_pressed("sprint") else walk_speed
	if crouching: target_speed = walk_speed / 2
	var target_velocity := Vector3 (
		input_dir.x,
		0.0,
		input_dir.y
	) * target_speed

	target_velocity *= cam_rotate.transform.basis.inverse()

	if camera_override or Input.mouse_mode != Input.MOUSE_MODE_CAPTURED: target_velocity = Vector3.ZERO

	var velocity_error := target_velocity - linear_velocity

	apply_central_force((velocity_error * response).limit_length(max_force))

func _process(_dt: float) -> void:
	if camera_override: return
	if Input.is_action_just_released("give_mouse"):
		if Input.mouse_mode != Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	if camera_override: return
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED: return
	if event is InputEventMouseMotion:
		cam_rotate.rotate(Vector3.UP, -event.screen_relative.x * sens)
		cam_tilt.rotation.x -= event.screen_relative.y * sens
		cam_tilt.rotation.x = clamp(cam_tilt.rotation.x, -PI/2, PI/2)

	if event.is_action_pressed("zoom") and !camera_zoomed:
		camera_zoomed = true
		create_tween().tween_property(camera, "fov", 30, 0.1)
	elif event.is_action_released("zoom") and camera_zoomed:
		camera_zoomed = false
		create_tween().tween_property(camera, "fov", 75, 0.1)

	if event.is_action_pressed("crouch") and !crouching:
		crouching = true
		create_tween().tween_property(cam_rotate, "position:y", normal_height + crouch_height, 0.1)
	elif event.is_action_released("crouch") and crouching:
		crouching = false
		create_tween().tween_property(cam_rotate, "position:y", normal_height, 0.1)

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			select_ray.force_raycast_update()
			var collider = select_ray.get_collider()
			if collider is Select3D:
				collider.trigger(self)
