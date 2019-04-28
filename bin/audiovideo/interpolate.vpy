import vapoursynth as vs

core = vs.get_core()
core.std.LoadPlugin(path='/usr/local/lib/libmvtools.dylib')
core.std.LoadPlugin(path='/usr/local/lib/libffms2.dylib')

clip = core.ffms2.Source(source=SRC)
container_fps = 30
if CFPS:
    container_fps = CFPS
display_fps = 60.00
if DFPS:
    display_fps = DFPS

src_num = int(float(container_fps) * 1e3)
src_den = int(1e3)
play_num = int(float(display_fps) * 1e3)
play_den = int(1e3)

# config:
# pel= 1 / 2(720p) / 4(slow)
usr_pel = 4
# blksize/hpad/vpad= 8 / 16 / 32
block_size = 8
searchvar = 3

clip = core.std.AssumeFPS(clip, fpsnum=src_num, fpsden=src_den)
sup = core.mv.Super(clip, pel=4, sharp=2, rfilter=4, hpad=block_size, vpad=block_size)
bvec = core.mv.Analyse(sup, truemotion=True, blksize=block_size, isb=True, chroma=True, search=searchvar)
fvec = core.mv.Analyse(sup, truemotion=True, blksize=block_size, isb=False, chroma=True, search=searchvar)
clip = core.mv.BlockFPS(clip, sup, bvec, fvec, num=play_num, den=play_den, mode=3, thscd2=48)

clip.set_output()

print("Source fps", (src_num/src_den))
print("Playback fps", (play_num/play_den))
