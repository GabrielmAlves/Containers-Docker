# Using NGINX official image
FROM nginx

# Install PHP and it's extensions
RUN apt-get update && apt-get install -y php-fpm php-mysql

# Copy your files into NGINX standard directory
COPY . /usr/share/nginx/html

# Copy NGINX personalized configuration file
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Show door 80 in order to access the web server
EXPOSE 80

# Initialize PHP and NGINX
CMD service php7.4-fpm start && nginx -g 'daemon off;'