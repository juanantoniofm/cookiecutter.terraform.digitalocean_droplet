
{% if cookiecutter.enable_database == "yes" %}

output "dbpassword" {
  value     = digitalocean_database_user.{{cookiecutter.project_slug}}user.password
  sensitive = true
}

output "dbhost" {
  description = "Public URI of db instance"
  value       = digitalocean_database_cluster.mysql_{{cookiecutter.project_slug}}.host
}


output "dbport" {
  description = "DB Port"
  value       = digitalocean_database_cluster.mysql_{{cookiecutter.project_slug}}.port
}


output "private_uri" {
  description = "Private URI of the database cluster"
  value       = digitalocean_database_cluster.mysql_{{cookiecutter.project_slug}}.private_uri
}

{% endif %}

output "web_ip" {
  value = digitalocean_floating_ip.external_ip.ip_address
}


output "ssh_{{cookiecutter.project_slug}}_password" {
  description = "SSH Password for the {{cookiecutter.project_slug}} droplet."
  value       = random_password.ssh_{{cookiecutter.project_slug}}_password.result
  sensitive   = true
}
