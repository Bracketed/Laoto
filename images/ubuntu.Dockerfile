ARG VERSION="latest"

FROM ubuntu:${VERSION} AS base

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Set locale
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# ============================================================
# 1. Core system dependencies
# ============================================================
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    wget \
    gnupg \
    lsb-release \
    software-properties-common \
    apt-transport-https \
    locales \
    sudo \
    git \
    git-lfs \
    jq \
    unzip \
    zip \
    tar \
    gzip \
    bzip2 \
    xz-utils \
    ssh \
    openssh-client \
    build-essential \
    autoconf \
    automake \
    libtool \
    pkg-config \
    zlib1g-dev \
    libssl-dev \
    libffi-dev \
    libcurl4-openssl-dev \
    && locale-gen en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

# ============================================================
# 2. Docker CLI (for Docker-in-Docker or Docker socket mounting)
# ============================================================
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
    https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
    > /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends docker-ce-cli \
    && rm -rf /var/lib/apt/lists/*

# ============================================================
# 3. Common language runtimes & tools
# ============================================================

# Node.js (LTS)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && npm install -g yarn pnpm \
    && rm -rf /var/lib/apt/lists/*

# Python 3
RUN add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-venv \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Go
ARG GO_VERSION=1.22.0
RUN curl -fsSL "https://go.dev/dl/go${GO_VERSION}.linux-$(dpkg --print-architecture).tar.gz" \
    | tar -C /usr/local -xz
ENV PATH="/usr/local/go/bin:${PATH}"

# ============================================================
# 4. Utility tools (similar to GitHub-hosted runners)
# ============================================================
RUN apt-get update && apt-get install -y --no-install-recommends \
    rsync \
    file \
    findutils \
    iproute2 \
    iputils-ping \
    dnsutils \
    net-tools \
    telnet \
    time \
    tzdata \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

# ============================================================
# 5. Create a non-root runner user
# ============================================================
RUN useradd -m -s /bin/bash runner \
    && echo "runner ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/runner \
    && chmod 0440 /etc/sudoers.d/runner

# ============================================================
# 6. Set up working directories
# ============================================================
RUN mkdir -p /home/runner/work /home/runner/tools /home/runner/scripts \
    && chown -R runner:runner /home/runner

# ============================================================
# 7. Environment variables for the runner
# ============================================================
ENV RUNNER_TOOL_CACHE=/home/runner/tools
ENV RUNNER_WORKSPACE=/home/runner/work
ENV HOME=/home/runner
ENV PATH="/home/runner/tools:${PATH}"

# ============================================================
# 8. Entrypoint
# ============================================================
WORKDIR /home/runner/work
USER runner

# Your runner agent/daemon entrypoint goes here
# COPY runner-agent /home/runner/runner-agent
# ENTRYPOINT ["/home/runner/runner-agent"]

# Default to bash for now
CMD ["/bin/bash"]