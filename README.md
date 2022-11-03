# Ansible Playbook to Deploy A Laravel Example App on Ubuntu
link to the laravel app repo: https://github.com/f1amy/laravel-realworld-example-app

## What setup_server.yml does
- Create a specified new user with sudo access and generate ssh keys
- Create an authorized_keys file in the .ssh directory and echo to file a specified public key
- disable remote root login, enable 'no password' for sudo users and disable password authentication
- install ufw and allow 'OpenSSH' and 'WWW Full'

## What deploy_laravel.yml does
- set the timezone on the target machine to a specified timezone
- install requirements for the deployment and add repos to repo lists
- install laravel dependencies
- install and setup composer
- clone the specified (laravel) repo and sets appropriate ownership and permissions
- configure apache for laravel
- deploy a bash script to install and setup postgresql
- seed the application

## What encryptssl.yml does
- install snapd with apt
- install and refresh core with snap
- install and setup certbot tool
- install certificates with the specified email and domain

## Install
### inventory file
the `hosts` file serves as our `inventory file` 
```
instruction: run the setup_server.yml playbook with the ansible_user in inventory file as root, 
and the subsequent playbooks as the specified new user
```

### Environment variables
variables that can be defined in deploy_vars.yml:
```
- http_port - http_conf - http_path - http_owner - domain 
- timezone - repo link - mysql_db - mysql_user - mysql_password
```
variables that can be defined in setup_vars.yml:
```
- new_user - new_user_shell - new_user_group - public_key
```

### Setup
```
ansible-playbook setup_server.yml -i hosts
```
### Deploy
```
ansible-playbook deploy_laravel.yml -i hosts
```

### Encrypt SSL
```
ansible-playbook encryptssl.yml -i hosts
```
