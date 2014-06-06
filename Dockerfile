FROM ubuntu:trusty
MAINTAINER Laurent Jouanneau <laurent@jelix.org>

ENV DEBIAN_FRONTEND noninteractive
ENV JELIX_APP_DIR_NAME app

# Install packages
RUN apt-get update
RUN apt-get -y install supervisor git apache2 mysql-server mysql-client pwgen vim
RUN apt-get -y install libapache2-mod-php5 php5-gd php5-mcrypt mcrypt php5-json php5-intl php5-memcached php5-mysqlnd php5-sqlite php5-cli php5-curl curl 
RUN apt-get -yq install openssh-server; \
  mkdir -p /var/run/sshd; \
  mkdir /root/.ssh && chmod 700 /root/.ssh

#RUN apt-get -y install phpmyadmin
RUN curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/bin
RUN php5enmod mcrypt
RUN a2enmod rewrite
RUN locale-gen en_US en_US.UTF-8 && dpkg-reconfigure locales

# Import scripts
ADD scripts/app.sh /app.sh
ADD scripts/start-apache2.sh /start-apache2.sh
ADD scripts/setup-mysql.sh /setup-mysql.sh
ADD scripts/create-mysql-database.sh /create-mysql-database.sh
RUN chmod 755 /*.sh

# Import configuration
ADD conf/my.cnf                  /etc/mysql/conf.d/my.cnf
ADD conf/supervisord-lamp.conf   /etc/supervisor/conf.d/supervisord-lamp.conf
ADD conf/vhost.conf              /etc/apache2/sites-available/000-default.conf
ADD conf/php-jelix.ini           /etc/php5/apache2/conf.d/30-jelix.ini
RUN if [ -f /etc/mysql/conf.d/mysqld_safe_syslog.cnf ]; then rm -f /etc/mysql/conf.d/mysqld_safe_syslog.cnf; fi

RUN /setup-mysql.sh

EXPOSE 80 3306 22
CMD ["/app.sh"]
