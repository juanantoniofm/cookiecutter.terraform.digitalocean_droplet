# Digital Ocean Droplet, using terraform

The plan is to create an instance, that can deploy any git repo,
given a good enough ssh key.
I usually run a repo with a docker-compose or similar.

## Plans

This repo will spin up one machine, and then
from it clone a repo with a basic docker compose config.

This will give us a working base for bulding a dev setup on the cloud.

## Usage

To start using this repo, after cloning it, you'll need to install some tols, and create a few secrets.

TODO: Write up cookicutter instructions
TODO: write up how to generate or provide tthe correct secrets

### Previous steps required

- create a ssh key in .secrets/deploy

        ssh-keygen 

- create a digitalocean token and put it in tf.vars

    Go to digitalocean.com and open and accont. Go to settings, API and generate a new token.

- At this point, to configure the application, you will need another repo, [docker.jatos](github.com/juanantoniofm/docker.jatos), to hold the configuration of the services you want to spin up.

## Support

If you have trouble using this, open an issue on Github.

## Development

If you want to participate, open an issue on Github.

I keep a [Development](docs/Development.md) document with some notes on the status and steps that I take.
