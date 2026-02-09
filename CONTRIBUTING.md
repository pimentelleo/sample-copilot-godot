# Warhammer 40K Boltgun - Godot Game
# Desenvolvimento

## Guia de Contribuição

### Configuração do Ambiente

1. Instale o Godot 4.3+
2. Clone o repositório
3. Abra o projeto no Godot
4. Execute o teste level para verificar se tudo funciona

### Convenções de Código

#### Nomenclatura
- **Classes**: PascalCase (ex: `PlayerController`, `WeaponSystem`)
- **Funções/Métodos**: snake_case (ex: `update_health`, `take_damage`)
- **Variáveis**: snake_case (ex: `current_health`, `max_ammo`)
- **Constantes**: UPPER_SNAKE_CASE (ex: `MAX_SPEED`, `DEFAULT_DAMAGE`)
- **Sinais**: snake_case com sufixo descritivo (ex: `health_changed`, `weapon_fired`)

#### Estrutura de Scripts
```gdscript
extends BaseClass
class_name ClassName

# Exports primeiro
@export var public_variable: Type = default_value

# Variáveis públicas
var public_var: Type

# Variáveis privadas (prefixo _)
var _private_var: Type

# Onready variables
@onready var node_ref: Node = $NodePath

# Sinais
signal signal_name(param: Type)

func _ready():
    pass

func _process(delta: float):
    pass

func public_method():
    pass

func _private_method():
    pass
```

### Organização de Pastas

```
scenes/          # Todas as cenas .tscn
  ├── player/
  ├── enemies/
  ├── weapons/
  ├── ui/
  └── levels/

scripts/         # Todos os scripts .gd
  ├── player/
  ├── enemies/
  ├── weapons/
  └── ui/

assets/          # Assets do jogo
  ├── textures/
  ├── models/
  ├── sounds/
  └── music/
```

### Sistema de Layers de Colisão

1. **Layer 1 (World)**: Geometria estática do mundo
2. **Layer 2 (Player)**: Jogador
3. **Layer 3 (Enemy)**: Inimigos
4. **Layer 4 (Projectile)**: Projéteis
5. **Layer 5 (Pickups)**: Itens coletáveis

### Criando Novas Armas

1. Crie um script que herda de `Weapon`:
```gdscript
extends Weapon

func _ready():
    super._ready()
    weapon_name = "MinhaArma"
    damage = 50
    fire_rate = 0.2
    max_ammo = 30
    # ... outras propriedades
```

2. Crie a cena da arma:
   - Node3D raiz com o script
   - RayCast3D para detecção de hits
   - MeshInstance3D para o modelo
   - MuzzleFlash (Node3D)
   - AudioStreamPlayer3D para sons

3. Adicione ao WeaponManager

### Criando Novos Inimigos

1. Herde de `Enemy`:
```gdscript
extends Enemy

func _ready():
    super._ready()
    max_health = 100
    damage = 20
    movement_speed = 7.0
```

2. Customize comportamentos:
   - `idle_behavior()`
   - `patrol_behavior()`
   - `chase_behavior(delta)`
   - `attack_behavior(delta)`

### Sistema de Sinais

Use sinais para comunicação entre sistemas:
```gdscript
# No emissor
signal enemy_killed(enemy_type: String, position: Vector3)

func die():
    emit_signal("enemy_killed", enemy_type, global_position)

# No receptor
func _ready():
    enemy.enemy_killed.connect(_on_enemy_killed)
    
func _on_enemy_killed(enemy_type: String, position: Vector3):
    # Reagir à morte do inimigo
```

### Debugging

- Use `print()` para logs básicos
- Use `print_debug()` para logs que aparecem apenas em debug
- Use o Debugger do Godot (F5 para debug mode)
- Remote Scene Tree para inspecionar nodes em tempo real

### Testing

Ao adicionar novas funcionalidades:
1. Teste no test_level primeiro
2. Verifique colisões nas diferentes layers
3. Teste com múltiplos inimigos
4. Verifique performance (FPS)

### Performance

Otimizações importantes:
- Use `@onready` para cachear referências de nodes
- Evite `get_node()` em `_process()` ou `_physics_process()`
- Use object pooling para projéteis e efeitos
- Limite o número de raycasts por frame
- Use LOD (Level of Detail) em modelos complexos

### Commit Messages

Use mensagens claras:
```
feat: adiciona nova arma plasma gun
fix: corrige bug de colisão com inimigos
refactor: melhora sistema de navegação de IA
docs: atualiza README com novos controles
```

## Roadmap de Desenvolvimento

### Fase 1 - Core Gameplay ✅
- [x] Sistema de movimento do jogador
- [x] Sistema de armas básico
- [x] IA de inimigos básica
- [x] HUD e UI
- [x] Sistema de pickups

### Fase 2 - Conteúdo
- [ ] Adicionar 5+ tipos de armas
- [ ] Adicionar 5+ tipos de inimigos
- [ ] Criar 3 níveis jogáveis
- [ ] Sistema de boss fights

### Fase 3 - Polish
- [ ] Adicionar sons e música
- [ ] Efeitos visuais (partículas, sangue, etc)
- [ ] Animações de armas
- [ ] Menu de opções completo

### Fase 4 - Features Avançadas
- [ ] Sistema de save/load
- [ ] Achievements
- [ ] Modo horda/arena
- [ ] Leaderboards local

## Recursos Úteis

- [Documentação do Godot 4](https://docs.godotengine.org/)
- [GDScript Style Guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html)
- [Godot Engine Q&A](https://ask.godotengine.org/)
- [r/godot](https://reddit.com/r/godot)
