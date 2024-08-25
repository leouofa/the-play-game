extends BadGuy

func _on_hitbox_area_entered(area):
	if area.has_method("bullet_deal_damage"):
		var damage = area.bullet_deal_damage()
		take_damage(damage)
		area.remove_bullet()

func _on_flash_timer_timeout():
	animated_sprite.material.set_shader_parameter("flash_color", default_flash_color)
	animated_sprite.material.set_shader_parameter("flash_modifier", default_flash_modifier)

func _on_killzone_body_entered(body):
	Autoload.take_damage(body, PLAYER_DAMAGE)

func post_death():
	print("new initial_post_death")
