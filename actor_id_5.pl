#!/usr/bin/perl
use strict;
use warnings;
use DBI;

print "Content-type: text/html\n\n";

# Conexión a la base de datos
my $dsn = "DBI:mysql:database=prueba;host=localhost;port=3306";
my $user = "root";
my $password = "";

my $dbh = DBI->connect($dsn, $user, $password, { RaiseError => 1, PrintError => 0 });

# Consulta para obtener el actor con ID 5
my $sth = $dbh->prepare("SELECT nombre FROM actores WHERE actor_id = 5");
$sth->execute();

# Imprimir resultados en HTML
print "<html><body><h1>Actor con ID 5</h1>";
if (my @row = $sth->fetchrow_array) {
    print "<p>Nombre: $row[0]</p>";
} else {
    print "<p>No se encontró un actor con ID 5.</p>";
}
print "</body></html>";

$sth->finish();
$dbh->disconnect();
