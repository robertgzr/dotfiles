import vapoursynth as vs
core = vs.get_core()
core.std.LoadPlugin(path='/usr/local/Cellar/mvtools/HEAD/lib/libmvtools.dylib')

clip = video_in

src_num = int(float(container_fps) * 1e3)
src_den = int(1e3)
play_num = int(float(display_fps) * 1e3)
play_den = int(1e3)

# config:
# pel= 1 / 2(720p) / 4(slow)
usr_pel = 1
# blksize/hpad/vpad= 8 / 16 / 32
block_size = 32
# best: 3/ default:0
searchvar = 0

if not (clip.width > 1920 or clip.height > 1080 or container_fps > 59):
    clip = core.std.AssumeFPS(clip, fpsnum=src_num, fpsden=src_den)
    sup  = core.mv.Super(clip, pel=4, sharp=2, rfilter=4, hpad=block_size, vpad=block_size)
    bvec = core.mv.Analyse(sup, truemotion=True, blksize=block_size, isb=True, chroma=True, search=searchvar)
    fvec = core.mv.Analyse(sup, truemotion=True, blksize=block_size, isb=False, chroma=True, search=searchvar)
    clip = core.mv.BlockFPS(clip, sup, bvec, fvec, num=play_num, den=play_den, mode=3, thscd2=48)

clip.set_output()

print("Source fps", (src_num/src_den))
print("Playback fps", (play_num/play_den))