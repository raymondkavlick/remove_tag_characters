#!/bin/bash


fixtag()
{
echo "Fixing tag :"
TAG_NAME=$1
echo $TAG_NAME
SPACE="%20"
REPLACEMENT="_"

if echo "$TAG_NAME" | grep -q "$SPACE"; then
    echo "--has space, need to fix"
    echo ${TAG_NAME//$SPACE/$REPLACEMENT}  
    git tag ${TAG_NAME//$SPACE/$REPLACEMENT} $TAG_NAME
    git tag -d $TAG_NAME
    git push origin :refs/tags/$TAG_NAME
    git push --tags
else
    echo "no space, good. move on"
fi

}

git tag -l > taglist.txt

for i in $(cat taglist.txt); do
    fixtag $i
done

rm taglist.txt

