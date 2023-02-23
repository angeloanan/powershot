extends Control

onready var anim_player = $AnimationPlayer
onready var coin_insert_audio = $CoinInsertAudio

func _ready() -> void:
  anim_player.play("RESET")
  $"Insert Coin".visible = true
  
  anim_player.play("CoinBlink")

func _input(event: InputEvent) -> void:
  if event.is_action_pressed("coin_add"):
    coin_insert_audio.play()
    anim_player.play("CoinBlinkFast")
    yield(coin_insert_audio, "finished")
    
    BallData.reset()
    anim_player.play("RESET")
    get_tree().change_scene_to(load("res://Levels/Level1.tscn"))
