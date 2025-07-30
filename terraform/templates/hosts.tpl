[Jenkins]
%{ for i, ip in servers ~}
%{ if names[i] == "Jenkins" }
${ip} ansible_host=${ip} ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/${keyfile}.pem
%{ endif ~}
%{ endfor ~}

[K8s]
%{ for i, ip in servers ~}
%{ if names[i] == "K8s" }
${ip} ansible_host=${ip} ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/${keyfile}.pem
%{ endif ~}
%{ endfor ~}

