FROM php:8.2-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    zip \
    unzip \
    libpq-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libwebp-dev \
    libxpm-dev \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions required by 1100CC
RUN docker-php-ext-install \
    pdo \
    pdo_mysql \
    mysqli \
    mbstring \
    exif \
    pcntl \
    bcmath \
    opcache \
    zip \
    sockets

# Configure GD
RUN docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp --with-xpm \
    && docker-php-ext-install gd

# Enable Apache modules
RUN a2enmod rewrite headers ssl proxy proxy_fcgi

# Set PHP configuration
RUN echo "memory_limit = 512M" > /usr/local/etc/php/conf.d/custom.ini \
    && echo "upload_max_filesize = 100M" >> /usr/local/etc/php/conf.d/custom.ini \
    && echo "post_max_size = 100M" >> /usr/local/etc/php/conf.d/custom.ini \
    && echo "max_execution_time = 300" >> /usr/local/etc/php/conf.d/custom.ini \
    && echo "date.timezone = UTC" >> /usr/local/etc/php/conf.d/custom.ini

# Create 1100CC directory structure
RUN mkdir -p /var/1100CC/APP/CACHE \
    && mkdir -p /var/1100CC/APP/STORAGE \
    && mkdir -p /var/1100CC/APP/SETTINGS \
    && mkdir -p /var/1100CC/SAFE

# Set permissions
RUN chown -R www-data:www-data /var/1100CC

# Configure Apache
COPY apache-config.conf /etc/apache2/sites-available/000-default.conf

# Set working directory
WORKDIR /var/1100CC

# Expose ports
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
