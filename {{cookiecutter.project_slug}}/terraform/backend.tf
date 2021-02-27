


resource "digitalocean_droplet" "web" {
  image              = "ubuntu-20-04-x64"
  name               = "{{cookiecutter.project_slug}}-web"
  region             = "ams3"
  size               = "s-1vcpu-1gb"
  monitoring         = true
  ipv6               = true
  private_networking = true
  tags               = ["{{cookiecutter.project_slug}}-web"]
  user_data = templatefile("user-data.yaml.tmpl", {
    {% if cookiecutter.enable_database == "yes" %}
    dbpassword         = digitalocean_database_user.{{cookiecutter.project_slug}}.password
    dbhost             = digitalocean_database_cluster.mysql_{{cookiecutter.project_slug}}.host
    dbport             = digitalocean_database_cluster.mysql_{{cookiecutter.project_slug}}.port
    dbname             = digitalocean_database_db.{{cookiecutter.project_slug}}db.name
    {% endif %}
    ssh_{{cookiecutter.project_slug}}_password = random_password.ssh_{{cookiecutter.project_slug}}_password.result
    ssh_{{cookiecutter.project_slug}}_pkey     = filebase64("../.secrets/deploy")
    ssh_admin_public   = file("../.secrets/admin.pub") # Load the admins key. created with make init.
  })
  ssh_keys = [digitalocean_ssh_key.{{cookiecutter.project_slug}}_key.id]
}


resource "digitalocean_ssh_key" "{{cookiecutter.project_slug}}_key" {
  name       = "{{cookiecutter.project_slug}} admin user key"
  public_key = file("../.secrets/admin.pub")
}

resource "random_password" "ssh_{{cookiecutter.project_slug}}_password" {
  length           = 16
  special          = true
  override_special = "_%@!;"
}


// Because we want a floating IP that persists between refreshes
resource "digitalocean_floating_ip" "external_ip" {
  droplet_id = digitalocean_droplet.web.id
  region     = digitalocean_droplet.web.region
}


resource "local_file" "sshconf" {
  content  = <<-EOT
        Host {{cookiecutter.project_slug}}-rescue
            HostName ${digitalocean_droplet.web.ipv4_address}
            Port 22
            User root
            EscapeChar none
        
        Host {{cookiecutter.project_slug}}-root
            HostName ${digitalocean_droplet.web.ipv4_address}
            Port 22022
            User root
            EscapeChar none

        Host {{cookiecutter.project_slug}}-web
            HostName ${digitalocean_droplet.web.ipv4_address}
            Port 22022
            User {{cookiecutter.project_slug}}
            IdentityFile ../.secrets/admin
            EscapeChar none
        EOT
  filename = "${path.module}/ssh_config.tmp"
}