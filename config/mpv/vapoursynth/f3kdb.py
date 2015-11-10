import vapoursynth as vs
core = vs.get_core()

# only needed when libf3kdb.dylib wasn't installed
core.std.LoadPlugin(path='/usr/local/lib/libf3kdb.dylib')

clip = video_in
clip = core.std.Trim(clip, first=0, length=500000)
clip = core.f3kdb.Deband(clip, grainy=0, grainc=0, output_depth=16)
clip.set_output()