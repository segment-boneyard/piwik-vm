
#
# log <type> <msg>
#

log(){
  printf '\n  \033[36m%s\033[m - %s\n\n' $1 $2
}

#
# install <pkg>
#

install(){
  log 'install' $1
  apt-get install -y $1
}

#
# check if <pkg> is installed
#

installed(){
  which $1 > /dev/null 2>&1
}

#
# check if `<path>` exists
#

exists(){
  test -e $1
}

#
# install php
#

php_install(){
  install php5
  install php5-mysql
  install php5-gd
  echo extension=pdo.so >> /etc/php5/apache2/php.ini
  echo extension=pdo_mysql.so >> /etc/php5/apache2/php.ini
  service apache2 restart
}

#
# update
#

update(){
  apt-get -y update
  touch /tmp/uptodate
}

#
# install piwik
#

piwik_install(){
  rm -rf /tmp/piwik \
    && mkdir -p /tmp/piwik \
    && cd /tmp/piwik \
    && wget http://builds.piwik.org/latest.zip \
    && unzip latest.zip \
    && cp -r piwik/* /var/www \
    && rm -f /var/www/index.html \
    && chown -R www-data:www-data /var/www
}

# install piwik's deps

export DEBIAN_FRONTEND=noninteractive
exists /tmp/uptodate || update
installed apache2 || install apache2
installed php || php_install
installed mysql || install mysql-server
installed unzip || install unzip
exists /var/www/index.php || piwik_install
