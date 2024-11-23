FROM debian:latest

# Instalar dependencias necesarias
RUN apt-get update && \
    apt-get install -y apache2 libapache2-mod-perl2 perl mariadb-server \
    libdbi-perl libdbd-mysql-perl && \
    apt-get clean

# Habilitar CGI en Apache
RUN a2enmod cgi

# Crear directorio CGI
RUN mkdir -p /usr/lib/cgi-bin
RUN chmod +x /usr/lib/cgi-bin

# Copiar archivos necesarios
COPY basedatos.pl /usr/lib/cgi-bin/basedatos.pl
RUN chmod +x /usr/lib/cgi-bin/basedatos.pl
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

# Copiar script de inicialización
COPY init-mariadb.sh /usr/local/bin/init-mariadb.sh
RUN chmod +x /usr/local/bin/init-mariadb.sh

# Crear directorios para MariaDB
RUN mkdir -p /var/run/mysqld /var/lib/mysql && \
    chown -R mysql:mysql /var/run/mysqld /var/lib/mysql

# Exponer el puerto 80
EXPOSE 80

# Ejecutar el script de inicialización y Apache al iniciar el contenedor
CMD ["/usr/local/bin/init-mariadb.sh"]
