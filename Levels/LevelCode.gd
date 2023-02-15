extends Node2D

func _physics_process(delta: float) -> void:
  # Checks for ball's current terrain
  var grass = $Grass
  var water = $Water

  
