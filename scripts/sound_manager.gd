extends Node

var bus_index: int = -1

func _ready():
	bus_index = AudioServer.bus_count
	AudioServer.add_bus()
	AudioServer.set_bus_name(bus_index, "SFX")
	AudioServer.set_bus_volume_db(bus_index, 0.0)
	AudioServer.set_bus_send(bus_index, "Master")

func play_flap():
	_generate_and_play(440, 0.08, 0.15)

func play_score():
	_generate_and_play(880, 0.1, 0.2)

func play_death():
	_generate_and_play(220, 0.3, 0.25)

func play_ui():
	_generate_and_play(660, 0.05, 0.1)

func _generate_and_play(frequency: float, duration: float, volume: float):
	var sample_rate = 44100
	var num_samples = int(sample_rate * duration)
	var stream = AudioStreamWAV.new()
	var data = PackedByteArray()

	for i in range(num_samples):
		var t = float(i) / float(sample_rate)
		var envelope = 1.0 - (float(i) / float(num_samples))
		var sample = sin(TAU * frequency * t) * envelope * volume
		var int_sample = int(sample * 32767.0)
		data.append(int_sample & 0xFF)
		data.append((int_sample >> 8) & 0xFF)

	stream.format = AudioStreamWAV.FORMAT_16_BITS
	stream.mix_rate = sample_rate
	stream.stereo = false
	stream.data = data

	var player = AudioStreamPlayer.new()
	player.stream = stream
	player.bus = "SFX"
	add_child(player)
	player.play()
	player.finished.connect(func(): player.queue_free())
