extends Node

signal goal_enter
signal par_update

var is_goal := false setget goal_enter
var par := 3 setget set_par

func goal_enter(v: bool):
  is_goal = v
  if is_goal:
    emit_signal("goal_enter")

func set_par(v: int):
  par = v
  emit_signal("par_update")
