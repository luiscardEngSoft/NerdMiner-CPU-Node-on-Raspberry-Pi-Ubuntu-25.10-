📁 2. Arquivo: 
Crie a pasta:

mkdir -p scripts

Depois crie o arquivo:

nano scripts/install_cpuminer.sh

Cole:

#!/bin/bash

echo "=============================================="
echo "  Instalação automática do cpuminer-multi"
echo "  Ambiente: Ubuntu 25.10 (Raspberry Pi)"
echo "=============================================="
sleep 2

# Atualizar sistema
echo "[1/5] Atualizando sistema..."
sudo apt update && sudo apt upgrade -y

# Instalar dependências
echo "[2/5] Instalando dependências..."
sudo apt install -y git build-essential automake libcurl4-openssl-dev

# Clonar repositório
echo "[3/5] Clonando cpuminer-multi..."
cd ~
if [ ! -d "cpuminer-multi" ]; then
    git clone https://github.com/tpruvot/cpuminer-multi.git
fi

# Compilar
echo "[4/5] Compilando cpuminer-multi..."
cd cpuminer-multi
./autogen.sh
./configure CFLAGS="-O3"
make

# Instalar serviço systemd
echo "[5/5] Instalando serviço miner.service..."
sudo cp ~/systemd/miner.service /etc/systemd/system/miner.service
sudo systemctl daemon-reload
sudo systemctl enable miner.service

echo "=============================================="
echo "Instalação concluída!"
echo "Para iniciar o minerador agora, execute:"
echo "  sudo systemctl start miner.service"
echo "=============================================="

Salve com Control X + Y para confirmar e depois Enter

Torne o script executável execute no terminal:

chmod +x scripts/install_cpuminer.sh

