function sshs {
    ssh $@ "cat > /tmp/.bashrc_temp" < ~/.bashrc
    ssh $@ "cat > /tmp/.bash_aliases" < ~/.bash_aliases
    ssh $@ "cat > /tmp/.bash_function" < ~/.bash_function
    ssh -t $@ "bash --rcfile /tmp/.bashrc_temp; rm /tmp/.bashrc_temp; rm /tmp/.bash_aliases; rm /tmp/.bash_function"
}

# Git Code Review: tworzy tymczasowego branch'a (detached) z naniesionymi zmianami na master'a (rozpoczęcie CR)
function gcr {
    dest_branch='origin/master';
    if [[ $# -eq 0 ]]; then
        echo -e "\e[0;33mNie podano dolecowego branch'a - domyślnie zakładam $dest_branch\e[0m";
    else
        dest_branch=$*
    fi
    cur_commit=$(gslh) && git fetch && git checkout $dest_branch && git merge --squash $cur_commit && git status
}

# Git Code Review Close: zapisuje wszystkie zmiany (index + worktree + untracked) do commit'a i nanosi go do podanego branch'a (koniec CR)
function gcrc {
    if [[ $# -ne 1 ]]; then
        echo -e "\e[0;31mNie podano docleowego branch'a\e[0m"; return;
    fi
    git checkout --detach && git add -A && git commit --allow-empty -m gcrc1 || return -1 ; gcrc1=$(gslh)
    git merge --squash -X ours $1 && git commit -m gcrc2 && gcrc2=$(gslh) || unset gcrc2
    echo "git checkout $1 && git cherry-pick -n --strategy recursive -X theirs $gcrc1"
    git checkout $1 && git cherry-pick -n --strategy recursive -X theirs $gcrc1 && {
        [[ -n $gcrc2 ]] && {
            git show $gcrc2 | git apply --index -R ;
        } ; echo -e '\e[0;32mGotowe\e[0m' ; echo ; git status
    } || {
        git add -A && git reset --hard && git checkout $gcrc1 && git reset --soft HEAD^ && echo -e "\e[0;31mWystapily bledy ($?)\e[0m" && return -1 ;
    }
}

