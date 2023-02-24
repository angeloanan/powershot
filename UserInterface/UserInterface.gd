extends Control

onready var scene_tree = get_tree()
onready var stroke_number: Label = get_node("StrokeNumber")

func _ready() -> void:
  BallData.connect("stroke_count_update", self, "update_interface")
  BallData.connect("stroke_total_update", self, "update_interface")
  BallData.connect("power_ball_update", self, "update_interface")
  BallData.connect("water_ball_update", self, "update_interface")
  RoundStatus.connect("par_update", self, "update_par")
  update_interface()
  update_par()

func update_interface() -> void:
  stroke_number.text = "Stroke %s" % BallData.stroke_count
  $PowerUpIcons/Powerball.visible = BallData.power_ball
  $PowerUpIcons/Waterball.visible = BallData.water_ball

func update_par() -> void:
  $ParCount.text = "Par %s" % RoundStatus.par

func hide_power_meter() -> void:
  $PowerMeter.visible = false

func show_power_meter() -> void:
  $PowerMeter.visible = true

