# Warhammer 40K Boltgun - Godot Game

Um jogo FPS retro inspirado em Warhammer 40000 Boltgun, desenvolvido com Godot 4.

**✨ Agora com suporte completo para Mobile/Android! ✨**

## 🎮 Sobre o Projeto

Este é um projeto base para um shooter em primeira pessoa inspirado no estilo retro e na jogabilidade rápida de Warhammer 40000: Boltgun. O jogo apresenta mecânicas clássicas de FPS boomer shooter com a estética grimdark do universo Warhammer 40K.

**Compatível com Desktop (Windows, Linux, Mac) e Mobile (Android, iOS)**

## ✨ Características

### Sistema de Jogador
- **Movimento FPS completo**: WASD para movimento, mouse para olhar
- **Sistema de dash**: Shift para sprint, Shift duplo para dash
- **Sistema de pulo**: Barra de espaço
- **Sistema de vida e armadura**: 100 de vida base, 100 de armadura
- **Controle de mouse suave** com sensibilidade ajustável

### Sistema de Armas
- **Boltgun**: Arma principal inspirada no icônico Boltgun do Warhammer 40K
- **Sistema de munição**: Munição no pente e munição de reserva
- **Sistema de recarga**: Tecla R para recarregar
- **Troca de armas**: Scroll do mouse ou teclas numéricas
- **Sistema modular** para adicionar novas armas facilmente

### Sistema de Inimigos
- **IA básica** com estados: Idle, Patrol, Chase, Attack
- **Sistema de navegação** usando NavigationAgent3D
- **Detecção de jogador** por raio de alcance
- **Sistema de combate** com cooldown de ataque
- **Sistema de dano e morte**

### Interface do Usuário
- **HUD completo** mostrando:
  - Vida do jogador (vermelho)
  - Armadura do jogador (azul)
  - Arma atual (amarelo)
  - Munição atual e reserva (branco)
- **Crosshair centralizado** (verde)
- **Menu principal** com opções de jogar, configurações e sair
- **HUD adaptável** que se ajusta automaticamente para mobile

### Controles Mobile
- **Joystick virtual** para movimento (lado esquerdo)
- **Botões touch** para todas as ações:
  - Fire (atirar) - botão grande inferior direito
  - Jump (pular) - superior direito
  - Reload (recarregar) - superior centro
  - Dash - superior esquerdo
- **Touch and drag** na metade direita da tela para olhar ao redor
- **Detecção automática** de plataforma (mostra controles apropriados)

### Sistemas Adicionais
- **Sistema de pickups**: Vida, armadura e munição
- **Sistema de projéteis**: Para armas que disparam projéteis físicos
- **Game Manager**: Gerenciamento de pontuação, kills e progresso
- **Level de teste**: Arena básica com inimigos para testar mecânicas

## 🎯 Controles

### Desktop (PC/Mac/Linux)

| Ação | Tecla/Botão |
|------|-------------|
| Mover | W, A, S, D |
| Olhar | Mouse |
| Pular | Espaço |
| Sprint | Shift (segurar) |
| Dash | Shift (duplo) |
| Atirar | Botão esquerdo do mouse |
| Recarregar | R |
| Ataque corpo a corpo | F |
| Próxima arma | Scroll para cima |
| Arma anterior | Scroll para baixo |
| Menu | ESC |

### Mobile (Android/iOS)

| Ação | Controle |
|---export_presets.cfg      # Configurações de exportação (Android, etc)
├── icon.svg               # Ícone do projeto
├── .gitignore            # Arquivos ignorados pelo Git
├── docs/                 # Documentação
│   ├── ANDROID_BUILD.md  # Guia de build Android
│   └── MOBILE_CONTROLS.md # Guia de controles mobile
├── scenes/               # Cenas do jogo
│   ├── main_menu.tscn   # Menu principal
│   ├── player.tscn      # Cena do jogador
│   ├── enemies/         # Cenas de inimigos
│   │   └── enemy.tscn
│   ├── weapons/         # Cenas de armas
│   │   └── boltgun.tscn
│   ├── pickups/         # Itens coletáveis
│   │   └── pickup.tscn
│   ├── projectile.tscn  # Projéteis
│   ├── ui/              # Interface do usuário
│   │   ├── hud.tscn
│   │   ├── mobile_controls.tscn
│   │   ├── virtual_joystick.tscn
│   │   └── touch_button.tscn
│   └── levels/          # Níveis do jogo
│       └── test_level.tscn
└── scripts/             # Scripts GDScript
    ├── player.gd
    ├── enemy.gd
    ├── weapon.gd
    ├── weapon_manager.gd
    ├── pickup.gd
    ├── projectile.gd
    ├── game_manager.gd
    ├── weapons/
    │   └── boltgun.gd
    └── ui/
        ├── hud.gd
        ├── main_menu.gd
        ├── mobile_controls.gd
        ├── virtual_joystick.gd
        └── touch_button
│   └── levels/          # Níveis do jogo
│       └── test_level.tscn
└── scripts/             # Scripts GDScript
    ├── player.gd
    ├── enemy.gd
    ├── weapon.gd
    ├── weapon_manager.gd
    ├── pickup.gd
    ├── projectile.gd
    ├── game_manager.gd
    ├── weapons/
    │   └── boltgun.gd
    └── ui/
        ├── hud.gd
        └── main_menu.gd
