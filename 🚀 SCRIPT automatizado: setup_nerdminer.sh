1. Tutorial passo a passo (criando tudo do zero)
Este roteiro assume:
- Usuário: luiscard
- Sistema: Ubuntu 25.10 no Raspberry Pi
- Você está logado como luiscard (sem ser root)
Passo 1: Abrir o terminal
Se estiver no Raspberry com interface gráfica:
- Clique no ícone do Terminal ou pressione Ctrl + Alt + T.
Se estiver via SSH:
- Já estará no terminal ao conectar.
Você deve ver algo como:

luiscard@RPI3:~$

Passo 2: Criar um diretório para o projeto (opcional, mas organizado)
No terminal, digite:
mkdir -p ~/nerdminer-setup
cd ~/nerdminer-setup


Explicação:
- mkdir -p cria a pasta nerdminer-setup dentro do seu /home/luiscard.
- cd entra dentro dessa pasta.

Passo 3: Criar o arquivo do script único
Agora vamos criar o arquivo chamado setup_nerdminer.sh.
No terminal:
nano setup_nerdminer.sh


Isso vai abrir o editor de texto nano dentro do terminal, com uma tela em branco.

Passo 4: Colar o conteúdo do script dentro do nano
Dentro do nano, cole exatamente o conteúdo abaixo (vou repetir completo aqui para você usar no PDF também):

#!/bin/bash

echo "====================================================="
echo "   Setup Automático - NerdMiner CPU (Raspberry Pi)"
echo "   Sistema: Ubuntu 25.10"
echo "   Usuário configurado: luiscard"
echo "====================================================="
sleep 2

# Criar estrutura de pastas
echo "[1/7] Criando estrutura de diretórios..."
mkdir -p /home/luiscard/systemd
mkdir -p /home/luiscard/scripts

# Criar arquivo miner.service
echo "[2/7] Gerando arquivo systemd/miner.service..."
cat << 'EOF' > /home/luiscard/systemd/miner.service
[Unit]
Description=Minerador SHA256d (cpuminer-multi)
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
User=luiscard
WorkingDirectory=/home/luiscard

ExecStart=/home/luiscard/cpuminer-multi/cpuminer \
  --algo sha256d \
  --url stratum+tcp://public-pool.io:21496 \
  --user bc1qd95j6fk5sapalry4davrc8gjv8nqn3ygrj02xl.RPI3 \
  --pass x \
  --threads 4

Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

# Criar script de instalação do cpuminer
echo "[3/7] Gerando script scripts/install_cpuminer.sh..."
cat << 'EOF' > /home/luiscard/scripts/install_cpuminer.sh
#!/bin/bash

echo "=============================================="
echo "  Instalação automática do cpuminer-multi"
echo "  Ambiente: Ubuntu 25.10 (Raspberry Pi)"
echo "  Usuário configurado: luiscard"
echo "=============================================="
sleep 2

echo "[1/5] Atualizando sistema..."
sudo apt update && sudo apt upgrade -y

echo "[2/5] Instalando dependências..."
sudo apt install -y git build-essential automake libcurl4-openssl-dev

echo "[3/5] Clonando cpuminer-multi..."
cd /home/luiscard
if [ ! -d "cpuminer-multi" ]; then
    git clone https://github.com/tpruvot/cpuminer-multi.git
fi

echo "[4/5] Compilando cpuminer-multi..."
cd cpuminer-multi
./autogen.sh
./configure CFLAGS="-O3"
make

echo "[5/5] Instalando serviço miner.service..."
sudo cp /home/luiscard/systemd/miner.service /etc/systemd/system/miner.service
sudo systemctl daemon-reload
sudo systemctl enable miner.service

echo "=============================================="
echo "Instalação concluída!"
echo "Para iniciar o minerador agora, execute:"
echo "  sudo systemctl start miner.service"
echo "=============================================="
EOF

# Tornar script interno executável
chmod +x /home/luiscard/scripts/install_cpuminer.sh

# Executar script de instalação
echo "[4/7] Executando script de instalação..."
/home/luiscard/scripts/install_cpuminer.sh

# Ativar serviço
echo "[5/7] Ativando serviço miner.service..."
sudo systemctl daemon-reload
sudo systemctl enable miner.service

echo "[6/7] (Opcional) Iniciar o serviço agora..."
echo "Você pode iniciar manualmente com:"
echo "  sudo systemctl start miner.service"

# Finalização
echo "====================================================="
echo "Setup concluído!"
echo "Para verificar o status, use:"
echo "  systemctl status miner.service"
echo "====================================================="

Passo 5: Salvar o arquivo no nano
Depois de colar o conteúdo:
- Pressione Ctrl + O (a letra O de “output”).
- Ele vai perguntar o nome do arquivo (File Name to Write: setup_nerdminer.sh) – só aperte Enter.
- Depois pressione Ctrl + X para sair do nano.
Você volta ao terminal, ainda dentro da pasta ~/nerdminer-setup.

Passo 6: Tornar o script executável
Agora vamos dar permissão para o script poder ser executado como programa.
No terminal:
chmod +x setup_nerdminer.sh


Isso não mostra saída se der certo (silencioso), mas funciona.

Passo 7: Executar o script
Agora é a hora em que ele faz tudo sozinho.
No terminal:
./setup_nerdminer.sh


Durante a execução ele vai:

- Atualizar o sistema (apt update && upgrade)
- Instalar dependências
- Clonar o cpuminer-multi (se ainda não existir)
- Compilar o minerador
- Criar a pasta /home/luiscard/systemd
- Criar a pasta /home/luiscard/scripts
- Criar o arquivo /home/luiscard/systemd/miner.service
- Criar o arquivo /home/luiscard/scripts/install_cpuminer.sh
- Copiar o serviço para /etc/systemd/system/miner.service
- Ativar o serviço miner.service para iniciar no boot

Passo 8: Iniciar o minerador (primeira vez)
Depois que o script terminar, você pode iniciar o minerador manualmente:
sudo systemctl start miner.service



Passo 9: Verificar se está funcionando
Para ver o status:
systemctl status miner.service


Para ver os logs em tempo real:
journalctl -u miner.service -f


Se quiser testar reinício automático no boot:
sudo reboot


Depois que o Raspberry voltar:
systemctl status miner.service



