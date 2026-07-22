class_name ScreenManager
extends Node

@export var content: Control

var current_screen: Control

func show(scene: PackedScene):
    if current_screen:
        current_screen.queue_free()

    current_screen = scene.instantiate()
    content.add_child(current_screen)