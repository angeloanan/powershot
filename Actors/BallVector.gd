extends Node2D

var force := Vector2.ZERO

func _draw() -> void:
  draw_line(Vector2(0, 0), force, Color.blue, 8)

func update_force(new_force: Vector2) -> void:
  self.force = new_force
  update()
