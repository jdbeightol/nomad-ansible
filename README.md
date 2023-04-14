# nomad-ansible

## dependencies
Install ansible with ansible-playbook support.  This repository has been tested
to operate successfully with ansible versions up to `core 2.14.4`.

## usage

1. [Create an
ansible invientory file](https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html)
2. [Create ansible
   variables](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_variables.html)
   with configuration related to hosts and groups defined in the inventory
   file
3. Run `ansible-playbook`
```
ansible-playbook -i <inventory> example-playbook.yml
```

## tips
The `--check` (`-C`) and `--diff` (`-D`) flags can be used in combination for
debugging and validation before making changes on a system.  Note, that these
flags can sometimes cause false failures in cases whenever the success of a
later action depends on the outcome of a previous one (e.g., directory 
creation).
