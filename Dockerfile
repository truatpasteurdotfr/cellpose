FROM continuumio/miniconda3

RUN apt-get update && \
    apt-get install -y && \
    apt-get install -y wget bzip2 && \
    apt-get install -y libglu1-mesa 

# https://github.com/MouseLand/cellpose/blob/master/.github/workflows/test_and_deploy.yml
RUN apt-get install -y \
          libdbus-1-3 libxkbcommon-x11-0 libxcb-icccm4 \
          libxcb-image0 libxcb-keysyms1 libxcb-randr0 libxcb-render-util0 \
          libxcb-xinerama0 libxcb-xinput0 libxcb-xfixes0 pkg-config libhdf5-103 libhdf5-dev && \
    rm -rf /var/lib/apt/lists/*

RUN conda update --yes conda && \
    conda update -n base -c defaults conda -y && \
    conda update --all -y && \
    conda create --name cellpose python=3.8 && \
    conda activate cellpose && \
    conda install pytorch cudatoolkit=11.3 -c pytorch && \
    python -m pip install cellpose[all]

