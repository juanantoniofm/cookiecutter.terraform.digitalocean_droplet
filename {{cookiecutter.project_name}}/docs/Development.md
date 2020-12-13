
# Development

If you want to contribute, feel free to fork and open a PR, or open an issue on github with your feature, bug, or question.


## random notes

Troubleshot the script in /var/lib/cloud/instance/scripts/runcmd

## Status

### Done

- [x] Spins up a droplet in digitalocean.
- [x] added a db cluster with mysql 8 to it.
- [x] Injecting secrets via cloudinit templatefile.
- [x] And we need to configure the ip of the db on the instance
- [x] Add "Trusted sources" to the db
- [x] git clone host verification
- [x] install docker-compose
- [x] Add other db and trafiek config vars to the env file
- [ ]  If the ssh key injection works, inject an env file as well.

### To Do

- [ ]  Unlock the bloody user account
  - I tried with the usermod command, but it does'nt work on cloud-init.
  - when i run it manually as root, it does work... ffs
  - I'm trying to debug with a custom stdout/err redirection on the command.
  - it failed as well
  - i unlocked it in the cloud init. it failed as well.

