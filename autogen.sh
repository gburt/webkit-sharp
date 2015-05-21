#!/bin/sh

autoreconf  -i --force --warnings=none
./configure --enable-maintainer-mode $*

# And now, regenerate the API
make -C sources api
