<p align="center">
  <img src="docs/capa.png" width="600" alt="NerdMiner CPU Node">
</p>

<h1 align="center">NerdMiner CPU Node – Raspberry Pi + Ubuntu 25.10</h1>

<p align="center">
  Mineração CPU automatizada com systemd • Raspberry Pi 3 • Ubuntu 25.10
</p>
![Status](https://img.shields.io/badge/status-active-brightgreen)
![Ubuntu](https://img.shields.io/badge/Ubuntu-25.10-blue)
![RaspberryPi](https://img.shields.io/badge/Raspberry%20Pi-3B+-red)
![License](https://img.shields.io/badge/license-MIT-yellow)
![CPU Mining](https://img.shields.io/badge/mining-CPU-orange)
![Systemd](https://img.shields.io/badge/systemd-enabled-lightgrey)

NerdMiner CPU Node on Raspberry Pi (Ubuntu 25.10)
# NerdMiner CPU Node on Raspberry Pi (Ubuntu 25.10)
Projeto para rodar um minerador CPU (cpuminer-multi) em um Raspberry Pi com Ubuntu 25.10
(questing), gerenciado por systemd, com reinício automático após queda de energia ou travamento.
## Índice
1. Ambiente e requisitos
2. Instalação do sistema e dependências
3. Clonando e compilando o cpuminer-multi
4. Configurando o serviço systemd do minerador
5. Comandos úteis (monitorar, reiniciar, parar)
6. Logs, desempenho e ajuste de threads
7. Estrutura do projeto para GitHub
8. Riscos, limitações e observações
9. Licença e créditos
(Conteúdo completo conforme fornecido anteriormente.)


# 📌 Sobre o Projeto

Este projeto transforma um Raspberry Pi 3 rodando Ubuntu 25.10 em um **nó de mineração CPU totalmente automatizado**, usando:

- `cpuminer-multi`
- `systemd` para reinício automático
- scripts de instalação
- serviço dedicado `miner.service`

Ideal para aprendizado, experimentação e demonstração de automação Linux.

---

# 🚀 Instalação Rápida

```bash
chmod +x setup_nerdminer.sh
./setup_nerdminer.sh


