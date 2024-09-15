FROM ubuntu:22.04

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y \
    unzip \
    curl \
    sudo \
    git \
    vim \ 
    && apt-get clean

# Node.jsとnpmのインストール
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - \
    && apt-get install -y nodejs

# AWS CLIのインストール
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && sudo ./aws/install \
    && rm -rf awscliv2.zip

# AWS SAM CLIをダウンロードしてインストール
RUN curl -Lo aws-sam-cli-linux-x86_64.zip https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip \
    && unzip aws-sam-cli-linux-x86_64.zip -d sam-installation \
    && sudo ./sam-installation/install \
    && rm -rf aws-sam-cli-linux-x86_64.zip sam-installation

# AWS CLIの設定
RUN aws configure set aws_access_key_id "dummy-access-key" \
    && aws configure set aws_secret_access_key "dummy-secret-key" \
    && aws configure set default.region "ap-northeast-1" \
    && aws configure set default.output "json"

# Terraformのインストール
RUN git clone https://github.com/tfutils/tfenv.git ~/.tfenv \
    && echo 'export PATH="$HOME/.tfenv/bin:$HOME/.tfenv/versions/latest/bin:$PATH"' >> ~/.bashrc \
    && export PATH="$HOME/.tfenv/bin:$HOME/.tfenv/versions/latest/bin:$PATH" \
    && tfenv install latest \
    && tfenv use latest

WORKDIR /usr/src/app

# TypeScriptとAWS CDKのインストール
RUN npm install -g typescript aws-cdk

CMD ["bash"]
