extends Control

onready var anim_player = $AnimationPlayer

func _ready() -> void:
  anim_player.play("CoinBlink")

func _input(event: InputEvent) -> void:
  if event.is_action_pressed("coin_add"):
    get_tree().change_scene_to(load("res://Levels/Level1.tscn"))
