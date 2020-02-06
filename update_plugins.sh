#/bin/bash 

# UPDATE VIM'S PLUGINS

cd ~/dotvim/pack/bundle/opt
for d in */ 
do
    ( cd "$d" && git pull )
done

cd ~/dotvim/pack/bundle/start
for d in */ 
do
    ( cd "$d" && git pull )
done

