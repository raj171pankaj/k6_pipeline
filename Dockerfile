FROM node:20.16-alpine

WORKDIR /tmp
RUN apk update && apk add --no-cache wget curl

# RUN apk update && apk add --no-cache \
#     curl \
#     wget \
#     fontconfig \
#     nss \
#     freetype \
#     ttf-freefont \
#     zip \
#     unzip \
#     bash \
#     libstdc++ \
#     alsa-lib

RUN wget https://github.com/grafana/k6/releases/download/v0.52.0/k6-v0.52.0-linux-amd64.tar.gz && \
    tar -xzf k6-v0.52.0-linux-amd64.tar.gz && \
    mv k6-v0.52.0-linux-amd64/k6 /usr/local/bin/k6 && \
    rm -rf k6-v0.52.0-linux-amd64*


# Install Chrome
# RUN CHROME_FOR_TESTING_VERSION="127.0.6533.119" \
# && echo "Downloading Chrome for testing version: $CHROME_FOR_TESTING_VERSION" 
# RUN wget --no-verbose --output-document /tmp/chrome.zip https://storage.googleapis.com/chrome-for-testing-public/127.0.6533.119/linux64/chrome-linux64.zip 
# RUN unzip -qq /tmp/chrome.zip -d /opt/chrome 
# RUN chmod +x /opt/chrome/chrome-linux64/chrome 
# RUN ln -s /opt/chrome/chrome-linux64/chrome /usr/local/bin/chrome
# RUN chmod -R +x "/usr/local/bin/chrome"

# Download and install Chrome
# RUN wget -q -O /tmp/chrome.zip https://storage.googleapis.com/chrome-for-testing-public/127.0.6533.119/linux64/chrome-linux64.zip 
# RUN unzip -qq /tmp/chrome.zip -d /opt/chrome 
# RUN chmod +x /opt/chrome/google-chrome 
# RUN chmod +x /opt/chrome/chrome 
# RUN ln -s /opt/chrome/google-chrome /usr/local/bin/google-chrome 
# RUN ln -s /opt/chrome/chrome /usr/local/bin/chrome 
# RUN rm -rf /tmp/chrome.zip

# RUN google-chrome --version


WORKDIR /
RUN ls -a
RUN pwd
WORKDIR /k6_pipeline
COPY . /k6_pipeline/
RUN pwd
ENTRYPOINT ["sh", "-c", "pwd && K6_BROWSER_HEADERLESS=false && k6 run ./main.js"]