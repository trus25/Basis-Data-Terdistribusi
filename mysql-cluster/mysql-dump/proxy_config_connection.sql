CREATE USER 'monitor'@'%' IDENTIFIED BY 'monitorpassword';
GRANT SELECT on sys.* to 'monitor'@'%';
FLUSH PRIVILEGES;

CREATE USER 'userbdt'@'%' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES on user.* to 'userbdt'@'%';
FLUSH PRIVILEGES;