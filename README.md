# 🦖 Dino Runner Game
A 2D Chrome Dino–inspired infinite runner game made in Godot. Built on a beginner tutorial but expanded with original features like a dino wardrobe and dynamic animations.

## 🥐 Overview
The core mechanics of this game were built following a tutorial by [Coding With Russ on YouTube](https://www.youtube.com/watch?v=nKBhz6oJYsc). I added my own features including:
- **Wardrobe system:** switch between 4 dinos, each with interactive animations (idle, hover, select) triggered by mouse input—click to select, hover to preview.
- **Dynamic sprite switching:** based on the selected dino.
- **Custom collision layers:** prevent wardrobe features interfering with gameplay.
- **Downward acceleration:** press the `Down Arrow` key to make dino fall faster.
- **Clean code organization:** scripts are placed in separate scripts folder instead of scenes folder.
- **Dynamic cursor visibility changing:** for cleaner display when game is running.

## 🎀 The Process
Despite having a detailed tutorial showing the step-by-step process of building this game, it was still quite a challenge. My goal in doing this project was to learn the `gdscript` syntax and familiarize myself with game development. I took notes on the approach used to create each element and the basic game structure.

After recreating the base game, I added a few of my own features which took me a while to figure out. The wardrobe feature took me the longest to implement because I wanted to have an interactive display. Creating new features also led me to discover new instructions like the `set_mouse_mode` function.

## 🌼 What I learned
- **Project structure and organization:** I learned about element hierarchy and how to add child nodes/scenes.
- **Proper godot sprite usage:** It is important that the sizes of images or other types of visual media that you use are deliberate to avoid unwanted bugs.
- **Scene instantiation:** Since each obstacle was a different scene, they all had to be loaded before the game could start running. 
- **Parallax2D:** The background is made using a `Node2D` node with child `Parallax2D` and `Sprite2D` nodes. It was fun seeing the background come to life.
- **`_physics_process()`:** The different forces that made the dino jump up and fall back down.
- **Collision areas:** The core mechanic of the entire game. Used to check whether the player has lost, and also used in the wardrobe screen.
- **Accepting and processing user input:** This allows the player to actually interact with the game and allowed for the fun interaction with the dinos in the wardrobe screen.
- **Dynamic animation:** The dinos in the wardrobe screen play different animations based on user input.
- **Performance optimization:** Obstacles that move out of frame are deleted get deleted. This is important since it is wasted memory space as the array fills up the stackframe, eventually leading to a crash.

## ✨ Controls
- `Space` / `Up Arrow`: Start game / jump
- `Down Arrow`: Duck / accelerate fall

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
https://github.com/user-attachments/assets/3187dafe-f951-4fef-aec4-e6ab8e473f18

## 🎨 Credits
- **Original tutorial:** [Coding With Russ](https://www.youtube.com/watch?v=nKBhz6oJYsc)
- **Sprites & Animations:** [Arks](http://arks.itch.io/dino-characters) (License: [CC-By 4.0](https://creativecommons.org/licenses/by/4.0/))
- **Obstacles:** [Free Game Assets](https://free-game-assets.itch.io/free-swamp-2d-tileset-pixel-art) (Free for commercial use; credit appreciated but not required)
- **Jungle Background:** [Jesse M.](https://jesse-m.itch.io/jungle-pack) (Free for personal and commercial use with attribution)
- **Font:** [Daymarius](https://www.dafont.com/retro-gaming.font) (100% Free)
- **Jump SFX:** [LilMati](https://freesound.org/people/LilMati/sounds/458641/) (License: [CC0 / Public Domain](https://creativecommons.org/publicdomain/zero/1.0/))

## 🦦 Personal note
My biggest motivation for doing this project was because I was unhappy with my haunted mansion project. It was my first time working with Godot so I had no idea what I was doing—and honestly, the final result showed it.</br>
But with this project, I finally feel like I’m getting the hang of things. I’m proud of what I built, especially the parts I came up with on my own. It’s not perfect, but it’s mine—and that means a lot.
