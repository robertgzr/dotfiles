import vapoursynth as vs

core = vs.get_core()
core.std.LoadPlugin(path='/usr/local/lib/libnnedi3.dylib')

video_out = core.nnedi3.nnedi3_rpow2(video_in, rfactor=2)

video_out.set_output()