#!/usr/bin/env python
# -*- coding: utf_8 -*-

"""Dynamic Inventory from terraform.output for OCI."""

import json


TERRAFORM_TFOUTPUT_PATH = './terraform/terraform.tfoutput'
INVENTORY = {'all': {'hosts': []}, '_meta': {'hostvars': {}}}
TFOUTPUT = json.load(open(TERRAFORM_TFOUTPUT_PATH, 'r'))

for key,value in TFOUTPUT.items():
        host = key
        INVENTORY['all']['hosts'].append(host)
        INVENTORY['_meta']['hostvars'][host] = {}
        INVENTORY['_meta']['hostvars'][host]['ansible_host'] \
            = value['value'][0]


print(json.dumps(INVENTORY, indent=4))
