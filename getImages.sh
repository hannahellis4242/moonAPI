#! /bin/bash

mkdir img
#http://www.farmsense.net/demos/images/moonphases/30.png

for i in $(seq 0 30)
do
    echo $i
    curl http://www.farmsense.net/demos/images/moonphases/$i.png > img/moon_$i.png
done