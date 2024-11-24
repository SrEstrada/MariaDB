#!/usr/bin/perl
use strict;
use warnings;
use DBI;

# Imprimir encabezado HTTP
print "Content-type: text/html\n\n";

# Manejo de excepciones
eval {
    # Conexión a la base de datos
    my $dsn = "DBI:mysql:database=prueba;host=127.0.0.1;port=3306";
    my $user = "root";
    my $password = "";

    my $dbh = DBI->connect($dsn, $user, $password, { RaiseError => 1, PrintError => 0 });

    # Consulta
    my $sth = $dbh->prepare("SELECT nombre FROM actores WHERE actor_id = 5");
    $sth->execute();

    # Comprobar si hay resultados
    my $output = "<html><body><h1>Actor con ID 5</h1>";
    if (my @row = $sth->fetchrow_array) {
        $output .= "<p>Nombre: $row[0]</p>";
    } else {
        $output .= "<p>No se encontró un actor con ID 5.</p>";
    }
    $output .= "</body></html>";

    # Imprimir resultados
    print $output;

    $sth->finish();
    $dbh->disconnect();
};

# Manejo de errores en tiempo de ejecución
if ($@) {
    print "<html><body><h1>Error en el script CGI</h1><p>$@</p></body></html>";
}
