extends KinematicBody2D

export var MAX_SHOOTING_POWER := 600

# Maximum amount of time player can charge (in ms)
export var MAX_CHARGING_TIME := 3_000

onready var initial_position = get_global_transform().origin

var velocity := Vector2.ZERO
var speed_modifier := 1.0

var is_in_water := false

var printed := true
var is_charging := false
var charging_time: int

var is_precise_button_pressed := false

func _ready() -> void:
  RoundStatus.connect("goal_enter", self, "on_enter_hole")

func _physics_process(_delta: float) -> void:
  # Clamping minimum speed to 2 px per sec
  var is_moving := velocity.length() > 5
  
  # Detect input
  if Input.is_action_pressed("ball_charge") && !is_moving:
    if (!is_charging): # Store time on first press (charging_time)
      $ChargeAudio.play()
      charging_time = OS.get_ticks_msec()
      is_charging = true
    else:
      var current_force = calculate_force(OS.get_ticks_msec() - charging_time)
      var ball_vector_divisor: int
      
      if BallData.power_ball: 
        ball_vector_divisor = 2
      else:
        ball_vector_divisor = 5
      
      $BallVector.update_force(Vector2(current_force / ball_vector_divisor, 0).rotated(deg2rad($Camera2D.rotation_degrees - 90)))
    
  if Input.is_action_just_released("ball_charge") && !is_moving:
    var camera_rotation = $Camera2D.rotation_degrees - 90
    var force = calculate_force(OS.get_ticks_msec() - charging_time)
    if BallData.power_ball:
      force *= 2

    $ChargeAudio.stop()
    $PuttAudio.play()

    print("")
    print("Shooting!")
    print("Force: " + String(force) + " at " + String(camera_rotation) + " degrees")
    print("Powerups:")
    print("- Power Ball: " + String(BallData.power_ball))
    print("- Water Ball: " + String(BallData.water_ball))
    print("")
    
    velocity = Vector2(cos(deg2rad(camera_rotation)) * force, sin(deg2rad(camera_rotation)) * force)
    is_charging = false

    # Cleanup side effects
    # Add stroke total
    BallData.stroke_total += 1;
    # Cleanup ball vector
    $BallVector.update_force(Vector2.ZERO)


  # Handle Camera
  if Input.is_action_pressed("camera_precise"):
    if Input.is_action_pressed("camera_cw"):
      $Camera2D.rotate(deg2rad(0.1))
    if Input.is_action_pressed("camera_ccw"):
      $Camera2D.rotate(deg2rad(-0.1))
  else: 
    if Input.is_action_pressed("camera_cw"):
      $Camera2D.rotate(deg2rad(1))
    if Input.is_action_pressed("camera_ccw"):
      $Camera2D.rotate(deg2rad(-1))

      
  # Handle ball bounce
  if get_slide_count() > 0:
    var collision = get_slide_collision(0)
    velocity = velocity.bounce(collision.normal)
    print("Bonk! Velocity:" + String(velocity))

    $BounceAudio.volume_db = lerp(-20, 0, velocity.length() / 600)
    $BounceAudio.play()
    velocity *= (0.999)


  velocity *= (0.99 * speed_modifier)

  # When ball has stopped moving for the first time
  if !is_moving && !printed && !RoundStatus.is_goal:
    $YourTurnAudio.play()
    BallData.stroke_count += 1;
    print("")
    print("Not moving!")
    print("Final velocity : " + String(velocity))
    print("Is in water    : " + String(is_in_water))
    print("")
    print("Next shot: Stroke ", BallData.stroke_count)
    print("")
    
    if is_in_water && !BallData.water_ball:
      BallData.stroke_count += 2
      self.global_position = initial_position
      
      print("Ball in water and no water ball! Resetting stroke count")
      print("")
    
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

func set_speed_modifier(speed: float) -> void:
  speed_modifier = speed

# Sand

# Careful for side effects of power_ball running out.
func on_enter_sand(_body: Node) -> void:
  if BallData.power_ball:
    set_speed_modifier(0.98)
  else:
    set_speed_modifier(0.95)
  
func on_leave_sand(_body:Node) -> void:
  set_speed_modifier(1.0)

# Water

func on_enter_water() -> void:
  is_in_water = true

func on_leave_water() -> void:
  is_in_water = false

# Enter Hole
func on_enter_hole() -> void:
  print("Ball entered hole")
  velocity = Vector2.ZERO
  self.visible = false
