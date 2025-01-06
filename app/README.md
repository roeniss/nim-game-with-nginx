This folder's files should be in `/usr/local/etc/nginx`.

For perl to sqlite3 connection, I used `DBD-SQLite-1.76` by Kenichi Ishigaki. It would probably possible to install the module with cpan but I manually did it because I didn't know what cpan is at that time.

```sh
wget https://cpan.metacpan.org/authors/id/I/IS/ISHIGAKI/DBD-SQLite-1.76.tar.gz
tar xvzf DBD-SQLite-1.76.tar.gz
cd DBD-SQLite-1.76
perl Makefile.PL
make
make install
```
