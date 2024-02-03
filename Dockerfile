ARG BUILD_FROM=hassioaddons/base:edge
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base
# hadolint ignore=DL3003
RUN \
    apk add --no-cache --virtual .build-deps python3 make g++ linux-headers
RUN \
    apk add --no-cache npm

# Copy root filesystem
# COPY rootfs/srv/package-lock.json /srv
COPY rootfs/srv/package.json /srv

WORKDIR /srv

# RUN npm ci
RUN npm install

RUN apk del --no-cache --purge .build-deps && rm -rf /root/.npm /root/.cache

COPY rootfs/ /

# # Build arguments
# ARG BUILD_ARCH
# ARG BUILD_DATE
# ARG BUILD_DESCRIPTION
# ARG BUILD_NAME
# ARG BUILD_REF
# ARG BUILD_REPOSITORY
# ARG BUILD_VERSION

# # Labels
# LABEL \
#     io.hass.name="${BUILD_NAME}" \
#     io.hass.description="${BUILD_DESCRIPTION}" \
#     io.hass.arch="${BUILD_ARCH}" \
#     io.hass.type="addon" \
#     io.hass.version=${BUILD_VERSION} \
#     maintainer="Franck Nijhof <frenck@addons.community>" \
#     org.opencontainers.image.title="${BUILD_NAME}" \
#     org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
#     org.opencontainers.image.vendor="Home Assistant Community Add-ons" \
#     org.opencontainers.image.authors="Franck Nijhof <frenck@addons.community>" \
#     org.opencontainers.image.licenses="MIT" \
#     org.opencontainers.image.url="https://addons.community" \
#     org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
#     org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
#     org.opencontainers.image.created=${BUILD_DATE} \
#     org.opencontainers.image.revision=${BUILD_REF} \
#     org.opencontainers.image.version=${BUILD_VERSION}
