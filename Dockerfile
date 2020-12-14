FROM php:7.2.34-apache-buster

RUN \
  rm -rf /var/www/html && \
  mkdir -p /var/www/html && \
  cd /var/www/html && \
  curl -s -L https://github.com/berliCRM/berlicrm/archive/1.0.26.tar.gz \
    | tar xfvz - --strip-components=1 && \
  touch /var/www/html/config.inc.php && \
  chown www-data.www-data . -R && \
  apt-get update && \
  apt-get install -y libc-client-dev libkrb5-dev && \
  docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
  docker-php-ext-install mysqli imap && \

  echo "[PHP]" > /usr/local/etc/php/conf.d/berlicrm.ini  && \
  echo "error_reporting = E_WARNING & ~E_NOTICE" >> /usr/local/etc/php/conf.d/berlicrm.ini && \
  echo "display_errors = off" >> /usr/local/etc/php/conf.d/berlicrm.ini && \
  echo "log_errors = on" >> /usr/local/etc/php/conf.d/berlicrm.ini && \
  echo "file_uploads = on" >> /usr/local/etc/php/conf.d/berlicrm.ini && \
  echo "max_execution_time = 3600" >> /usr/local/etc/php/conf.d/berlicrm.ini && \
  echo "memory_limit = 512M" >> /usr/local/etc/php/conf.d/berlicrm.ini && \
  echo "output_buffering = on" >> /usr/local/etc/php/conf.d/berlicrm.ini && \
  echo "max_input_vars = 8192" >> /usr/local/etc/php/conf.d/berlicrm.ini && \
  echo "short_open_tag = off" >> /usr/local/etc/php/conf.d/berlicrm.ini && \
  echo "default_charset = UTF-8" >> /usr/local/etc/php/conf.d/berlicrm.ini && \

  exit 0  
