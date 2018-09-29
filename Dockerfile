FROM archimg/base-devel as base

RUN useradd -m archlinux
RUN echo archlinux:archlinux | chpasswd
RUN echo 'archlinux ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && echo 'ja_JP.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen
RUN pacman -Sy --noconfirm git yasm

USER archlinux

RUN cd /tmp && \
	curl -L -O https://aur.archlinux.org/cgit/aur.git/snapshot/libnatspec.tar.gz \
	&& tar xf libnatspec.tar.gz && cd libnatspec && makepkg --noconfirm -si

WORKDIR /mnt
