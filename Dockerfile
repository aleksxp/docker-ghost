# Docker image with Ubuntu featured SSHD and Ghost (http://ghost.org).

from ubuntu:precise

maintainer Alexander Pankov 

run echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
run apt-get update
run apt-get install -y build-essential git curl python-software-properties python g++ make unzip wget

# Comment this line to avoid installing additional software
run apt-get install -y supervisor nano lynx mc

# Install nginx
run add-apt-repository -y ppa:nginx/stable
run apt-get update
run apt-get install -y nginx
run apt-get install -y sqlite3

# Install node.js
run add-apt-repository -y ppa:chris-lea/node.js
run apt-get update
run apt-get install -y nodejs

# Add configuration files
add ./setup /home/ghost/setup

#  Get archive and unpack it. If you'd like another version of Ghost change this line.
workdir /home/ghost
run mkdir /home/ghost/logs
run wget https://ghost.org/zip/ghost-0.4.1.zip
run unzip ghost-0.4.1.zip

# Create logs directory

# Set up right permissions
run chown -R www-data:www-data /home/ghost

# Set up sqlite3 because of error (https://ghost.org/forum/installation/63-sqlite-related-error-on-setup/)
# on current version of ghost (0.4.1) 
run npm install node-gyp -g
run npm install sqlite3 --build-from-source

# Set up requirements
run npm install --production

# Setup configuration
run echo "daemon off;" >> /etc/nginx/nginx.conf
run rm /etc/nginx/sites-enabled/default
run ln -s /home/ghost/setup/nginx-app.conf /etc/nginx/sites-enabled/
run ln -s /home/ghost/setup/supervisor-app.conf /etc/supervisor/conf.d/

# Clean setup - removing downloaded archives.
run rm -rf /home/ghost/*.zip 

# Setup domain.
run sed 's|http://my-ghost-blog.com|http://myblog.com|g' < /home/ghost/setup/config.js > /home/ghost/config.js

# Set up container port
expose 80

# Run supervisor (for nginx and ghost) in non-daemon mode
cmd ["supervisord", "-n"]
