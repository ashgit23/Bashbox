# Ansible Arrays & Dictionaries Demo

This project demonstrates how to use different variable structures in Ansible:

- **Array (list)** → `server_names`
- **Dictionary (map)** → `db_config`
- **Array of dictionaries** → `servers`
- **Dictionary of arrays** → `packages`

## Files
- `playbook.yml` → Playbook with tasks showing each structure.
- `vars/main.yml` → Variable definitions.

## Run
```bash
ansible-playbook playbook.yml
