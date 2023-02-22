extends Node

signal stroke_total_update
signal stroke_count_update
signal power_ball_update
signal water_ball_update

# The number of strokes the player has taken in the whole game
var stroke_total := 1 setget set_stroke_total

# The number of strokes the player has taken in the current hole
var stroke_count := 1 setget set_stroke_count

# Power up switches
var water_ball := false setget set_water_ball
var power_ball := false setget set_power_ball

func set_stroke_total(score: int) -> void:
  stroke_total = score
  emit_signal("stroke_total_update")

func set_stroke_count(score: int) -> void:
  stroke_count = score
  emit_signal("stroke_count_update")

func set_water_ball(state: bool) -> void:
  water_ball = state
  emit_signal("water_ball_update")

func set_power_ball(state: bool) -> void:
  power_ball = state
  emit_signal("power_ball_update")

# ----

func reset() -> void:
  stroke_total = 1
  stroke_count = 1
  
func round_reset() -> void:
  stroke_count = 1
  
  water_ball = false
  power_ball = false
