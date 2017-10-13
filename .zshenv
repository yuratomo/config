for DIR in ${HOME}/Library/Python/2.7/bin ${HOME}/.local/bin ; do
        if [ -d ${DIR} ] ; then
                PATH=${PATH}:${DIR}
        fi
done
