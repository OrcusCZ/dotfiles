#!/usr/bin/bash
targets=(
    .bashrc
)

files=(
    .bashrc
)

programs=(
    vim
    tmux
    ranger
)

for p in "${programs[@]}"; do
    echo -n "Checking $p ... "
    if type "$p" &> /dev/null; then
        case "$p" in
            vim)
                echo "found"
                targets+=(.vimrc)
                files+=(.vimrc)
                ;;
            tmux)
                tmuxver=$(tmux -V)
                tmuxver=${tmuxver##* }
                cmpver="2.1"
                maxver=$(echo -e "$tmuxver\n$cmpver" | sort -rV | head -n1)
                echo -n "found version $tmuxver, "
                if [[ "$maxver" == "$tmuxver" ]]; then
                    echo "using new config"
                    targets+=(.tmux.conf)
                else
                    echo "using old config"
                    targets+=(.tmux_pre2.1.conf)
                fi
                files+=(.tmux.conf)
                ;;
            ranger)
                echo "found"
                mkdir -p ~/.config/ranger &> /dev/null
                targets+=(ranger/rc.conf)
                files+=(.config/ranger/rc.conf)
                ;;
        esac
    else
        echo "not found"
    fi
done

for i in "${!files[@]}"; do
    target="${targets[$i]}"
    file="${files[$i]}"
    echo "Creating link $HOME/$file -> ./$target"
    ln -sfr "./$target" "$HOME/$file"
done
