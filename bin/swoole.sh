#!/bin/bash

install_swoole_ext() {
  dep_url=git://github.com/swoole/swoole-src.git
  swoole_dir=swoole-src
  echo "-----> Building Swoole..."
  #
  ### Swoole
  echo "[LOG] Downloading Swoole"
  git clone $dep_url -q
  if [ ! -d "$swoole_dir" ]; then
    echo "[ERROR] Failed to find swoolephp directory $swoole_dir"
    exit
  fi
  cd $swoole_dir
  #
  #ln -s $BUILD_DIR/.heroku /app/.heroku
  export PATH=/app/.heroku/php/bin:$PATH

  /app/.heroku/php/bin/phpize && \
  ./configure --enable-swoole-curl && \
  make && make install

  cd
  echo "important extension swoole into php.ini"
  echo "extension=swoole.so" >> /app/.heroku/php/etc/php/php.ini
}