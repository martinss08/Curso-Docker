FROM php:8.2

RUN apt-get update && \
    apt-get install -y unzip libzip-dev && \
    docker-php-ext-install zip

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('sha384', 'composer-setup.php') === 'c8b085408188070d5f52bcfe4ecfbee5f727afa458b2573b8eaaf77b3419b0bf2768dc67c86944da1544f06fa544fd47') { echo 'Instalador verificado'.PHP_EOL; } else { echo 'Instalador corrompido'.PHP_EOL; unlink('composer-setup.php'); exit(1); }" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer

WORKDIR /var/www

RUN composer create-project laravel/laravel meu-laravel

ENTRYPOINT [ "php","meu-laravel/artisan","serve" ]
CMD [ "--host=0.0.0.0", "--p=8000" ]

# WORKDIR /app
# RUN apt-get update && apt-get install nano -y
# COPY html/ /usr/share/nginx/html

    # ENTRYPOINTER - Usado para exevutar comando apos inicialização do container
    # So é sobscrito usando a flag "--entrypointer" e pode ser usado em conjunto com o CDM 
# ENTRYPOINT [ "echo", "Bem Vindo" ]

    # CMD - Usado para exivutar comando apos inicialização do container
    # Seu valor pode ser substituido apos passar um argumento no final do comando docker run
# CMD [ " - João Victor" ]
    
# COPY html/ usr/share/nginx/html/


# RUN apt-get update && apt-get install nano -y

# ENTRYPOINT ["/docker-entrypoint.sh"]

# CMD ["nginx", "-g", "daemon off;"]