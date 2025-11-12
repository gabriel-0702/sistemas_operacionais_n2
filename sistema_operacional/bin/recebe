entrada="/tmp/input"
saida="/tmp/output"

[ ! -p "$entrada" ] && mkfifo -m 600 "$entrada"
[ ! -p "$saida" ] && mkfifo -m 600 "$saida"

trap 'echo "Leitor: recebido SIGINT, saindo..."; exit 0' INT TERM

echo "Leitor: pronto. Aguardando mensagens em $entrada"

while true; do
  if read -r LINE < "$entrada"; then
    TS="$(date '+%Y-%m-%d %H:%M:%S')"
    echo "Leitor recebeu: $LINE"
    REPLY="Confirmação do leitor em $TS (recebido: $LINE)"
    echo "$REPLY" > "$saida"
  else
    echo "Leitor: leitura falhou ou foi interrompida"
    sleep 1
  fi
done
