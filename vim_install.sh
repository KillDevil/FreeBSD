#!/bin/bash -e
#yum install ncurses-devel
#yum install python-devel
#yum install lua-devel
./configure \
  --disable-gui --enable-fontset --disable-xsmp \
  --enable-python3interp --enable-rubyinterp=dynamic --enable-pythoninterp \
  --enable-luainterp=dynamic --enable-perlinterp=dynamic \
  --enable-cscope --enable-multibyte --with-features=huge \
  --with-compiledby=Yan Feng --with-modified-by=Yan Feng

make -j2
sudo make install
