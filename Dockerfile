FROM python:3.9-alpine

RUN apt add --no-cache \
  autoconf \
  automake \
  build-base \
  cmake \
  coreutils \
  curl \
  gettext-tiny-dev \
  git \
  libtool \
  pkgconf \
  unzip

RUN cd ~ \
  sudo rm -r neovim \
  git clone https://github.com/neovim/neovim \
  cd neovim \
  make CMAKE_BUILD_TYPE=Release install \
  cd ~ \
  sudo rm -r neovim \
  bash <(curl -s https://raw.githubusercontent.com/ChristianChiarulli/nvim/master/utils/installer/install.sh)


RUN apk add --nocache \
  bash \
  build-base \
  curl \
  gcc \
  git \
  go \
  nodejs \
  ranger \
  ripgrep \
  python3 \
  python3-dev \
  shadow \
  su-exec \
  unzip \
  yarn

RUN curl https://bootstrap.pypa.io/get-pip.py -o "/get-pip.py" \
  python3 "/get-pip.py" \
  rm -rf "/get-pip.py"

RUN su-exec neovim:neovim nvim --headless +PlugInstall +qa
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
CMD ["python3"]
