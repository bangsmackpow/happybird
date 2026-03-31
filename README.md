# Flappy Family - Flappy Bird Clone for Android

A Godot 4 Flappy Bird clone with family member competition features.

## Features

- **Player Profiles** - Each family member creates their own profile
- **Leaderboard** - See who has the highest score across all players
- **Score Tracking** - High score, games played, and total score per player
- **Procedural Sound Effects** - All sounds generated in-code, no external assets needed
- **Geometric Graphics** - Everything drawn with code, no image assets required

## Project Structure

```
├── project.godot              # Godot 4 project config
├── export_presets.cfg         # Android export settings
├── scenes/
│   ├── Game.tscn              # Main game scene
│   ├── Bird.tscn              # Bird player character
│   ├── Pipe.tscn              # Pipe obstacle
│   ├── PipeManager.tscn       # Pipe spawner & manager
│   ├── Ground.tscn            # Scrolling ground
│   ├── PlayerSelectScreen.tscn # Start screen / profile picker
│   └── LeaderboardScreen.tscn # Family leaderboard
└── scripts/
    ├── game.gd                # Main game logic
    ├── bird.gd                # Bird physics & drawing
    ├── pipe.gd                # Pipe drawing & behavior
    ├── pipe_manager.gd        # Pipe spawning & collision
    ├── ground.gd              # Ground scrolling & drawing
    ├── player_manager.gd      # Player profiles & save system
    ├── sound_manager.gd       # Procedural sound effects
    ├── player_select_screen.gd # Profile selection UI
    ├── game_over_screen.gd    # Game over UI
    ├── leaderboard_screen.gd  # Leaderboard UI
    └── hud.gd                 # In-game HUD
```

## Building for Android

### Prerequisites

1. **Godot 4.2+** - Download from https://godotengine.org/download
2. **Android SDK Command Line Tools** - Install via Android Studio or standalone
3. **JDK 17** - Required by Gradle
4. **Android Build Template** - Godot will prompt to install it

### Setup Steps

1. Open the project in Godot 4
2. Go to **Project > Install Android Build Template** (this creates the `android/build` directory)
3. Go to **Project > Export...**
4. Add the Android preset if not already present
5. Configure your keystore for signing:
   - Go to **Project > Export > Android**
   - Under **Keystore**, set your keystore path, user, and password
6. Set the correct SDK paths in **Editor Settings > Android**:
   - ADB Path
   - SDK Path
   - Jarsigner Path
   - OpenJDK Path

### Exporting

1. **Project > Export...**
2. Select the Android preset
3. Click **Export Project** to generate an APK
4. Or click **Export With Debug** for a debug build

### Installing on Device

```bash
adb install FlappyFamily.apk
```

Or use Godot's **Remote Debug** feature to deploy directly to a connected device.

## How to Play

1. **Start Screen** - Enter a name and tap "Add" to create a player profile
2. **Select Player** - Tap your name, then tap "Play as [name]"
3. **Game** - Tap the screen to flap and avoid pipes
4. **Game Over** - See your score, retry, check the leaderboard, or go home
5. **Leaderboard** - View all family members ranked by high score

## Game Mechanics

- **Gravity**: 1200 px/s²
- **Flap velocity**: -400 px/s
- **Max fall speed**: 600 px/s
- **Pipe speed**: 300 px/s
- **Pipe gap**: 220px
- **Spawn interval**: 1.8 seconds
- **Pipe gap range**: 180-550px from top