```

## 🚀 Como Executar

1. **Instalar o Godot 4.x**
   - Baixe e instale o Godot 4.3 ou superior em [godotengine.org](https://godotengine.org)

2. **Clonar o Repositório**
   ```bash
   git clone https://github.com/pimentelleo/sample-copilot-godot.git
   cd sample-copilot-godot
   ```

### 📱 Para Android

Consulte o guia completo de build Android em [docs/ANDROID_BUILD.md](docs/ANDROID_BUILD.md)

**Resumo rápido:**
1. Instale Android Studio e o Android SDK
2. Configure o caminho do SDK no Godot (Editor > Editor Settings > Export > Android)
3. Instale o template de exportação Android para Godot 4
4. Vá em Project > Export > Add > Android
5. Configure o preset e exporte o APK

**Build rápido via linha de comando:**
```bash
godot --export-release "Android" ./builds/android/wh40k-boltgun.apk
```

3. **Abrir no Godot**
   - Abra o Godot Engine
   - Clique em "Import"
   - Navegue até a pasta do projeto e selecione `project.godot`
   - Clique em "Import & Edit"

4. **Executar o Jogo**
### Core Features
- [ ] Adicionar mais tipos de armas (Plasma Gun, Chainsaw, etc.)
- [ ] Implementar sistema de som e música
- [ ] Adicionar efeitos visuais (sangue, explosões, partículas)
- [ ] Criar mais tipos de inimigos
- [ ] Implementar sistema de boss
- [ ] Adicionar power-ups especiais
- [ ] Criar sistema de níveis/campanha
- [ ] Implementar sistema de save/load
- [ ] Adicionar menu de opções (gráficos, áudio, controles)
- [ ] Melhorar texturas e modelos 3D
- [ ] Adicionar animações de armas
- [ ] Implementar sistema de glory kills (execuções)

### Mobile Enhancements
- [ ] Adicionar suporte a gyroscope para mira
- [ ] Implementar feedback háptico
- [ ] Criar layout customizável de botões
- [ ] Adicionar diferentes esquemas de controle
- [ ] Otimizar performance para dispositivos low-end
- [ ] Suporte para diferentes resoluções de tela
- [ ] Salvar preferências de sensibilidade e layout
1. Crie um novo script que herda de `Enemy`
2. Ajuste as propriedades (vida, dano, velocidade, etc.)
3. Customize o comportamento nos métodos de estado
4. Crie a cena do inimigo com modelo e colliders

### Criar Novos Níveis
1. Crie uma nova cena 3D
2. Adicione um `NavigationRegion3D` para navegação de inimigos
3. Instancie o jogador (grupo "playe

## 📱 Plataformas Suportadas

- ✅ **Windows** (64-bit)
- ✅ **Linux** (64-bit)
- ✅ **macOS** (Intel e Apple Silicon)
- ✅ **Android** (5.0+ / API 21+, arm64-v8a)
- ⚠️ **iOS** (possível, requer Mac para build)
- ⚠️ **Web** (HTML5 - possível via export)

## 🔧 Requisitos Técnicos

### Desktop
- **OS**: Windows 10+, Ubuntu 20.04+, macOS 10.15+
- **Processor**: Dual-core 2.0 GHz+
- **Memory**: 2 GB RAM
- **Graphics**: OpenGL 3.3 compatible
- **Storage**: 500 MB

### Mobile (Android)
- **OS**: Android 5.0 (Lollipop) or higher
- **Processor**: ARM64 (64-bit)
- **Memory**: 1 GB RAM minimum, 2 GB recommended
- **Graphics**: OpenGL ES 3.0 compatible
- **Storage**: 200 MB
- **Recommended**: Android 8.0+ for best performancer")
4. Adicione inimigos, pickups e geometria do nível
5. Adicione o HUD

## 📝 TODO / Próximas Funcionalidades

- [ ] Adicionar mais tipos de armas (Plasma Gun, Chainsaw, etc.)
- [ ] Implementar sistema de som e música
- [ ] Adicionar efeitos visuais (sangue, explosões, partículas)
- [ ] Criar mais tipos de inimigos
- [ ] Implementar sistema de boss
- [ ] Adicionar power-ups especiais
- [ ] Criar sistema de níveis/campanha
- [ ] Implementar sistema de save/load
- [ ] Adicionar menu de opções (gráficos, áudio, controles)
- [ ] Melhorar texturas e modelos 3D
- [ ] Adicionar animações de armas
- [ ] Implementar sistema de glory kills (execuções)

## 🎨 Estilo Visual

O jogo busca replicar o estilo retro de boomer shooters:
- Texturas low-poly e pixeladas
- Cores vibrantes e alto contraste
- Movimento rápido e responsivo
- Interface minimalista e funcional
- Estética grimdark do Warhammer 40K

## 📄 Licença

Este é um projeto de exemplo/estudo. Warhammer 40,000 é propriedade da Games Workshop.

## 🤝 Contribuindo

Contribuições são bem-vindas! Sinta-se livre para:
- Reportar bugs
- Sugerir novas funcionalidades
- Enviar pull requests
- Melhorar a documentação

## 👤 Autor

**pimentelleo**
- GitHub: [@pimentelleo](https://github.com/pimentelleo)

---

**Nota**: Este é um projeto base/template. Muitas funcionalidades ainda precisam ser implementadas e polidas. Use como ponto de partida para criar seu próprio jogo FPS no Godot!