
{% if cookiecutter.enable_database == "yes" %}

resource "digitalocean_database_cluster" "mysql_{{cookiecutter.project_slug}}" {
  name       = "{{cookiecutter.project_slug}}-mysql-cluster"
  engine     = "mysql"
  version    = "8"
  size       = "db-s-1vcpu-2gb"
  region     = "ams3"
  node_count = 1
  maintenance_window {
    day  = "monday"
    hour = "01:00"
  }
  tags = ["{{cookiecutter.project_slug}}-web"]
}

resource "digitalocean_database_db" "{{cookiecutter.project_slug}}db" {
  cluster_id = digitalocean_database_cluster.mysql_{{cookiecutter.project_slug}}.id
  name       = "{{cookiecutter.project_slug}}db"
}

resource "digitalocean_database_user" "{{cookiecutter.project_slug}}user" {
  cluster_id = digitalocean_database_cluster.mysql_{{cookiecutter.project_slug}}.id
  name       = "{{cookiecutter.project_slug}}user"
}

{% endif %}