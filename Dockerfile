FROM jarrednicholls/rke

FROM debian:buster-slim

ARG HELM_VERSION=2.14.0
ARG KUBECTL_VERSION=1.14.2

# rke
COPY --from=0 /usr/bin/rke /usr/local/bin/

# curl + jq
RUN apt-get update \
    && apt-get install -y \
        ca-certificates \
        curl \
        jq \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# kubectl
RUN curl -LO https://dl.k8s.io/v${KUBECTL_VERSION}/kubernetes-client-linux-amd64.tar.gz \
    && tar xzf kubernetes-client-linux-amd64.tar.gz \
    && cp kubernetes/client/bin/kubectl /usr/local/bin/. \
    && rm -rf kubernetes*

# helm
RUN curl -LO https://storage.googleapis.com/kubernetes-helm/helm-v${HELM_VERSION}-linux-amd64.tar.gz \
    && tar xzf helm-v${HELM_VERSION}-linux-amd64.tar.gz \
    && cp linux-amd64/helm /usr/local/bin/. \
    && cp linux-amd64/tiller /usr/local/bin/. \
    && rm -rf linux-amd64 helm-v${HELM_VERSION}-linux-amd64.tar.gz
