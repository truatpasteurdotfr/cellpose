FROM ghcr.io/prefix-dev/pixi

RUN \
	apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade && \
	DEBIAN_FRONTEND=noninteractive apt-get -y install curl && \
	DEBIAN_FRONTEND=noninteractive apt-get -y autoremove && \
	DEBIAN_FRONTEND=noninteractive apt-get clean all

RUN pixi --version

RUN cd /opt && pixi init py312-cellpose && cd py312-cellpose && \
	pixi add python=3.12 pip setuptools matplotlib pytest && \
	pixi add --pypi 'cellpose[gui]' 

RUN cd /opt/py312-cellpose && pixi shell-hook  > /shell-hook.sh && echo 'exec "$@"' >> /shell-hook.sh
ENTRYPOINT ["/bin/bash", "/shell-hook.sh"]

