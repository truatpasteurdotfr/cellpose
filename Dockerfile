#FROM ghcr.io/prefix-dev/pixi AS build
FROM ghcr.io/prefix-dev/pixi:trixie-slim
RUN pixi --version

RUN cd /opt && pixi init py312-cellpose && cd py312-cellpose && \
	pixi add python=3.12 pip setuptools matplotlib pytest jupyter && \
	pixi add --pypi 'cellpose[gui]' 

RUN cd /opt/py312-cellpose && pixi shell-hook  > /shell-hook.sh && echo 'exec "$@"' >> /shell-hook.sh
ENTRYPOINT ["/bin/bash", "/shell-hook.sh"]

#FROM debian:13 AS production
RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade && \
	DEBIAN_FRONTEND=noninteractive apt-get -y install \
		curl  \
		libdbus-1-3 \
		libegl-mesa0 \
		libegl1 \
		libfontconfig1 \
		libfreetype6 \
		libgl1 \
		libglib2.0-0t64 \
		libglu1-mesa \
		libhdf5-dev \
		libhdf5-hl-310 \
		libhdf5-hl-fortran-310 \
		libxcb-cursor0 \
		libxcb-icccm4 \
		libxcb-keysyms1 \
		libxcb-shape0 \
		libxcb-xinerama0 \
		libxcb-xinput0 \
		libxkbcommon-x11-0 \
		pkg-config \
	&& \
	DEBIAN_FRONTEND=noninteractive apt-get -y autoremove && \
	DEBIAN_FRONTEND=noninteractive apt-get clean all
#COPY --from=build /opt/py312-cellpose /opt/py312-cellpose
#COPY --from=build /shell-hook.sh /shell-hook.sh

#ENTRYPOINT ["/bin/bash", "/shell-hook.sh"]
