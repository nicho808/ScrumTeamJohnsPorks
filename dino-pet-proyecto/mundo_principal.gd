extends Control

# Enlazamos las barras de la interfaz
@onready var barra_hambre = $VBoxContainer/BarraHambre
@onready var barra_energia = $VBoxContainer/BarraEnergia
@onready var barra_diversion = $VBoxContainer/BarraDiversion

# Enlazamos el filtro de oscuridad que creamos
@onready var filtro_noche = $FiltroNoche

# Variables numéricas de las necesidades
var hambre : float = 100.0
var energia : float = 100.0
var diversion : float = 100.0

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
	# Si está durmiendo, no podemos alimentarlo
	if esta_durmiendo:
		print("¡No puedes alimentar a una mascota dormida!")
		return # Corta la función aquí y no hace lo de abajo
		
	hambre += 20.0
	hambre = clamp(hambre, 0, 100)

# NUEVA FUNCIÓN: Al presionar el botón de Dormir
func _on_button_2_pressed(): # Nota: El nombre puede variar según el orden de tu botón, asegúrate que coincida con tu señal.
	# Invertimos el estado: si era falso se vuelve verdadero, si era verdadero se vuelve falso.
	esta_durmiendo = !esta_durmiendo
	
	if esta_durmiendo:
		filtro_noche.visible = true
		print("La mascota se ha dormido.")
	else:
		filtro_noche.visible = false
		print("La mascota se ha despertado.")
