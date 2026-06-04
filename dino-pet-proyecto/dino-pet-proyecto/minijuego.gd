extends Control

# Le enseñamos a esta escena dónde está el archivo de la moneda que creamos antes
var escena_moneda = preload("res://moneda.tscn")

func _on_timer_timeout():
	# Esta función se ejecuta cada 1 segundo
	# 1. "Instanciamos" (clonamos) la moneda
	var nueva_moneda = escena_moneda.instantiate()
	
	# 2. Le damos una posición aleatoria en el eje X (de izquierda a derecha), arriba de la pantalla (Y = -100)
	var posicion_x_aleatoria = randf_range(50.0, 490.0) 
	nueva_moneda.position = Vector2(posicion_x_aleatoria, -100)
	
	# 3. La metemos a la escena para que aparezca
	add_child(nueva_moneda)

func _on_button_volver_pressed():
	# Regresamos a la casa
	get_tree().change_scene_to_file("res://mundo_principal.tscn")
