#!/bin/bash

install_swoole_ext() {
  dep_url=git://github.com/swoole/swoole-src.git
  swoole_dir=swoole-src
  space="      "
  echo "-----> Installing Swoole..."
  #
  ### Swoole
  echo "$space Downloading Swoole"
  git clone $dep_url -q
  if [ ! -d "$swoole_dir" ]; then
    echo "[ERROR] Failed to find swoolephp directory $swoole_dir"
    exit
  fi
  cd $swoole_dir

  echo "$space Building Swoole"
  {
    /app/.heroku/php/bin/phpize && \
    ./configure --enable-swoole-curl && \
    make && make install
  } &> /dev/null
  cd
  echo "$space Adding swoole into php.ini"
  echo "extension=swoole.so" >> /app/.heroku/php/etc/php/php.ini
}