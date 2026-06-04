extends Control

# Enlazamos el texto que muestra las monedas
@onready var label_monedas = $LabelMonedas

func _ready():
	# Actualizamos el texto apenas entramos a la tienda
	actualizar_texto_monedas()

func actualizar_texto_monedas():
	# Usamos el valor que está guardado en nuestro Autoload Global
	label_monedas.text = "Monedas: " + str(Global.monedas)

# Función para el botón de comprar
func _on_button_comprar_pressed():
	if Global.monedas >= 10:
		Global.monedas -= 10     # Restamos dinero
		Global.manzanas += 1     # Sumamos comida al inventario
		actualizar_texto_monedas()
		print("Compraste una manzana. Tienes: ", Global.manzanas)
	else:
		print("No tienes suficiente dinero.")

# Función para volver a la casa
func _on_button_volver_pressed():
	# Regresamos a la escena principal
	get_tree().change_scene_to_file("res://mundo_principal.tscn")
