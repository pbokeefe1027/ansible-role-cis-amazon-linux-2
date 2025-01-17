#!/bin/bash

cat /etc/passwd | awk -F: '{ print $1 " " $3 " " $6 }' | while read user uid dir; do
  if [ $uid -ge 500 -a -d "$dir" -a $user != "nfsnobody" -a $user != "sssd" -a $user != "polkitd" -a $user != "systemd-coredump" -a $user != "nobody" ]; then
  owner=$(stat -L -c "%U" "$dir")
    if [ "$owner" != "$user" ]; then
      echo "$dir:$user:$owner"
    fi
  fi
done
