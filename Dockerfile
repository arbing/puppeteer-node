FROM satantime/puppeteer-node:16-slim

RUN echo "Asia/Shanghai" > /etc/timezone

ENV PUPPETEER_SKIP_DOWNLOAD=true
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

RUN apt-get update && apt-get install -y chromium --no-install-recommends
