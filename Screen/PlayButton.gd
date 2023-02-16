extends Button

func _on_pressed() -> void:
  play_game()

func play_game() -> void:
  BallData.reset()
  get_tree().change_scene("res://Levels/LevelTemplate.tscn")
