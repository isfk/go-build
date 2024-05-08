FROM golang:1.22

ARG TARGETARCH

COPY sources.list /etc/apt/sources.list

# 更新软件源并安装必要的依赖
RUN apt-get update && apt-get install -y \
    gcc-x86-64-linux-gnu \
    curl \
    git \
    rsync \
    xz-utils

# 安装 rice
RUN go install github.com/GeertJohan/go.rice/rice@latest

# 安装 upx
RUN curl -LO https://github.com/upx/upx/releases/download/v4.2.3/upx-4.2.3-${TARGETARCH}_linux.tar.xz
RUN tar xvJf upx-4.2.3-${TARGETARCH}_linux.tar.xz -C /usr/bin --strip-components=1 upx-4.2.3-${TARGETARCH}_linux/upx

# 设置环境变量
ENV PATH=$PATH:/usr/local/go/bin:/root/go/bin
ENV GOPROXY=https://proxy.golang.com.cn,direct

# 安装 nodejs20
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
    RUN apt-get install -y nodejs