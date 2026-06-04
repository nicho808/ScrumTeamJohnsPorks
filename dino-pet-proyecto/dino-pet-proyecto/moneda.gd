extends Button

var velocidad : float = 200.0 # Qué tan rápido cae la moneda

func _process(delta):
	# Hacemos que la moneda se mueva hacia abajo constantemente
	position.y += velocidad * delta
	
	# Si la moneda se sale de la pantalla (más de 1000 píxeles hacia abajo), la borramos para no gastar memoria
	if position.y > 1000:
		queue_free() # queue_free() es la forma en que Godot destruye un nodo

# Conecta la señal 'pressed()' del botón a este script antes de pegar lo siguiente:
func _on_pressed():
	Global.monedas += 1        # Ganamos dinero
	Global.diversion += 5.0    # Jugar nos divierte
	print("¡Moneda atrapada! Tienes: ", Global.monedas)
	
	# Destruimos la moneda porque ya la atrapamos
	queue_free()
