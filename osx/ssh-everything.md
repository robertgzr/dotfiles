SSH Everything Cheatsheet
=========================

Check for SSH keys
------------------
```
# list all files in ssh dir if there is one
$ ls -al ~/.ssh
```


Generate a new SSH key
----------------------
```
# create new key, uses email as label
$ ssh-keygen -t rsa -b 4096 -C "me@example.com"

# asks some questions
# returns key fingerprint
```


Add key to ssh-agent
--------------------
```
# ssh-agent to background
$ eval "$(ssh-agent -s)"

# returns pid

# add key to agent
$ ssh-add ~/.ssh/id_rsa
```


Test connection
---------------
```
# attempts ssh commecton to github
$ ssh -T git@github.com

# you should see a greeting with your username.
```

 
**Don't forget to change your remote urls**
```
# to check
$ git remote -v

# to change
$ git remote set-url origin git@host:username/repo.git
```


Add key to gh account
---------------------
https://github.com/settings/ssh

Add key to bb account
---------------------
https://bitbucket.org/account/user/robertgzr/ssh-keys/