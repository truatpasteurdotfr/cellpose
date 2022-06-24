BootStrap: docker
From: ghcr.io/truatpasteurdotfr/cellpose:master

%runscript
exec bash -c 'eval "$(/opt/conda/bin/conda shell.bash hook)" && conda activate cellpose && python -m cellpose "$@"'

