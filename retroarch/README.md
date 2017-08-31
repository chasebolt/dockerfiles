# Example Usage
```
docker run -it --rm \
  --name retroarch \
  --device /dev/dri \
  --device /dev/input \
  --device /dev/snd \
  -e DISPLAY \
  -v /tmp/.X11-unix/:/tmp/.X11-unix/ \
  -v $HOME/.config/retroarch:/home/user/.config/retroarch \
  -v $HOME/Roms:/home/user/roms \
  cbolt/retroarch
```
