
PW reset

```
$ mysql.server stop
$ mysql.server start --skip-grant-tables
$ mysql
> use mysql;
> update user set authentication_string=PASSWORD("XXX") where User='root';
> flush privileges;
> quit;
$ mysql.server restart
$ mysql -uroot -pXXX
```
