FROM ubuntu:latest

    # ENTRYPOINTER - Usado para exevutar comando apos inicialização do container
    # So é sobscrito usando a flag "--entrypointer" e pode ser usado em conjunto com o CDM 
ENTRYPOINT [ "echo", "Bem Vindo" ]

    # CMD - Usado para exivutar comando apos inicialização do container
    # Seu valor pode ser substituido apos passar um argumento no final do comando docker run
CMD [ " - João Victor" ]
    

# WORKDIR /app
# RUN apt-get update && apt-get install nano -y
# COPY html/ /usr/share/nginx/html
