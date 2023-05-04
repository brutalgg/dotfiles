FROM debian:10

# fix for utf-8 encoding missing in containers
ENV PURE_PROMPT_SYMBOL='>'

RUN apt update
RUN apt install -y sudo nano rsync zsh git tree dnsutils net-tools gnupg && apt autoclean && apt autoremove

# Create test user and add to sudoers
RUN useradd -m -s /bin/bash tester
RUN usermod -aG sudo tester
RUN echo "tester   ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers

# Add dotfiles and chown
ADD . /home/tester/dotfiles
RUN chown -R tester:tester /home/tester

# Switch testuser
USER tester
ENV HOME /home/tester

# Change working directory
WORKDIR /home/tester/dotfiles

# Init GPG key for testing
RUN gpg --batch --generate-key keygen

# Run setup
RUN ./bootstrap.sh -f
WORKDIR  /home/tester

CMD ["/bin/bash"]
