
First, let’s view the contents of our global Git configuration file. To do so we pass the --global and the --list options to the git config command.

`$git config --global --list`

For our purposes, we are only interested in the user.name, user.email, and init.defaultBranch variables.

```$git config --global user.name “<name>”```

```$git config --global user.email “<email>”```

repository is represented by a hidden directory called .git that exists within a project directory and it contains all the data on the changes that have been made to the files in a project.

`$git init`

El comando git status nos dice el estado de nuestro directorio de trabajo y nuestra área de preparación y la diferencia entre los dos.

`$git status`


Add filename to the staging area

`$git add <. | filename>`


Create a new commit

`$git commit -m “<message>”`


Show a list of commits in reverse chronological order

`$git log`



###   BRANCHES  

`git config --global init.defaultBranch “<branch_name”>`

Create a branch

`git branch <new_branch_name>`

Switch branches

`git switch <branch_name>`

Create + switch

`git checkout -b <branch_name>`

Integrate changes from one branch into another branch

`git merge <branch>`


### Repositorios Remotos (Github)

Clone a Git remote repository 
`git clone < https | ssh>`


