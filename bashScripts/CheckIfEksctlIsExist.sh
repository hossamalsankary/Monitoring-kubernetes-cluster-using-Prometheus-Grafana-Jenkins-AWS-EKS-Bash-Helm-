#!/bin/bash
function watchPods(){
echo 'inidata' >  data
echo 'inidata' > blue

( eksctl --help  ) 1> data  2>err

}

watchPods

if [[ $( cat data ) == *create*  ]]
then

echo "eksctl version : $(eksctl version)"

else

echo "install eksctl"
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
 sudo mv /tmp/eksctl /usr/local/bin
eksctl version
fi
 