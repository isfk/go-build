FROM golang:1.24

ARG TARGETARCH

VOLUME [ "/data/go_pkg", "/go/pkg" ]

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
RUN curl -LO https://github.com/upx/upx/releases/download/v5.0.1/upx-5.0.1-${TARGETARCH}_linux.tar.xz
RUN tar xvJf upx-5.0.1-${TARGETARCH}_linux.tar.xz -C /usr/bin --strip-components=1 upx-5.0.1-${TARGETARCH}_linux/upx

# 设置环境变量
ENV PATH=$PATH:/usr/local/go/bin:/root/go/bin
ENV GOPROXY=https://goproxy.io,direct

# 安装 node 24
RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash -
RUN apt-get install -y nodejs

# 配置 npm 镜像
RUN npm config set registry https://mirrors.huaweicloud.com/repository/npm/

# 安装 pnpm
RUN npm install -g pnpm