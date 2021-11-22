# Ardrive Cli Docker
Contains Dockerfile and all CI-related tooling to build a Docker image for the ArDrive CLI.

Knowledge on how to set-up Docker is expected.

Password for both root and node user inside the Docker is "ardrive"
## Intended Audience
This tool is intended for use by:

ArDrive power users with advanced workflows and automation in mind: bulk uploaders, those with a larger storage demand, developers, nft creators, storage/db admins, etc.

Automated workflows

Services

#### CLI tools build-in

git

jq

sudo

vim

## Build image

On repo root:

``docker build . -t ardrive-cli:latest``

## Run Ardrive-CLI docker
 
The suggested way to run the image is with the following command

``docker run --name ardrive --rm --init -it --mount type=tmpfs,destination=/home/node/tmp ardrive-cli``

#### Explanation

``--name ardrive-cli`` name we assign to CLI Docker. In this case "ardrive-cli"

``--rm`` Docker will not persist once stopped.

``--init`` Enforces an init process as PID 1.

``--it`` Interactive and with a TTY.

``--mount type=tmpfs,destination=/home/node/tmp`` Temporary in-memory file system that we use to store a wallet safely

### Build a specific branch

We proportionate the branch with an ENV variable at run. e.g. to build dev branch ``-e BRANCH='dev'`` 

Sample command:

``docker run --name ardrive --rm --init -it -e BRANCH='dev' --mount type=tmpfs,destination=/home/node/tmp ardrive-cli``

Environment variables that control the build process:

``-e NO_SETUP=1 `` skips cloning and building

``-e NO_AUTOBUILD=1 `` skips building process

## Interact with a wallet

### Put wallet inside your container

To copy our wallet inside Docker, we just need the following command.
Image was intended to work with only ONE wallet at a time. 

Running the below command a 2nd time will overwrite the 1st wallet.

``docker exec -i ardrive sh -c 'cat > /home/node/tmp/wallet.json' < [path to my wallet file]``

Bear in mind that with this method, Wallet file is never written to host system.

### Wallet Operations

There is a $WALLET variable directly pointing to /home/node/tmp/wallet.json inside the Docker.

In order to run any command that requires a wallet you could just replace its path with $WALLET

e.g. for a private file

``yarn ardrive file-info -f [file-id] -w $WALLET -p [my-unsafe-password]``

## Uploading files

In order to upload stuff, you need to load your files into the container.

Sample command:
``docker cp [file-or-folder-path] ardrive:home/node/uploads``

