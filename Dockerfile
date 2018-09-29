FROM archimg/base-devel as base

RUN useradd -u 1000 -G wheel -m archlinux
RUN useradd -u 2000 -G wheel -m travis
RUN echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && echo 'ja_JP.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen
RUN pacman -Sy --noconfirm git yasm namcap

USER archlinux

RUN cd /tmp && \
	curl -L -O https://aur.archlinux.org/cgit/aur.git/snapshot/libnatspec.tar.gz \
	&& tar xf libnatspec.tar.gz && cd libnatspec && makepkg --noconfirm -si

WORKDIR /mnt
