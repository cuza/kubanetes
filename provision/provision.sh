#!/bin/bash

sudo sed -i 's/archive.ubuntu.com/repos.uclv.edu.cu/' /etc/apt/sources.list
sudo sed -i 's/security.ubuntu.com/repos.uclv.edu.cu/' /etc/apt/sources.list


# Add authorized_keys 
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAD9QCc5wefRs7+P9I+0dW7DB5kDTFBbqyjMYy0UF8dAYPVfG9Nl/pliPvwg1cv4rivajmonG391J7c0U3tRRmy6iVnpHTDe+SYFGw4xJknJfcCwNyrwaykHn/ZngpNx2gSAY23xFhkaeTyD73vNTh3ZslPnvKYxUMNhvNJaMWgUAqn/jstfSa8bEAKgwsLqlEl4V2Gd2x31bk5vWWkVBOpZm+IG3IPANI2Ch2dhzs8hSge3z8GqaY8arix8gGDc6MmpeO6tYCqdBEdjuV5eJFP9F/sH1atw4GmjOp5ciMmM1LTCoUwiZ8/QVzGG59SJ4GIzn0uROg4jqpsZN2k8BmCWyf3hOEkBkHN4d7D7IEl7egCmMwIrDHwJMWM5DrZ6iqgCXOgY84adRPfTU2xQV9vWa5NSX9hBaK5UeU4BISQpWzJIT7+Ffb79nunGxAWQRIowpK9684xe36GH+n41CAfOlpWDq+ItyZ+kgOWg4cZ8thmUl2WysFmb9n6OUSs178mp4mP+m02weRA5TI1WiuqDbOTusjy7XPEgbh5CV/wdPR0LwXKti2Xe1E8XKFZhPzLzLBGamchPSg4xNUDCvqBaxIQYZz+g1Q5bJbTbwCRHFNHU0mWota9kP9PPcZWIrIzQxCnoV/UDGlam0ot5Oc/aBRuht4W4lsYpkN7l3Pdq7Ql+eGOVsZZpFrj+X7kHcNChlIlnErQOEOv63YH0cljppOMORHJRxotvEEL10fNbdtt2PnRVTzVxTreDFhPhI285q6WDm2GGMjMcMj38f0AYxPeV7126T0joJuq9+rY522//qNK/H4WyRKHfCNbSnQZu6/xaxF908g10cL8phH4eynIlW/Aax1MXiHpbtUhqi+9udPZvc11k/BbPyT23Q/6B2tgUvH9z2lg4DDBUv7kkc58DDkrzRWRSbuDajxp976jRx+pu0Ar+6sig0YeLL09iDIN1mKPRUIjZCFCwifBscxZxRALk2hYvQCuquEjCoWvqMUtMIm4elCf8TFiYPClRv6fm+jPG7dwn+rHXuhrDX1bKiH2656T5IHKxoCsyGfwv4frH9hoBopOOf7MNfImpRXoRCg1xcPyQJwUjlE4sItoYAqaX0Ozs2/bCop6lHXn1FmvqarCg/7tPAaGr/rXr1dUF3uSOMDhPL0Ki3wCHzMvtVZE3bIXsrUiKRyUQoMzQivHjtLMv3EXoSIbPsHLh6DtEwELUObeOKDSrW8iUzRa9VC88CnfjtQ7x+PGqVPPS1mqEqS8FAnhi1nR0mvUCSxBI7LwlIhgLbxoT9tg+3XZ7HoMPPxtmRwRWxxosXqbJ5mHY0PU5hRS6w5B/md4xuTa7+V5 linux8a@gmail.com" >> /home/vagrant/.ssh/authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDIN2IKXszccxg1MiT94ix5PGdbuWkWa78Eh3sNHfNvn6yjsRHOJQtcyD6p2pVkSATPZbK5HwK98+R8ybKQoQMUmOkZSVfSNVbayjIVmG41aq/heIHn+6Ug5DdmTftXJBtEA62yLwTsqvpwQ25daSKTKW84LBRxOK9nrqa+tSJREDvg3MriQjPVBDZkX0y3HHVw3wOzL3xuL9ArJmZShMqDguxQAdTdKtUBAVVr8kZuN1D33ukC6SrDdbA+WT4S3qUrPqrG0pux1TbCF3H+4lys3AckELk4zf2L+BVNzsLMrlaJJ6CrvwEbrFpaMjfJFNi0g7Jo/AGiRN6L53iGVWKeXN3kQ8dd/luVuY5JyTjg5IZjFODZhzd7BQdKQqpoFz2KMVKDnVYqeHaoSK772gHR9iACFcE0eQruQuqd3Rh/ltUyuzXOQg1UwBFerbXTO+VIMBunW1U5cDirk25aEvwN0Ab/TGjjrAqCX+PnZ139TBJ/dpyUbeoah6Vf5Ji5M6iSg7ei651VR12yAU5EYZGK9+Uba79faVB8UK7cv4CMHNGdZpirYn5+oUqISFlYkXHjqfkOWTqWVP9PtQmat62On40tz/aeOt4xgKTvf0mlqOemUx9mYAX/uT9+l8Gup//q5K4d6KCdShDTl13jWt/wmn564bz6W3yxdwOraXTIuQ== argenis8agonzalez@gmail.com">> /home/vagrant/.ssh/authorized_keys

### Check if PROXY_Ip is NULL

if [ ! -n "${PROXY_IP}" ]
then
	echo "Not use proxy"
else
	sudo bash -c cat <<EOF > /etc/apt/apt.conf.d/proxy.conf
        Acquire {
        HTTP::proxy "http://${PROXY_IP}:${PROXY_PORT}";
        HTTPS::proxy "http://${PROXY_IP}:${PROXY_PORT}";
        }
EOF
sudo bash -c cat <<EOF >> /etc/environment
http_proxy="http://${PROXY_IP}:${PROXY_PORT}"
https_proxy="http://${PROXY_IP}:${PROXY_PORT}"
ftp_proxy="http://${PROXY_IP}:${PROXY_PORT}"
EOF
fi

curl -sSLf -x ${PROXY_IP}:${PROXY_PORT} https://nexus.uclv.edu.cu/repository/github.com/cuza/kubanetes/raw/main/get-k0s | sudo python3 -

