for dir in */ ; do
    if [[ $( basename $dir ) != 'tools' ]]; then
        pushd ${dir}
        git branch --show-current
        popd
    fi
done
