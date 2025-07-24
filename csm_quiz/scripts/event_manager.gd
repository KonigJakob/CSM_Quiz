extends Node

var flowerwallpp
var flowerwall_dithering
var flowerwall_chromatic


signal question_answered(correct : bool)

func _ready() -> void:
	flowerwallpp = get_node("/root/flowerwall_crt")
	flowerwall_dithering = flowerwallpp.get_child(0).get_child(0)
	flowerwall_dithering.material.set("shader_parameter/downscaling_strength", 1)
	flowerwall_chromatic = flowerwallpp.get_child(3).get_child(0)
	flowerwall_chromatic.material.set("shader_parameter/chromatic_aberration_strength", 0)
	
func dither_screen() -> void:
	flowerwall_dithering.get_parent().visible = true
	flowerwall_dithering.material.set("shader_parameter/downscaling_strength", 32)
	var tween = create_tween()
	tween.set_parallel(false)
	tween.tween_method(set_dithering, 32, 0, 0.3)
	tween.set_parallel(false)
	tween.tween_property(flowerwall_dithering.get_parent(), "visible", false, 0)
	
func add_chromatic_aberration() -> void:
	#flowerwall_chromatic.get_parent().visible = true
	var tween = create_tween()
	tween.tween_method(set_chromatic, 0, 10, 0.5)
	tween.set_parallel(false)
	tween.tween_method(set_chromatic, 10, 0, 0.2)
	#tween.tween_property(flowerwall_chromatic.get_parent(), "visible", false, 0)
	
func set_dithering(value) -> void:
	flowerwall_dithering.material.set("shader_parameter/downscaling_strength", value)
	
func set_chromatic(value) -> void:
	flowerwall_chromatic.material.set("shader_parameter/enable_chromatic_aberration", true)
	flowerwall_chromatic.material.set("shader_parameter/chromatic_aberration_strength", value)
