#!/bin/bash

credentials=$(yad --form --title="OpenFortiVPN" --image="/etc/openfortivpn/flogo01.png" --image-on-top\
           --field="Username"\
            --field="Password:H"\
            --field="Token"\
            --width=350  --button="Connect":2 --button="Cancel":1  --buttons-layout=center)




if [[ $? -eq 2 ]];
  then
    user=$(echo $credentials | cut -d '|' -f 1)
    pass=$(echo $credentials | cut -d '|' -f 2)
    otp=$(echo $credentials | cut -d '|' -f 3)

nohup openfortivpn 212.179.203.50:10443 -u $user -p $pass --trusted-cert=here need to place cert hash --otp=$otp &>/dev/null &

elif [[ $? -eq 1 ]];
then
exit 0


fi

yad --title="OpenFortiVPN Client" --form --width=210 --text=Connected\
 --button=Disconnect:3\
--buttons-layout=center


if  [[ $? -eq 3 ]];
then
pid=$(pidof openfortivpn)
kill -9 $pid
fi
