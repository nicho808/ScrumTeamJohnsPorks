extends Control

# Enlazamos las barras de la interfaz
@onready var barra_hambre = $VBoxContainer/BarraHambre
@onready var barra_energia = $VBoxContainer/BarraEnergia
@onready var barra_diversion = $VBoxContainer/BarraDiversion

# Enlazamos el filtro de oscuridad que creamos
@onready var filtro_noche = $FiltroNoche
@onready var godzilla_dormido = $godzilla_dormido

# Ahora los valores vienen del Global y no de aquí mismo
var hambre : float :
	get: return Global.hambre
	set(val): Global.hambre = val

var energia : float :
	get: return Global.energia
	set(val): Global.energia = val

var diversion : float :
	get: return Global.diversion
	set(val): Global.diversion = val

# NUEVA VARIABLE: Estado de la mascota
var esta_durmiendo : bool = false

func _ready():
	actualizar_interfaz()
	
	# Temporizador por segundo
	var timer = Timer.new()
	timer.wait_time = 1.0 
	timer.autostart = true
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	add_child(timer)

func _process(_delta):
	actualizar_interfaz()

func _on_timer_timeout():
	# Si está durmiendo, la lógica cambia completamente
	if esta_durmiendo:
		energia += 2.0     # La energía se recupera rápido
		hambre -= 0.1      # El hambre cae MUCHO más lento mientras duerme
		# La diversión no cae ni sube porque está inconsciente jeje
	else:
		# Lógica normal cuando está despierto (la que ya tenías)
		hambre -= 0.5
		energia -= 0.2
		diversion -= 0.8
	
	# Mantener límites entre 0 y 100
	hambre = clamp(hambre, 0, 100)
	energia = clamp(energia, 0, 100)
	diversion = clamp(diversion, 0, 100)

func actualizar_interfaz():
	barra_hambre.value = hambre
	barra_energia.value = energia
	barra_diversion.value = diversion

# Tu función anterior de alimentar
func _on_button_pressed():
	# Si está durmiendo, cortamos la función
	if esta_durmiendo:
		print("¡No puedes alimentar a una mascota dormida!")
		return 
		
	# Revisamos si tenemos comida en el script Global
	if Global.filetes > 0:
		Global.filetes -= 1       # Restamos una manzana del inventario
		hambre += 20.0             # Subimos el hambre
		hambre = clamp(hambre, 0, 100)
		print("¡Ñam! Filetes restantes: ", Global.filetes)
	else:
		print("No tienes comida. ¡Ve a la tienda!")
		
	actualizar_interfaz()

# NUEVA FUNCIÓN: Al presionar el botón de Dormir
func _on_button_2_pressed(): # Nota: El nombre puede variar según el orden de tu botón, asegúrate que coincida con tu señal.
	# Invertimos el estado: si era falso se vuelve verdadero, si era verdadero se vuelve falso.
	esta_durmiendo = !esta_durmiendo
	
	if esta_durmiendo:
		filtro_noche.visible = true
		godzilla_dormido.visible = true
		print("La mascota se ha dormido.")
	else:
		filtro_noche.visible = false
		godzilla_dormido.visible = false
		print("La mascota se ha despertado.")


func _on_button_tienda_pressed() -> void: # El nombre dependerá de cómo se llamó tu botón
	# Esta línea le dice a Godot que destruya esta escena y abra la tienda
	get_tree().change_scene_to_file("res://tienda.tscn")
	pass
