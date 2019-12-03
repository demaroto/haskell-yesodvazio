ssh root@51.254.116.21 <<EOF
cd projeto &&
stack clean &&
echo "limpeza de arquivos ok!"
EOF