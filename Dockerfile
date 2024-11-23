FROM debian:latest

RUN apt-get update && \
    apt-get install -y apache2 libapache2-mod-perl2 perl mariadb-server \
    libdbi-perl libdbd-mysql-perl && \
    apt-get clean

RUN a2enmod cgi

RUN mkdir -p /usr/lib/cgi-bin
RUN chmod +x /usr/lib/cgi-bin

COPY basedatos.pl /usr/lib/cgi-bin/basedatos.pl
RUN chmod +x /usr/lib/cgi-bin/basedatos.pl

COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

# Copia un script de inicialización para MariaDB
COPY init-mariadb.sh /init-mariadb.sh
RUN chmod +x /init-mariadb.sh

EXPOSE 80

CMD /init-mariadb.sh && apache2ctl -D FOREGROUND
