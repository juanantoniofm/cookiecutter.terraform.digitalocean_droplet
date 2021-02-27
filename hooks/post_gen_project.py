

"""
Post generation hooks for cookiecutter.

Let's start by running the projects Makefile `make init`.

"""

import sys
import subprocess


def run_command(command):
    """
    Run a command in the cli.

    It semes to be a list of strings with the command and parameters.

    It would be better to have autosplit of the string instead.
    """
    print("Running Commansd post gen project")
    print(command)
    out = subprocess.run(command)
    if out.returncode != 0:
        print(f"Error running command: {command}")
        print("STD OUT")
        print(out.stdout)
        print("STD ERR")
        print(out.stderr)
        print(f"\n\n\n\tPlease, Execute {command} manually or report an issue on github")


def run_make_init():
    """
    Run make init in the project's folder.
    """
    run_command(["cd", "{{cookiecutter.project_slug}}", ";", "make","init"])

db_wish = "{{cookiecutter.enable_database}}"
enable_db = db_wish.lower().startswith("y")

if enable_db:
    ## If the user doesn't want a database, delete the resources
    # TODO: delete the database.tf file after creation.
    pass