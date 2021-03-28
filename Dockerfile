FROM python:3.9-alpine

RUN apk add  \
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
  yarn \
  zsh \

RUN apk add \
  neovim=0.5.0

RUN apk update && apk cache clean

ADD repo-key /
RUN \
  chmod 600 /repo-key && \
  echo "IdentityFile /repo-key" >> /etc/ssh/ssh_config && \
  echo -e "StrictHostKeyChecking no" >> /etc/ssh/ssh_config && \
RUN git config --global user.email "gustavo.barrios@gmail.com"
RUN git config --global user.name "Gustavo Barrios"

RUN curl https://bootstrap.pypa.io/get-pip.py -o "/get-pip.py" \
  && python3 "/get-pip.py" \
  && rm -rf "/get-pip.py"

RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
RUN cd ~ && touch .zsh_history
RUN nvim --headless +PlugInstall +qa
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ChristianChiarulli/nvim/master/utils/installer/install.sh)"
CMD ["python3"]
