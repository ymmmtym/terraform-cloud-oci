#!/usr/bin/env python
# -*- coding: utf_8 -*-

"""Dynamic Inventory from terraform.tfstate for GCP."""

import json


TERRAFORM_TFSTATE_PATH = './terraform.tfstate'
INVENTORY = {'all': {'hosts': []}, '_meta': {'hostvars': {}}}
TFSTATE = json.load(open(TERRAFORM_TFSTATE_PATH, 'r'))
RESOURCES = TFSTATE['resources']

for resource in RESOURCES:
    if resource['type'] == 'oci_core_instance':
        host = resource['name']
        INVENTORY['all']['hosts'].append(host)
        INVENTORY['_meta']['hostvars'][host] = resource['instances'][0]
        INVENTORY['_meta']['hostvars'][host]['ansible_host'] \
            = resource['instances'][0]['attributes']['public_ip']


print(json.dumps(INVENTORY, indent=4))
