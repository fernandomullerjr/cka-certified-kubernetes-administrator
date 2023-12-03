# Use uma imagem base, como o Alpine Linux
FROM alpine:latest

# Define o usuário para o ID 1000
USER 1000

# Adicione outras instruções do Dockerfile abaixo
# ...

# Especifica o comando padrão a ser executado quando o contêiner é iniciado
CMD ["echo", "Hello, Docker!"]