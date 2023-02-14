extends KinematicBody2D

var SHOOTING_POWER := 400
var velocity := Vector2.ZERO

func _physics_process(delta: float) -> void:
  # Detect input
  if Input.is_action_pressed("ball_charge"):
    var camera_rotation = $Camera2D.rotation_degrees - 90
    velocity = Vector2(cos(deg2rad(camera_rotation)) * SHOOTING_POWER, sin(deg2rad(camera_rotation)) * SHOOTING_POWER)

  if Input.is_action_pressed("camera_cw"):
    $Camera2D.rotate(deg2rad(1))

  if Input.is_action_pressed("camera_ccw"):
    $Camera2D.rotate(deg2rad(-1))

  if get_slide_count() > 0:
    var collision = get_slide_collision(0)
    velocity = velocity.bounce(collision.normal)
    print(velocity)

  velocity *= 0.99

  move_and_slide(velocity)

func set_velocity(v: Vector2) -> void:
  velocity = v
