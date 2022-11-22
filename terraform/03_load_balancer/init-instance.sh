#!/bin/bash
apt-get update
apt-get install -y apache2
echo "<DOCTYPE html>
<html lang=\"en\">
    <body>
        <h1>Hello, this is instance #${instance_idx}</h1>
    </body>
</html>" > /var/www/html/index.html