BootStrap: docker
From: ghcr.io/truatpasteurdotfr/cellpose:master

%runscript
cat <<EOF
eval "$(/opt/conda/bin/conda shell.bash hook)"
conda activate cellpose
python -m cellpose
EOF

