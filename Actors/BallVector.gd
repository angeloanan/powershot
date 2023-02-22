extends Node2D

var force := Vector2.ZERO

func _draw() -> void:
  var line_color := Color.black
  var line_thickness := 2
  
  if BallData.power_ball:
    line_thickness = 4

  if BallData.water_ball:
    line_color = Color.blue

  draw_line(Vector2.ZERO, force, line_color, line_thickness, true)
  $RayCast2D.cast_to = force
  # TODO: Recursive function that draws a line for each force's bounce normal

func update_force(new_force: Vector2) -> void:
  self.force = new_force
  update()
