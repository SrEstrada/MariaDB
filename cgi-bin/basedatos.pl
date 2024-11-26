#!/usr/bin/perl
use strict;
use warnings;
use DBI;

my $database = "prueba";
my $hostname = "localhost";
my $port = 3306;
my $user = "root";
my $password = "";

my $dsn = "DBI:mysql:database=$database;host=$hostname;port=$port";
my $dbh = DBI->connect($dsn, $user, $password, { RaiseError => 1 }) or die "No se pudo conectar: $DBI::errstr";

print "Conexión exitosa a la base de datos '$database'.\n";

my $query = "SELECT * FROM peliculas";
my $sth = $dbh->prepare($query);
$sth->execute();

while (my @row = $sth->fetchrow_array) {
    print join(", ", @row), "\n";
}

$sth->finish();
$dbh->disconnect();
