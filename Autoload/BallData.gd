extends Node

signal stroke_total_update
signal stroke_count_update

# The number of strokes the player has taken in the whole game
var stroke_total := 1 setget set_stroke_total

# The number of strokes the player has taken in the current hole
var stroke_count := 1 setget set_stroke_count

# Power up switches
var water_ball := false
var power_ball := false

func set_stroke_total(score: int) -> void:
  stroke_total = score
  emit_signal("stroke_total_update")

func set_stroke_count(score: int) -> void:
  stroke_count = score
  emit_signal("stroke_count_update")

func reset() -> void:
  stroke_total = 1
  stroke_count = 1
  
func round_reset() -> void:
  stroke_count = 1
