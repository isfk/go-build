FROM node:16-bullseye

ARG TARGETARCH

# 更新软件源并安装必要的依赖
RUN apt-get update && apt-get install -y \
    curl \
    git \
    rsync

# 安装 go 1.21
RUN curl -LO https://go.dev/dl/go1.21.5.linux-${TARGETARCH}.tar.gz
RUN tar -C /usr/local -xzf go1.21.5.linux-${TARGETARCH}.tar.gz
RUN rm go1.21.5.linux-${TARGETARCH}.tar.gz

# 设置环境变量
ENV PATH=$PATH:/usr/local/go/bin:/root/go/bin
ENV GOPROXY=https://proxy.golang.com.cn,direct