# Homework

_Deadline: Has to be defended before exam_

Write a wallpaper engine for you desktop environment.

Required features:
1. Can loop wallpaper from configured directory periodically.
  * Period has to be configurable
  * Directory has to be configurable
  * Nice to have: switch wallpaper on some events (login, logout, sleep, wake, etc.)
2. Supports per monitor wallpapers
3. Supports PNG, JPG and hopefully other common formats
  * Nice to have: video formats support
4. Generative AI wallpapers
  * Can use either online model of offline model
  * Online model should have sort of fallback to offline model (can be a lot less powerful, but your screen shouldn't be black)
  * Offline model should use CPU/GPU reasonably - you don't want to max them out for wallpapers
  * The generated wallpaper should somehow depend on what is currently going on. Some options for context:
    - Time of the day, week, month, etc.
    - Currently open apps / processes
    - Resource usage
    - Recent news, data from some webpage, weather, etc.

The repository should be set up as any open source software project.
I.e. it should have:
1. Readme with description of the project, usage and installation guide
2. License

