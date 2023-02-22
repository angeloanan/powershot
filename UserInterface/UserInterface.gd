extends Control

onready var scene_tree = get_tree()
onready var stroke_number: Label = get_node("StrokeNumber")
onready var stroke_total: Label = get_node("StrokeTotal")

func _ready() -> void:
  BallData.connect("stroke_count_update", self, "update_interface")
  BallData.connect("stroke_total_update", self, "update_interface")
  BallData.connect("power_ball_update", self, "update_interface")
  BallData.connect("water_ball_update", self, "update_interface")
  update_interface()

func update_interface() -> void:
  stroke_number.text = "Stroke: %s" % BallData.stroke_count
  stroke_total.text = "Total: %s" % BallData.stroke_total
  $PowerUpIcons/Powerball.visible = BallData.power_ball
  $PowerUpIcons/Waterball.visible = BallData.water_ball

