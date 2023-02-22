extends Area2D

export var NEXT_SCENE: PackedScene

func _get_configuration_warning() -> String:
  if NEXT_SCENE == null:
    return "This node has no scene to load."
  return ""

func _on_body_entered(body:Node) -> void:
  BallData.stroke_total += 1
  teleport()

func teleport() -> void:
  BallData.round_reset()
  get_tree().change_scene_to(NEXT_SCENE)
  

