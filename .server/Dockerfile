FROM php:8.2-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Configure and install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install pdo_mysql mysqli gd xml mbstring

# Install Composer from the official composer image
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy application code from the repository's `src` directory
COPY src/ /var/www/html

WORKDIR /var/www/html

# Expose PHP-FPM port
EXPOSE 9000

CMD ["php-fpm"]
