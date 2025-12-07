# 🦖 Dino Runner Game
A 2D Chrome Dino inspired infinite runner game made in Godot.

## 🥐 Overview
The core mechanics of this game was built following a tutorial by [Coding With Russ on YouTube](https://www.youtube.com/watch?v=nKBhz6oJYsc). I added my own features including:
- **Wardrobe system:** allows you to switch between 4 dinos.
- **Dynamic sprite switching:** based on the selected dino.
- **Custom collision layers:** prevent wardrobe features interfering with gameplay.
- **Mouse click interactions:** on wardrobe items.
- **Downward acceleration:** press the `down` button to make dino fall faster.
- **Clean code organization:** scripts are placed in separate scripts folder instead of scenes folder.
- **Dynamic cursor visibility changing:** for cleaner display when game is running.

## 🎀 The Process
Despite having a detailed tutorial showing the step-by-step process of building this game, it was still quite the challenge. My purpose in doing this project was to learn the `gdscript` syntax and familiarize myself with game development. I took notes on the approach used to create each element and the basic game structure.

After recreating the base game, I added a few of my own features which took me a while to figure out. The wardrobe feature took me the longest to implement because I wanted to have an interactive display. Creating new features also led me to discover new instructions like the `set_mouse_mode` function.

## 🌼 What I learned
- **Project structure and organization:** I learned about element hierarchy and how to add child nodes/scenes.
- **Proper godot sprite usage:** It is important that the sizes of images or other types of visual media that you use are deliberate to avoid unwanted bugs.
- **Scene instantiation:** Since each obstacle was a different scene, they all had to be loaded before the game could start running. 
- **Parallax2D:** The background is made using a `Node2D` node with child `Parallax2D` and `Sprite2D` nodes. It was fun seeing the background come to life.
- **`_physics_process()`:** The different forces that made the dino jump up and fall back down.
- **Collision areas:** The core mechanic of the entire game. Used to check whether the player has lost, and also used in the wardrobe screen.
- **Accepting and processing user input:** This allows the player to actually interact with the game and allowed for the fun interaction with the dinos in the wardrobe screen.
- **Performance optimization:** Obstacles that had gone out of frame get deleted. This is important since it is wasted memory space as the array fills up the stackframe, eventually leading to a crash.

## 🕹️ How to Play
1. Go to the [Releases](https://github.com/stephkmn/dino-runner/releases) page.
2. Download the ZIP file for your operating system.
3. Extract the ZIP folder.
4. Run the executable (`DinoRunner.exe` on Windows, `DinoRunner.app` on Mac, etc.).
### macOS Users
1. Download and unzip the file.
2. Right-click `DinoRunner.app` → **Open** (don’t double-click!).
3. Click **“Open”** in the warning dialog.
> This bypasses Apple’s notarization requirement for indie developers.

## 🔍 Demo
![Demo](https://github.com/stephkmn/dino-runner/blob/readme-fchange/dino-runner-demo.mp4)

## 🎨 Credits
- **Original tutorial:** [Coding With Russ](https://www.youtube.com/watch?v=nKBhz6oJYsc)
- **Sprites & Animations:** [Arks💢](http://arks.itch.io/dino-characters) (License: [CC-By 4.0](https://itch.io/game-assets/assets-cc4-by))
- **Obstacles:** [Free Game Assets](https://free-game-assets.itch.io/free-swamp-2d-tileset-pixel-art) (Free for commercial use; credit appreciated but not required)
- **Jungle Background:** [Jesse M.](https://jesse-m.itch.io/jungle-pack) (Free for personal and commercial use with attribution)
- **Font:** [Daymarius](https://www.dafont.com/retro-gaming.font) (100% Free)
- **Jump SFX:** [LilMati](https://freesound.org/people/LilMati/sounds/458641/) (License: [CC0 / Public Domain](https://creativecommons.org/publicdomain/zero/1.0/))
