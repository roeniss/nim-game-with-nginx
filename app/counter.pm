package counter;

use warnings;
use strict;
use DBI;
use Digest::MD5 qw(md5_hex);

sub get_prize_code {
    my $file_path = "/usr/local/etc/nginx/prize.txt";
    open(my $fh, '<', $file_path) or die "Cannot open file '$file_path': $!";
    my $content = do { local $/; <$fh> };
    close($fh);

    return md5_hex($content);
}

my $db_file = "/usr/local/etc/nginx/counter.db";
my $dbh = DBI->connect("DBI:SQLite:dbname=$db_file", "", "", { RaiseError => 1, AutoCommit => 1 }) or die $DBI::errstr;

sub handler {
    my $r = shift;

    my $sth_update = $dbh->prepare("UPDATE counter SET count = COALESCE(count, 0) + 1 WHERE id = 1 RETURNING *") or die $DBI::errstr;
    $sth_update->execute();
    my $updated_row = $sth_update->fetch;
    my $counter = $updated_row->[1];

    $r->send_http_header('text/plain');
    if ($counter == 100) {
	my $prize_code = counter::get_prize_code();
        return $r->print("Contrats! You've got the very 100!\nShow this code to admin and get the prize: $prize_code\n");
    } else {
        return $r->print("Counter is ... $counter.\n");
    }
}

1;
