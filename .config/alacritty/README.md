# alacritty config

* `*.ovl.yml` :: config overlays
* `*.color.yml` :: color overlays

use `ovl.sh` to generate the final config

```
# generate default config
$ ovl.sh papercolor_dark.color.yml > alacritty.yml
```

```
# generate scratch term config
$ ovl.sh papercolor_dark.color.yml launcher.ovl.yml > launcher.yml
```

`base.ovl.yml` is always included.
