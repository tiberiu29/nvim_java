FROM archlinux:base

RUN sed -i '/NoExtract.*usr\/share\/man/d' /etc/pacman.conf && \
    sed -i '/NoExtract.*usr\/share\/doc/d' /etc/pacman.conf && \
    sed -i '/NoExtract.*usr\/share\/info/d' /etc/pacman.conf


RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm --overwrite '*' \
      which \
      man-db man-pages less \
      vim git curl gcc make unzip tar gzip ripgrep \
      python uv \
      jdk25-openjdk maven \
      tree-sitter-cli && \
    pacman -Scc --noconfirm

RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz && \
    rm -rf /opt/nvim-linux-x86_64 && \
    tar -C /opt -xzf nvim-linux-x86_64.tar.gz && \
    rm -f nvim-linux-x86_64.tar.gz

ENV PATH="/opt/nvim-linux-x86_64/bin:${PATH}"

COPY . /root/.config/nvim

RUN rm -f /root/.config/nvim/Dockerfile /root/.config/nvim/.dockerignore

RUN mandb

WORKDIR /projects