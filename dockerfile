FROM node:14.17-bullseye
# Install packages
RUN apt-get update
RUN apt-get install --no-install-recommends -y \
    git \
    jq \
    sudo \
    vim

#Clear apt cache   
RUN apt-get clean -y

#Set password and sudo
ARG PASSWORD=ardrive
RUN echo "root:${PASSWORD}" | chpasswd
RUN echo "node:${PASSWORD}" | chpasswd
RUN adduser node sudo
#Set home var
ENV HOME /home/node

#RUN apt-get clean -y
COPY scripts/gitClone.sh /home/node/
RUN chmod +x /home/node/gitClone.sh
COPY scripts/yarnInstall.sh /home/node/
RUN chmod +x /home/node/yarnInstall.sh
COPY scripts/entry.sh /home/node/
RUN chmod +x /home/node/entry.sh
COPY scripts/.bashrc_patch /home/node/
RUN chmod +r /home/node/.bashrc_patch

# Use non-root user
USER node
WORKDIR $HOME
# Set env to tmpfs path
ENV WALLET /home/node/tmp/wallet.json
# Create uplads folder
RUN mkdir uploads
# Patch bashrc
RUN cat .bashrc_patch >> .bashrc
# Start with Bash
ENTRYPOINT [ "/bin/bash" ]


