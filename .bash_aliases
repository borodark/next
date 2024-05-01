export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

function gitconfigio()
{
    git config user.email igor@octanix.com
    git config user.name "Igor Ostaptchenko"
}
function gitconfigbor()
{
    git config user.email borodark@gmail.com
    git config user.name "Egor O'Sten"
}

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '


alias ll='ls -l'
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"

alias gd='git diff'
alias gs='git status'
alias gp='git push'
alias gpu='git push upstream'
alias gr='git remote -v'
alias gl='git log --branches --remotes --tags --graph --oneline --decorate'
alias gc='git commit -am'
alias gf='git fetch'

alias find='find .'
alias la='ls -la'
alias lA='ls -lA'
alias psj='ps -ef | grep java'
alias myips='ifconfig | grep inet'

alias add-req='echo $1 >> req.txt'

alias ducks="du -cks * | sort -rn | head | awk '{printf \"%.2f M ---> %s\n\",\$1/1024, \$2}'"

alias cda='cd ~/projects/next/'
alias cdt='cd ~/projects/next/tools/local-dev-docker-compose'


alias mdgc='mix do deps.get, deps.compile'
alias mcc='mix do clean, compile'
alias mt='mix test'
alias mti='MIX_ENV=io mix test'
alias mtint='MIX_ENV=int_test mix test'
alias mf='mix format'

export U_ID=$UID

alias dcu='U_ID=$UID docker-compose up --remove-orphans'
alias dcd='U_ID=$UID docker-compose down --remove-orphans'
alias dps="docker ps --format '{{.Names}} <---> {{.Command}}'"
alias dpsa='dps -a'

function de() { docker exec -it "$@" sh ;}
alias db='docker build'
alias da='docker attach'
alias dcud='docker-compose up -d'

alias grex='grep -r --include "*.ex"'
alias grexs='grep -r --include "*.exs"'
alias greyml='grep -r --include "*.yml"'
alias greyaml='grep -r --include "*.yaml"'
alias grej='grep -r --include "*.java"'
alias grepts='grep -r --include "*.ts"'
function ke-ccom-cubes() { kubectl exec --stdin --tty "$@
"  -n ccom-cubes -- /bin/bash ;}
function klog-cube() { kubectl logs -f -c cube "$@" -n ccom-cubes ;}
function klog-store() { kubectl logs -f -c cubestore "$@" -n ccom-cubes ;}
alias pipuninstallall="pip uninstall -y -r <(pip freeze | tee pip.frozen.uninstalled)"
alias codepolice='pre-commit run --all-files && hs-pylint-runner'
#
# bucket nuker copywrites here: https://github.com/aws/aws-cli/issues/3163#issuecomment-1906759163
#
function s3_batch_delete(){
    # This function deletes files from an S3 bucket based on a specified prefix.
    # Arguments:
    #   $1: The bucket name from which files will be deleted.
    #   $2: The prefix for the files to be deleted. The prefix should not start with a '/'.
    #   $3: The AWS profile to use for authentication. The profile is stored in the ~/.aws/credentials file.

    # List the keys we want to delete and save them in the keysToDelete.txt file.
    hsaws s3api list-objects-v2 --output text --bucket "${1}" --prefix "${2}" --query 'Contents[].[Key]' --profile "${3}" > keysToDelete-from-"${1}".txt

    # Delete the keys in keysToDelete.txt in batches of 1000.
    # We use -P$(nproc) to run multiple batches in parallel over all the available logical cores.
    # To handle longer paths, we adjust the --max-chars setting of xargs to 90% of the maximum argument size allowed by the platform.
    max_arg=$(echo $(getconf ARG_MAX)*0.90/1 | bc)
    cat keysToDelete-from-"${1}".txt | xargs -P$(nproc) -n1000 --max-chars="$max_arg" bash -c 'hsaws s3api delete-objects --bucket '"${1}"' --profile '"${3}"' --delete "Objects=[$(printf "{Key=%q}," "$@")]" >> deletedKeysAndVersionOfDeleteMarker-'"${1}"'.txt' _ 
    cat deletedKeysAndVersionOfDeleteMarker-"${1}".txt
    # Remove the file with keys after the files have been wiped from S3.
    rm keysToDelete-from-"${1}".txt
} 

. /usr/local/opt/asdf/libexec/asdf.sh