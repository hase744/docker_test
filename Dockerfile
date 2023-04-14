#Docker Image を指定します。使用しているアプリのバージョンを指定します。
FROM ruby:3.0.2

# 必要なパッケージのインストール。node.jsについては当初の記述だとエラーが出たため、修正。
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get update && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリの作成、設定
RUN mkdir /workdir
WORKDIR /workdir

# ホスト側（ローカル）のGemfileを上記で作成した/workdirに追加する
ADD Gemfile /workdir/Gemfile
ADD Gemfile.lock /workdir/Gemfile.lock

# Gemfileのbundle install　
# ENVなしで実行したところエラーが出た。BUNDLER_VERSIONを指定することで回避。
ENV BUNDLER_VERSION 2.3.9
RUN gem install bundler
RUN bundle install

# ホスト側（ローカル）の全てのディレクトリをDocekrコンテナの/workdir配下に追加。
ADD . /workdir
CMD ["sh", "/start.sh"]