FROM alpine:3.11

ENV GOSEC_VERSION=2.2.0 \
    TFSEC_VERSION=0.19.0 \
    KUBE_SCORE_VERSION=1.5.0 \
    GITLEAKS_VERSION=3.3.0

USER root

RUN apk add --no-cache curl bash ansible-lint \
    && curl -LO "https://github.com/securego/gosec/releases/download/v${GOSEC_VERSION}/gosec_${GOSEC_VERSION}_linux_amd64.tar.gz" \
    && tar -C /usr/local/bin/ -xvf gosec_${GOSEC_VERSION}_linux_amd64.tar.gz \
    && chmod +x /usr/local/bin/gosec \
    && rm gosec_${GOSEC_VERSION}_linux_amd64.tar.gz \
    && curl -LO "https://storage.googleapis.com/shellcheck/shellcheck-stable.linux.x86_64.tar.xz" \
    && tar -C /tmp/ -xvf shellcheck-stable.linux.x86_64.tar.xz \
    && cp /tmp/shellcheck-stable/shellcheck /usr/local/bin/shellcheck \
    && chmod +x /usr/local/bin/shellcheck \
    && rm shellcheck-stable.linux.x86_64.tar.xz 
RUN curl -L "https://github.com/zricethezav/gitleaks/releases/download/v${GITLEAKS_VERSION}/gitleaks-linux-amd64" -o "/usr/local/bin/gitleaks" \
    && chmod +x /usr/local/bin/gitleaks \
    && curl -L "https://github.com/liamg/tfsec/releases/download/v${TFSEC_VERSION}/tfsec-linux-amd64" -o "/usr/local/bin/tfsec" \
    && chmod +x /usr/local/bin/tfsec \
    && curl -L "https://github.com/zegl/kube-score/releases/download/v${KUBE_SCORE_VERSION}/kube-score_${KUBE_SCORE_VERSION}_linux_amd64" -o "/usr/local/bin/kube-score" \
    && chmod +x /usr/local/bin/kube-score
COPY entrypoint.bash /entrypoint.bash

ENTRYPOINT ["/entrypoint.bash"]
