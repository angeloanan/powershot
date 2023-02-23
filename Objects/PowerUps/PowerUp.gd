extends Area2D

# Check out Autoload/BallData; PowerUpType must be the variable name
export var PowerUpType := "power_ball"
onready var anim_player: AnimationPlayer = $AnimationPlayer
onready var sfx: AudioStreamPlayer = $PowerUpAudio

func _on_body_entered(body: Node) -> void:
  
  sfx.play()
  anim_player.stop()
  self.visible = false
  
  BallData[PowerUpType] = true

  yield(sfx, "finished")
  
  self.queue_free()
  
