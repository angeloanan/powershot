extends Node

signal goal_enter

var is_goal := false setget goal_enter

func goal_enter(v: bool):
  is_goal = v
  if is_goal:
    emit_signal("goal_enter")
