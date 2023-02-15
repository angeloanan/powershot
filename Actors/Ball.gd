extends KinematicBody2D

var MAX_SHOOTING_POWER := 600
var MAX_CHARGING_TIME := 3_000
var velocity := Vector2.ZERO

var printed := true
var is_charging := false
var charging_time: int

func _physics_process(_delta: float) -> void:
  # Clamping minimum speed to 2 px per sec
  var is_moving := velocity.length() > 5
  
  # Detect input
  if Input.is_action_pressed("ball_charge") && !is_moving:
    if (!is_charging): # Store time on first press (charging_time)
      charging_time = OS.get_ticks_msec()
      is_charging = true
    else:
      var current_force = calculate_force(OS.get_ticks_msec() - charging_time)
      $BallVector.update_force(Vector2(current_force / 2.5, 0).rotated(deg2rad($Camera2D.rotation_degrees - 90)))
      print("Charging: " + String(current_force))
    
  if Input.is_action_just_released("ball_charge") && !is_moving:
    var camera_rotation = $Camera2D.rotation_degrees - 90
    var force = calculate_force(OS.get_ticks_msec() - charging_time)

    print("Shooting! Force: " + String(force) + " at " + String(camera_rotation) + " degrees")
    velocity = Vector2(cos(deg2rad(camera_rotation)) * force, sin(deg2rad(camera_rotation)) * force)
    is_charging = false

    # Cleanup side effects
    $BallVector.update_force(Vector2.ZERO)


  # Handle Camera
  if Input.is_action_pressed("camera_cw"):
    $Camera2D.rotate(deg2rad(1))
  if Input.is_action_pressed("camera_ccw"):
    $Camera2D.rotate(deg2rad(-1))

  # Handle ball bounce
  if get_slide_count() > 0:
    var collision = get_slide_collision(0)
    velocity = velocity.bounce(collision.normal)
    print("Bonk! Velocity:" + String(velocity))

  velocity *= 0.99

  # When ball has stopped moving
  if !is_moving && !printed:
    BallData.stroke_count += 1;
    BallData.stroke_total += 1;
    
    print("Not moving! Final velocity: " + String(velocity))
    print("Stroke number: ", BallData.stroke_count)
    
    velocity = Vector2.ZERO
    printed = true
  elif is_moving:
    printed = false

  move_and_slide(velocity)

func calculate_force(charge_time: float, max_force = MAX_SHOOTING_POWER, max_time = MAX_CHARGING_TIME) -> float:
  var force = lerp(0, max_force, charge_time / max_time)
  if force > max_force:
    force = max_force
  return force

func set_velocity(v: Vector2) -> void:
  velocity = v

func slowdown(speed: float) -> void:
  velocity *= speed
