#!/bin/bash
cp /etc/letsencrypt/live/prometheus.techenergoanalit.ru/fullchain.pem /etc/prometheus/keys/fullchain.pem
cp /etc/letsencrypt/live/prometheus.techenergoanalit.ru/privkey.pem /etc/prometheus/keys/privkey.pem
chmod o+r /etc/prometheus/keys/fullchain.pem
chmod o+r /etc/prometheus/keys/privkey.pem
