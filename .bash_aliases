### GIT ###
alias gf='git fetch'
alias gd='git diff'
alias gc='git commit'
# Git Show Branch: wyświetla nazwę aktualnego branch'a
alias gsb='git branch | grep -oP "(?<=^\* )[^\(].*$" || gslh'
# Git Commit: skrót do commit'owania, z odpowiednim szablonem komentarza
#alias gc='git commit -m "[$GIT_USERNAME] #$(gsb): w trakcie pracy" -e'
# Git Status
alias gs='git status'
# Git Reset
alias gr='git reset --hard'
# Git Checkout Origin/Master -F
alias gcomf='git checkout origin/master -f; git status'
# Git Fetch & Status
alias gfs='git fetch && git status'
# Git Graph: wyświetla sformatowaną historię branch'a w postaci drzewa commit'ów
#alias gg="git log --oneline --graph --decorate=short" #domeny
alias gg="git log --pretty=format:'%C(auto)%h %d %Cblue%an %cd%Creset %s' --graph --date='format:%Y-%m-%d %H:%M:%S'"
alias ggc="git log --pretty=format:'%C(auto)%h %d %Cblue%cn %cd%Creset %s' --graph --date='format:%Y-%m-%d %H:%M:%S'"
# Git Graph Branches: wyświetla branche i ich zalezności
alias ggb="git log --graph --oneline --decorate=short --simplify-by-decoration --all"
# Git Show Last Hash: wyświetla hash ostatniego commit'a
alias gslh='git log -n1 | grep -oP "(?<=commit )[a-f\d]+"'
# Git Show Conflicts: wyświetla listę plików z konfliktami
alias gsc='git status -s | grep -oP "(?<=[AUD]{2} ).*"'
# Git Show SQuash Hash: wyświetla hash commita, z którego był robiony git merge --squash
alias gssqh='grep -oP "(?<=commit )[a-f\d]{40}" .git/SQUASH_MSG'
# Git Remote Prune Origin: usuwa (lokalne) zdalne branche ktore już nie istnieją
alias grpo='git remote prune origin'

