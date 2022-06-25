for dir in */ ; do
    echo $( basename $dir )
    if [[ $( basename $dir ) != 'tools' ]]; then
        pushd ${dir}
        git checkout -- mix.lock
        git pull origin dev
        popd
    fi
done
