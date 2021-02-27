

# A cookiecutter for terraforming a droplet on digital ocean



## Ideas

- Learn to import extra python libraries.
    - store them in a folder in the project structure
    - modify the sys.path to include an environment or something like that
    - and then import from than environment.
    - the environment could be populated via "pip instalL" using a command runner
    - or it could be made of specifc versions of python modules/libraries, unpacked.
    - After that, destroy the folder with a post action.

- Start using the git python module to manipulate therepo itself
    - https://gitpython.readthedocs.io/en/stable/tutorial.html#tutorial-label
    - manipulating the repo can help the tool persist itself cross generations.
    - It will also allow some for of "fingerprint" and even running actions on known repositories
    - it will open the door to import the changes from a knon repo (given the repo URL is given in the project re-cookiecutting.


