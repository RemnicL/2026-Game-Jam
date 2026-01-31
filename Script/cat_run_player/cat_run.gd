extends CharacterBody2D

@export var speed: float = 600.0
@export var jump_velocity: float = -700.0
@onready var anim: AnimatedSprite2D = $Cat
@onready var ColR: CollisionPolygon2D = $CollisionR
@onready var ColL: CollisionPolygon2D = $CollisionL


var gravity: float = 1500.0#float(ProjectSettings.get_setting("physics/2d/default_gravity"))
func _physics_process(delta: float) -> void:
	print(gravity)

	# 重力
	if not is_on_floor():
		velocity.y += gravity * delta

	# 左右输入：-1 / 0 / 1
	var dir := Input.get_axis("move_left", "move_right")
	velocity.x = dir * speed

	# 跳跃
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# 移动（Godot 4 的角色标准写法）
	move_and_slide()
	
	if dir != 0:
		anim.play("Move")
		print("local:", scale, " global:", global_scale) 
		print("parent scale:", get_parent().scale if get_parent() else "no parent") # 动画
		if dir < 0:
			anim.flip_h = false
			anim.position.x = 0
			ColL.disabled = false
			ColR.disabled = true
			
			
		else:
			anim.flip_h = true
			anim.position.x = -73
			ColL.disabled = true
			ColR.disabled = false
			
			
	else:
		anim.stop()
