#!/bin/sh
# gov.br: o IRPF abre o navegador (Desktop/xdg-open) e escuta callback HTTP em localhost.
export NO_AT_BRIDGE=1
export GTK_MODULES=
export BROWSER=/usr/local/bin/firefox
# Home montado em /home/irpf — alinha cookie X11 com DISPLAY do host
if [ -z "${XAUTHORITY:-}" ] && [ -f /home/irpf/.Xauthority ]; then
  export XAUTHORITY=/home/irpf/.Xauthority
fi

exec java -Xms128M -Xmx512M -Djava.awt.headless=false -jar /opt/IRPF$ANO/irpf.jar
