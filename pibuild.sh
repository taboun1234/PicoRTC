#!/bin/bash

export TERMINAL=konsole

upload()
{
 cp ./build/*.uf2 /media/$USER/RPI-RP2/
 echo "upload -------------- ok"
}

building()
{
cmake -B build -S .
echo "pre build ------------ OK"
make -C build
echo "compilation terminée sans erreurs"
}

remove()
{
echo "removing build dir "
rm -r ./build
echo "build removed"
}


godir()
{
    while [  ! -f ./CMakeLists.txt   -a  ! -d ./home    ]
    do
    cd ../
    done
    if [ ! -f ./CMakeLists.txt ]; then
        echo "impossible de trouver le fichier CMakeLists.txt "
        exit
    fi
}
helpPage()
{
echo "utilitaire pour raspbery pi pico:"
echo "-b ou -build"
echo "                  compile le code"
echo "-r ou -rebuild"
echo "                  recompile tout le code"
echo "-m ou -monitor"
echo "                  ouvre une console (konsole) pour un moniteur de serie"
echo "-u ou -upload"
echo "                  copie le dernier code compilee dans le raspbery pi pico"
echo ""
echo "si voun n'etes pas dans le repertoir de travaille, indiquez le en second argument"

}
CrateSdk()
{
echo "instalation de pico-sdk"
git clone 'https://github.com/raspberrypi/pico-sdk' $HOME/pico-sdk
export Emplacement=${PWD}
cd $HOME/pico-sdk
git submodule update --init
cd $Emplacement
echo "instalation terminee"
}

set -e
export PICO_SDK_PATH=$HOME/pico-sdk
#export PICO_CXX_ENABLE_EXCEPTIONS=1

if [ ! -d $HOME/pico-sdk ]; then
        CrateSdk

fi

if [ $# = 2 ]; then
        cd $2
fi

echo "on travaille dans ${PWD}"

case $1 in
        "-m"|"monitor")
                minicom -b 115200 -o -D /dev/ttyACM0
                ;;
        "-b"|"-build")
                godir
                building
                ;;
        "-r"|"rebuild")
                godir
                if [  -d ./build ]; then
                    remove
                fi
                building
                ;;
        "-u"|"upload")
                godir
                upload
                ;;
        "-h"|"-help")
                helpPage
                ;;
        *)
            echo "parametre non valide "
            echo "-h ou -help pour ouvrir une page d'aide"
        ;;
esac


