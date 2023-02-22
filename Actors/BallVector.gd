extends Node2D

var force := Vector2.ZERO

func _draw() -> void:
  $RayCast2D.cast_to = force
  # TODO: Recursive function that draws a line for each force's bounce normal

func update_force(new_force: Vector2) -> void:
  self.force = new_force
  update()
