extends Control

# Enlazamos las barras de la interfaz al código
@onready var barra_hambre = $VBoxContainer/BarraHambre
@onready var barra_energia = $VBoxContainer/BarraEnergia
@onready var barra_diversion = $VBoxContainer/BarraDiversion

# Variables numéricas de las necesidades (empiezan en 100)
var hambre : float = 100.0
var energia : float = 100.0
var diversion : float = 100.0

func _ready():
	# Actualizamos visualmente las barras al iniciar el juego
	actualizar_interfaz()
	
	# Creamos un temporizador interno por código para que reste puntos cada segundo
	var timer = Timer.new()
	timer.wait_time = 1.0 # Cada 1 segundo hará un "tic"
	timer.autostart = true
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	add_child(timer)

func _process(delta):
	# Esta función se ejecuta en cada fotograma del juego.
	# Aunque el temporizador baja los puntos por segundo, actualizamos la UI constantemente.
	actualizar_interfaz()

func _on_timer_timeout():
	# Aquí defines qué tan rápido cae cada necesidad por segundo
	hambre -= 0.5
	energia -= 0.2
	diversion -= 0.8
	
	# clamp asegura que los valores no bajen de 0 ni suban de 100
	hambre = clamp(hambre, 0, 100)
	energia = clamp(energia, 0, 100)
	diversion = clamp(diversion, 0, 100)

func actualizar_interfaz():
	# Le asignamos a cada barra el valor numérico actual
	barra_hambre.value = hambre
	barra_energia.value = energia
	barra_diversion.value = diversion
