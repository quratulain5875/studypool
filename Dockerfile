# ============================================================
# Dockerfile for Studypool Clone - PHP/MySQL Application
# Tag: FA23-BCS-195
# ============================================================

# ---------- Stage 1: Build / Dependency Stage ----------
# Using the official PHP 8.2 Apache image as base (Debian slim)
FROM php:8.2-apache AS builder

# Install build dependencies needed for PHP extensions
RUN apt-get update && apt-get install -y --no-install-recommends \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) mysqli pdo pdo_mysql gd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ---------- Stage 2: Production Runtime ----------
FROM php:8.2-apache

# Copy only the compiled extensions from builder stage
# (Docker best practice #2: Multi-stage build to reduce final image size)
COPY --from=builder /usr/local/lib/php/extensions/ /usr/local/lib/php/extensions/
COPY --from=builder /usr/local/etc/php/conf.d/ /usr/local/etc/php/conf.d/

# Install only runtime libraries (no -dev packages)
RUN apt-get update && apt-get install -y --no-install-recommends \
    libpng16-16 \
    libjpeg62-turbo \
    libfreetype6 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Enable Apache mod_rewrite for clean URLs
RUN a2enmod rewrite

# Define the working directory inside the container
WORKDIR /var/www/html

# Copy only the required application files into the container
COPY studypool_clone/ /var/www/html/

# Create uploads directory structure with proper permissions
RUN mkdir -p /var/www/html/uploads/guides \
    && mkdir -p /var/www/html/uploads/notes \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Expose port 80 for HTTP traffic
EXPOSE 80

# Start Apache in the foreground
CMD ["apache2-foreground"]
