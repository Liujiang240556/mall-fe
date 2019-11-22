#!/bin/sh
GIT_HOME=/usr/local/developer/git-repository/front/
DEST_PATH=/usr/local/developer/git-repository/product/front/

# cd dir
if [ ! -n "$1" ];
then
    echo -e "Please input front project name.You can input as follows:"
    echo -e "./front_deploy.sh mall-fe"
    echo -e "./front_deploy.sh admin-fe"
    exit
fi

if [ $1 = "mall-fe" ];
then
    cd $GIT_HOME$1
    echo '====Enter mall_fe'

elif [ $1 = "admin-fe" ];
then
    cd $GIT_HOME$1
    echo '====Enter mmall_admin_fe'

else
    echo -e "Project Name error.You can input as follows"
    echo -e "./front_deploy.sh mall-fe"
    echo -e "./front_deploy.sh admin-fe"
    exit
fi

# clear dist
rm -rf ./dist

# checkout branch
echo "====checkout master"
git checkout master

echo "====git pull"
git pull

echo "====npm install"
npm install --registry=https://registry.npm.taobao.org
#cnpm install
#yarn install

echo "====npm run dist"
npm run dist

if [ -d "./dist" ];
then
    # clear dest path
    rm -rf $DEST_PATH$1/dist
    echo "====clear dest"

    # copy
    echo "====copy dist"
    cp -R ./dist  $DEST_PATH$1/dist

    # done
    echo "Deploy Success!"
else
    echo "Deploy Error!"
fi
