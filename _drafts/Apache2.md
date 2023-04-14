# Apache



## software installation

`apt-get install apache2`

## where are the configuration files

`/etc/apache2/`

## steps

1 check the status `systemctl status apache2`

2 open port 80 in the firewall to allow HTTP traffic`ufw allow 80/tcp`

3 test the server: open a browser and enter server's ip and you see the default page

## where are the default page

```bash
/var/www/html/index.html
```

mv the default apache page into `/var/www/html/backup`

## logs

## `/var/log/apache2`

### access.log: 

information about each request made to the server, including ip of the client, the date and time of the request,the requested resource, and the status code returned by the server.

### error.log:

information about any errors occur on the server









### Virtual Hosting

allows the web server to serve multiple websites from the same IP address by using different domain names or IP address

two ways

1. name-based virtual hosting : regards the requested domain to decide which website to send (configured in the .conf file)
2. ip-bassed: each website have a unique ip. requires that the server has multiple IP address available

###### how could a server have multiple ip?

several ways:

1. multiple network interfaces: each network interface has an ip
2. virtual network interfaces: a server can create virtual network interfaces, often used for virtualization or containerization, where each virtual machine or container can have its own ip
3. ip address aliasing: assign multiple ip to a single network interface using ip address aliasing

