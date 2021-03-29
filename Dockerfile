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
  pacman \
  npm \
  zsh \
  zsh-vcs \
  sudo \
  fzf \
  && rm -rf /var/cache/apk/*

WORKDIR /tmp
RUN adduser -D leno -u 1000 -G users
RUN  git clone https://github.com/neovim/neovim.git && \
  cd neovim && \
  make && \
  make install && \
  cd .. && rm -r neovim
RUN apk update
RUN git config --global user.email "gustavo.barrios@gmail.com"
RUN git config --global user.name "Gustavo Barrios"
RUN curl https://bootstrap.pypa.io/get-pip.py -o "/get-pip.py" \
  && python "/get-pip.py" \
  && rm -rf "/get-pip.py"
RUN pip install --user flake8
RUN pip install --user yapf
RUN pip install --user pynvim
RUN pip install 'python-language-server[all]'
RUN npm install -g prettier
RUN npm i -g tree-sitter-cli --unsafe-perm=true --allow-root
RUN cd ~ && touch .zsh_history
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
RUN cd ~ && touch .zsh_history
RUN mkdir /root/.config/nvim
RUN cd ~/.config/nvim && curl -LJO https://raw.githubusercontent.com/beauwilliams/Dotfiles/master/Vim/nvim-pre-lua/init.vim && curl -LJO https://raw.githubusercontent.com/beauwilliams/Dotfiles/master/Vim/nvim-pre-lua/coc-settings.json;
RUN nvim --headless +PlugInstall +qa
CMD ["python"]
