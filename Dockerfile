FROM tcardonne/github-runner:latest

COPY --from=lachlanevenson/k8s-kubectl:v1.20.4 /usr/local/bin/kubectl /usr/local/bin/kubectl

RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
    && chmod 700 get_helm.sh \
    && ./get_helm.sh \
    && rm get_helm.sh

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install -y \
        less \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

RUN curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose
