extends Area2D

signal goal_enter

export var NEXT_SCENE: PackedScene

onready var ball_enter_audio = $BallEnterAudio

func _get_configuration_warning() -> String:
  if NEXT_SCENE == null:
    return "This node has no scene to load."
  return ""

func _on_body_entered(body: Node) -> void:
  RoundStatus.is_goal = true
  ball_enter_audio.play()
  yield(ball_enter_audio, "finished")

  teleport()

func teleport() -> void:
  RoundStatus.is_goal = false
  BallData.round_reset()
  get_tree().change_scene_to(NEXT_SCENE)
  

