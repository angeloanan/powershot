extends Area2D

signal goal_enter

export var NEXT_SCENE: PackedScene

onready var ball_enter_audio = $BallEnterAudio
onready var golf_clap_audio = $GolfClapAudio

func _get_configuration_warning() -> String:
  if NEXT_SCENE == null:
    return "This node has no scene to load."
  return ""

func _on_body_entered(body: Node) -> void:
  RoundStatus.is_goal = true
  ball_enter_audio.play()

  var delay := Timer.new()
  add_child(delay)
  delay.wait_time = 0.5
  delay.one_shot = true
  delay.start()

  yield(delay, "timeout")

  golf_clap_audio.play()
  yield(golf_clap_audio, "finished")

  teleport()

func teleport() -> void:
  RoundStatus.is_goal = false
  BallData.round_reset()
  get_tree().change_scene_to(NEXT_SCENE)
  

