extends Area2D

# Check out Autoload/BallData; PowerUpType must be the variable name
export var PowerUpType := "power_ball"
onready var anim_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body: Node) -> void:
  BallData[PowerUpType] = true
  anim_player.stop()
  self.queue_free()
