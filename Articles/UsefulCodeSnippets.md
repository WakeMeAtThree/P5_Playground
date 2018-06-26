# Useful code snippets

The following are useful `ffmpeg` commands for making animation gifs/mp4. 

Turning image sequence to a video
```
ffmpeg -framerate 30 -i animation%3d.png -pix_fmt yuv420p output.mp4
```

Concatenating two videos to create a reverse loop
```
ffmpeg -i input.mov -filter_complex "[0:v]reverse,fifo[r];[0:v][r] concat=n=2:v=1 [v]" -map "[v]" output.mp4
```

Generating palette.png and using it to create smaller gifs. [Reference 1.](https://engineering.giphy.com/how-to-make-gifs-with-ffmpeg/) [Reference 2.](https://medium.com/@colten_jackson/doing-the-gif-thing-on-debian-82b9760a8483)
```
ffmpeg -i output.mp4 -vf palettegen palette.png
ffmpeg -i output.mp4 -i palette.png -filter_complex “fps=30,scale=400:-1:flags=lanczos[x];[x][1:v]paletteuse” output.gif
ffmpeg -ss 2.6 -t 1.3 -i output.mp4 -i palette.png -filter_complex “fps=30,scale=400:-1:flags=lanczos[x];[x][1:v]paletteuse” output.gif
```

Running a processing sketch in terminal [Check this out](https://github.com/processing/processing/wiki/Command-Line):

```
processing-java --sketch=%cd% --run
```

Reseting changes in a local clone

```git
# Revert changes to modified files.
git reset --hard

# Remove all untracked files and directories. (`-f` is `force`, `-d` is `remove directories`)
git clean -fd
```

Renaming sequence of files

```python
import os

for filename in os.listdir("."):
    if(filename.startswith("Z_")):
        newName = "2018_0"+filename[2:]
        os.rename(f"{filename}",f"{newName}")
```

Table generators in markdown

- [Markdown table generator](https://www.tablesgenerator.com/markdown_tables#)
- [Another table generator](https://donatstudios.com/CsvToMarkdownTable)
