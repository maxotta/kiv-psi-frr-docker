FROM quay.io/frrouting/frr:10.0.4

LABEL maintainer="maxmilio@kiv.zcu.cz" \
      org.opencontainers.image.source="https://github.com/maxotta/kiv-psi-frr-docker"

COPY start.sh /usr/lib/frr/start.sh
RUN chmod +x /usr/lib/frr/start.sh

ENTRYPOINT [ "/usr/lib/frr/start.sh" ]
