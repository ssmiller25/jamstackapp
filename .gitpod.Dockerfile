# From psuedo-official docker image as per https://gohugo.io/getting-started/installing/#docker
FROM klakegg/hugo:0.65.2-busybox AS hugo-source


FROM gitpod/workspace-full

ARG hugo-version=0.65.2

# Ported from Makefile.  Eventually might just force the use of a docker container for prereq...

# Utilities to Add
RUN sudo apt-get update && sudo apt-get install -y \
  shellcheck \
  && sudo rm -rf /var/lib/apt/lists/*

# Install Arcade
RUN curl -sLS https://get.arkade.dev | sh && \
    sudo mv arkade /usr/local/bin/

# INstall basic k8s utilities and civo
RUN for util in civo kubectl helm kustomize; do \
  arkade get ${util}; \
  sudo mv .arkade/bin/${util} /usr/local/bin/; \
  done

# Install Hugo
USER root
COPY --from=hugo-source /bin/hugo /usr/local/bin/hugo
USER gitpod

#RUN mkdir tmpdownload && \
#  cd tmpdownload && \
#  curl -LO https://github.com/gohugoio/hugo/releases/download/v0.65.2/hugo_v0.65.2-version_Linux-64bit.tar.gz && \
#  tar -xzf hugo*.tar.gz && \
#  sudo mv hugo /usr/local/bin && \
#  cd .. && \
#  rm -rf tmpdownload
