#!/usr/bin/env bash

sudo apt update
sudo apt install -y curl
curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh

sudo apt install -y nodejs
sudo apt install -y build-essential

sudo apt install -y nginx
sudo systemctl restart nginx


cat << 'EOF2' > hello.js
const http = require('http');
 const hostname = 'localhost';
 const port = 3000;
 const server = http.createServer((req, res) => {
   res.statusCode = 200;
   res.setHeader('Content-Type', 'text/plain');
   res.end('UNIR Santino Suntaxi !\n');
 });
  server.listen(port, hostname, () => {
      console.log(`Server running at http://${hostname}:${port}/`);
 }); 
EOF2

sudo rm /etc/nginx/sites-enabled/default
cd /etc/nginx/sites-available/

cat << 'EOF' > node 
server {
    listen 80;
    server_name 127.0.0.1;
    location / {
        proxy_set_header   X-Forwarded-For $remote_addr;
        proxy_set_header   Host $http_host;
        proxy_pass         "http://127.0.0.1:3000";
    }
}
EOF

sudo ln -s /etc/nginx/sites-available/node /etc/nginx/sites-enabled/node

sudo service nginx restart