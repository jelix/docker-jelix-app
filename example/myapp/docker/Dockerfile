FROM jelix/docker-jelix-app
MAINTAINER Laurent Jouanneau <laurent@jelix.org>

ENV JELIX_APP_DIR_NAME myapp

RUN /create-mysql-database.sh mydatabase mylogin mypassword

# Add your ssh key
ADD id_rsa.pub /root/.ssh/authorized_keys
RUN chmod 400 /root/.ssh/authorized_keys && chown root. /root/.ssh/authorized_keys

VOLUME  [ "/var/lib/mysql" ]
