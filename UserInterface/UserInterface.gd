extends Control

onready var scene_tree = get_tree()
onready var stroke_number: Label = get_node("StrokeNumber")

func _ready() -> void:
  BallData.connect("stroke_count_update", self, "update_interface")
  update_interface()

func update_interface() -> void:
  stroke_number.text = "Stroke: %s" % BallData.stroke_count
