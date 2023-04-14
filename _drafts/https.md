HTTPS

#### get a CA certificate from authorities like [let's encrypt](https://letsencrypt.org/getting-started/)

but let's encrypt only issues domain-validated certificate

and a self-signed certificate is not trusted by browsers and other clients by default

install `Cerbot (one of the many ACME clients)` to automate certificate issuance and installation with no downtime. Expert modes also.

[certbot instructions](https://certbot.eff.org/instructions?ws=apache&os=debianbuster&tab=standard)

1 install snapd first (a package manager used to install and manage applications packaged as "snaps" on Ubuntu and other Linux distributions)

```bash
sudo apt-get update
sudo apt-get install snapd
```

2 remove certbot-auto(a shell scripts) and other certbot packages to ensure a clean installation of certbot and avoid any conflicts that may arise from having multiple versions or installations of certbot

```bash
sudo apt-get remove certbot
sudo rm /usr/local/bin/certbot-auto
```

If you have already obtained a certificate using Certbot, it will remain on your system even if you remove the Certbot packages.

3 install certbot with snap

```bash
sudo snap install --classic certbot 
```

--classic is used to request installation of a "classic" snap, which is a type of a snap that has access to the host system and can therefore perform system-level operations that regular snaps cannot

Certbot needs to be able to modify the Apache or Nginx co figuration files to obtain and install SSL/TLS certificates.

 4 why using snap not apt-get

`advantages: up-to-date software \ sandboxing \ portability \ automatic updates`

sandboxing:snap packages are sandboxed, isolated from the rest of the system

portability: snap packages are designed to be portable across different linux distributions.

auto update: the certbot snap is set up to automatically update itself 

5 set up a symlink to make `certboy` command available in the system PATH

```bash
Warning: /snap/bin was not found in your $PATH. If you've not restarted
         your session since you installed snapd, try doing that. Please
         see https://forum.snapcraft.io/t/9469 for more details.
```

`ln -s /snap/bin/certbot /usr/bin/certbot`

` which certbot`

5 before install a certificate without a domain name

placeholder domain name:since i don't have a domain name a placeholder domain name is needed (used for testing and development purpose when a real domain name is not available

self-signed SSL/TLS certificate:signed by the server itself rather than a trusted third-party Certificate Authority(CA). Able to use https but it's not verified by a trusted CA, so browsers will show a warning to users that the certificate is not trusted

6 get a self-signed certificate with a placeholder domain name and then install it manually

```bash
sudo certbot certonly --standalone
```

email wugleglewu@gmail.com

agree the terms of service

receive emails from `Let's Encrypt` or not?

enter placeholder domain name`jiahao.com`

error messages: 

`Could not bind TCP port 80 because it is already in use by another process on
this system (such as a web server). Please stop the program in question and then
try again.`

apache web server is using port 80(http) but the certbot needs to use port 80 to validate my domain ownership(there's other ways to validate, like DNS validation method) execute `sudo systemctl stop apach2` and run the command again 

error messages:

```bash
Requesting a certificate for jiahao.com

Certbot failed to authenticate some domains (authenticator: standalone). The Certificate Authority reported these problems:
  Domain: jiahao.com
  Type:   unauthorized
  Detail: 67.21.93.253: Invalid response from http://jiahao.com/.well-known/acme-challenge/AUJQC9MmWY7-QSv-qALFoV3g0WKa0P2iW2Z7-T_H73w: 403

Hint: The Certificate Authority failed to download the challenge files from the temporary standalone webserver started by Certbot on port 80. Ensure that the listed domains point to this machine and that it can accept inbound connections from the internet.

Some challenges have failed.
Ask for help or search for solutions at https://community.letsencrypt.org. See the logfile /var/log/letsencrypt/letsencrypt.log or re-run Certbot with -v for more details.
```

reasons:Let's Encrypt, and other CAs, may not issue certificates for placeholder domain names, as they are not globally registered.



### get a self-signed certificate using OpenSSL

[openssh](https://www.openssl.org/)

openssl suoport AES, RSA, SSL/TLS

1. generate a private key `openssl genrsa -out mykey.key 2048` This will generate a private key with a length of 2048 bits and save it to a file named `mykey.key`

2. generate a certificate signing request(CSR)  `openssl req -new -key mykey.key -out mycsr.csr` This will generate a CSR and save it to a file named `mycsr.csr`. You will be prompted to enter some information, such as the common name of the certificate (e.g., the domain name you want to secure), organization name, and country code.

   ```bash
   root@vul:~# openssl req -new -key mykey.key -out mycsr.csr
   You are about to be asked to enter information that will be incorporated
   into your certificate request.
   What you are about to enter is what is called a Distinguished Name or a DN.
   There are quite a few fields but you can leave some blank
   For some fields there will be a default value,
   If you enter '.', the field will be left blank.
   -----
   Country Name (2 letter code) [AU]:
   State or Province Name (full name) [Some-State]:
   Locality Name (eg, city) []:
   Organization Name (eg, company) [Internet Widgits Pty Ltd]:
   Organizational Unit Name (eg, section) []:
   Common Name (e.g. server FQDN or YOUR name) []:moviesmatter.com
   Email Address []:wugleglewu@gmail.com
   
   Please enter the following 'extra' attributes
   to be sent with your certificate request
   A challenge password []:jiahao
   An optional company name []:
   ```

   3. generate a self-signed certificate: `openssl x509 -req -in mycsr.csr -signkey mykey.key -out mycert.crt -days 365` This will generate a self-signed certificate valid for 365 days and save it to a file named `mycert.crt`. You can adjust the number of days by changing the `-days` option.

```bash
root@vul:~# openssl x509 -req -in mycsr.csr -signkey mykey.key -out mycert.crt -days 365
Signature ok
subject=C = AU, ST = Some-State, O = Internet Widgits Pty Ltd, CN = moviesmatter.com, emailAddress = wugleglewu@gmail.com
Getting Private key
```

#### install the certificate

1. enable ssl modele on the apache server 

   ```bash
   sudo a2enmod ssl
   
   Considering dependency setenvif for ssl:
   Module setenvif already enabled
   Considering dependency mime for ssl:
   Module mime already enabled
   Considering dependency socache_shmcb for ssl:
   Enabling module socache_shmcb.
   Enabling module ssl.
   See /usr/share/doc/apache2/README.Debian.gz on how to configure SSL and create self-signed certificates.
   To activate the new configuration, you need to run:
     systemctl restart apache2
   ```

2. create or change the SSL virtual hos configuration file for Apache `/etc/apach2/sites-available/default-ssl.conf`

   the configuration file:

   ```bash
   w<IfModule mod_ssl.c>
       <VirtualHost _default_:443>
           ServerAdmin webmaster@localhost
           DocumentRoot /var/www/html
           ErrorLog ${APACHE_LOG_DIR}/error.log
           CustomLog ${APACHE_LOG_DIR}/access.log combined
   
           SSLEngine on
           SSLCertificateFile /path/to/mycsr.crt
           SSLCertificateKeyFile /path/to/mykey.key
           SSLProtocol all -SSLv2 -SSLv3
           SSLCipherSuite ALL:!DH:!EXPORT:!RC4:+HIGH:+MEDIUM:!LOW:!aNULL:!eNULL
   
           <FilesMatch "\.(cgi|shtml|phtml|php)$">
               SSLOptions +StdEnvVars
           </FilesMatch>
           <Directory /usr/lib/cgi-bin>
               SSLOptions +StdEnvVars
           </Directory>
   
           BrowserMatch "MSIE [2-6]" \
               nokeepalive ssl-unclean-shutdown \
               downgrade-1.0 force-response-1.0
   
           BrowserMatch "MSIE [17-9]" ssl-unclean-shutdown
       </VirtualHost>
   </IfModule>
   ```

   3. enable the SSL virtual host(kind of configuration files to enable HTTPS)  `sudo a2ensite default-ssl.conf`

      ```bash
      root@vul:/etc/apache2/sites-available# a2ensite default-ssl.conf
      Enabling site default-ssl.
      To activate the new configuration, you need to run:
        systemctl reload apache2
      ```

   4. restart `sudo systemctl restart apache2`

error

```bash
● apache2.service - The Apache HTTP Server
     Loaded: loaded (/lib/systemd/system/apache2.service; enabled; vendor preset: enabled)
     Active: failed (Result: exit-code) since Wed 2023-03-29 07:59:25 UTC; 5min ago
       Docs: https://httpd.apache.org/docs/2.4/
    Process: 313764 ExecStart=/usr/sbin/apachectl start (code=exited, status=1/FAILURE)
        CPU: 30ms

3月 29 07:59:25 vul systemd[1]: Starting The Apache HTTP Server...
3月 29 07:59:25 vul apachectl[313767]: AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 127.0.1.1. Set the 'ServerName' directive globally to suppress this message
3月 29 07:59:25 vul apachectl[313764]: Action 'start' failed.
3月 29 07:59:25 vul apachectl[313764]: The Apache error log may have more information.
3月 29 07:59:25 vul systemd[1]: apache2.service: Control process exited, code=exited, status=1/FAILURE
3月 29 07:59:25 vul systemd[1]: apache2.service: Failed with result 'exit-code'.
3月 29 07:59:25 vul systemd[1]: Failed to start The Apache HTTP Server.
```

keyword 

```bash
Could not reliably determine the server's fully qualified domain name, using 127.0.1.1. Set the 'ServerName' directive globally to suppress this message
```

to solve this, edit the `/etc/apache2/apache2.conf` file

and simply add `ServerName localhost` and then restart

error again

```bash
root@vul:/etc/apache2# systemctl status apache2
● apache2.service - The Apache HTTP Server
     Loaded: loaded (/lib/systemd/system/apache2.service; enabled; vendor preset: enabled)
     Active: failed (Result: exit-code) since Wed 2023-03-29 08:16:30 UTC; 49s ago
       Docs: https://httpd.apache.org/docs/2.4/
    Process: 314222 ExecStart=/usr/sbin/apachectl start (code=exited, status=1/FAILURE)
        CPU: 22ms

3月 29 08:16:30 vul systemd[1]: Starting The Apache HTTP Server...
3月 29 08:16:30 vul apachectl[314222]: Action 'start' failed.
3月 29 08:16:30 vul apachectl[314222]: The Apache error log may have more information.
3月 29 08:16:30 vul systemd[1]: apache2.service: Control process exited, code=exited, status=1/FAILURE
3月 29 08:16:30 vul systemd[1]: apache2.service: Failed with result 'exit-code'.
3月 29 08:16:30 vul systemd[1]: Failed to start The Apache HTTP Server.
```

check the error log of apache2

`tail -n 50 /var/log/apache2/error.log`

```bash
[Wed Mar 29 08:16:30.783981 2023] [ssl:emerg] [pid 314225:tid 140287654894912] AH02562: Failed to configure certificate localhost:443:0 (with chain), check /etc/ssl/https_certificate/mycsr.csr
[Wed Mar 29 08:16:30.784060 2023] [ssl:emerg] [pid 314225:tid 140287654894912] SSL Library Error: error:0909006C:PEM routines:get_name:no start line (Expecting: TRUSTED CERTIFICATE) -- Bad file contents or format - or even just a forgotten SSLCertificateKeyFile?
```

reason: `formatting issue with the certificate`

solve: check the formatting using openssl command

 ```bash
 openssl req -text -noout -verify -in /etc/ssl/https_certificate/mycsr.csr
 ```

```bash
root@vul:/etc/ssl/https_certificate# openssl req -text -noout -verify -in /etc/ssl/https_certificate/mycsr.csr
verify OK
Certificate Request:
    Data:
        Version: 1 (0x0)
        Subject: C = AU, ST = Some-State, O = Internet Widgits Pty Ltd, CN = moviesmatter.com, emailAddress = wugleglewu@gmail.com
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                RSA Public-Key: (2048 bit)
                Modulus:
                    00:c3:df:3b:31:c9:1f:30:61:a5:ca:e1:cc:d5:9a:
                    83:a0:55:c8:5a:f0:07:b5:4e:24:37:0a:8b:81:96:
                    3b:75:f1:6c:25:cb:17:ea:97:f2:e4:4c:7e:b7:a2:
                    9a:2c:04:81:e5:eb:85:60:2d:36:55:f7:d8:28:02:
                    ae:ef:0c:30:1d:72:13:6f:7f:de:a4:e2:ed:df:df:
                    6a:23:93:58:e0:1b:e0:8a:81:f5:f9:6c:80:65:d9:
                    29:8b:ef:97:29:5c:42:07:3b:48:15:d3:b1:0c:20:
                    8e:e5:2b:35:d6:5b:d6:0d:d0:ed:f2:6b:90:3d:50:
                    28:90:9f:de:6a:e0:7e:64:26:a0:3a:20:b7:c1:b0:
                    b3:e5:f3:cb:fb:b0:51:4f:71:52:ac:48:fc:e9:05:
                    25:7d:83:9b:55:f8:cf:41:58:08:4b:b8:6a:ec:a4:
                    fc:ad:a7:63:11:7f:7d:b4:77:e4:47:55:be:2a:57:
                    7a:d9:43:65:a9:7e:b5:98:21:74:66:9a:6a:fd:94:
                    38:70:b9:e0:44:54:6f:77:8b:b6:25:66:38:25:06:
                    fc:98:49:4f:c0:85:bf:00:a2:2a:1c:2b:dc:de:c7:
                    0f:a0:17:e8:f0:71:be:bc:c9:2c:6d:a0:bb:78:a1:
                    29:7e:9a:a4:36:c4:99:1c:ce:b0:1e:18:b0:d8:e9:
                    21:c1
                Exponent: 65537 (0x10001)
        Attributes:
            challengePassword        :jiahao
    Signature Algorithm: sha256WithRSAEncryption
         af:69:76:5d:95:7f:ce:9f:d9:73:22:3a:d7:bc:ca:70:b7:15:
         3a:ba:12:e5:db:92:33:72:14:2d:3a:f3:20:6c:ce:89:9a:a2:
         23:fc:f3:22:96:8d:2d:26:c8:51:b4:41:b7:87:60:63:43:0e:
         21:88:84:9b:99:fe:b9:81:3c:0a:ac:85:d4:d2:ad:8f:b2:4f:
         93:38:2f:de:28:35:ef:13:36:2e:0a:6b:0a:df:cd:9b:9f:39:
         ab:6f:c5:96:80:f9:f0:19:04:29:99:45:0e:17:f6:c8:82:d7:
         5f:29:7c:4c:5a:a1:3f:64:8f:46:0c:83:a1:3c:5c:01:e4:3f:
         77:52:3e:8a:37:53:7a:65:8a:e1:78:20:76:0c:21:f3:94:48:
         5d:0d:6a:69:dc:47:74:8b:4c:0c:41:be:66:fe:cc:7e:bc:6b:
         36:3a:b8:2f:08:e9:69:e3:de:fe:1f:14:78:06:00:68:5f:58:
         e0:c7:24:d2:b8:64:c4:15:cf:b4:63:f0:cd:ef:5b:ec:17:7b:
         46:6d:b4:ac:99:0e:29:ec:91:bc:35:7e:a9:50:cb:99:1b:75:
         3e:da:91:bc:68:e8:47:bb:bc:81:a9:f1:fb:4d:5c:01:c6:54:
         51:26:2f:a7:f1:61:b7:85:ff:cc:0e:56:35:27:03:b8:91:69:
         ec:47:97:db
```

logs; after reset the /etc/apache2/sites-available from backup, apache2 successfully start

[stackexchange](https://serverfault.com/questions/216252/how-to-configure-apache-sites-available-vs-httpd-conf)

[youtube_apache2_https](https://www.youtube.com/watch?v=rgBY6phztlk)
