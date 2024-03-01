#!/bin/bash
cd roles/
ansible-galaxy init $1
rm -rf $1/meta $1/tests $1/README.md
