# devops-ovpn
There is my sample mini devops openvpn server project. It contains ansible and terraform code.

The project comes from two main parts.

The first part is terrafrom code. I run it like this one:
```
$ terraform apply -auto-approve -var-file="secret.tfvars"
```

The second part is ansible only. I need it to gen an ovpn clt cert.
