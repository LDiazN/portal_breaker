extends Particles2D
var timer = Timer.new();

func _ready():
	timer.connect("timeout", self, "destroyParticles");

func activateParticles():
	emitting = true;
	timer.start(0.95);
	
func deactivateParticles():
	emitting = false;
	
func destroyParticles():
	queue_free();