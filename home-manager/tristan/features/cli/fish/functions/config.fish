if test -z $argv
    echo "config requires an argument."
    echo "Usage: config (switch|build|test)"
    echo "See nixos-rebuild(8)"
    return 1
end

set -l PREFIX ""
set ARG $argv[1]

if test $ARG = "switch"
    or test $ARG = "test"
    set PREFIX "sudo"
else if test $ARG != "build"
    echo "Unknown argument $ARG"
    echo "Usage: config (switch|build|test)"
    echo "See nixos-rebuild(8)"
    return 1
end

# TODO refacto with nixpath and host from config
set CMD $PREFIX nixos-rebuild $ARG --flake '~/.config/nixpkgs/#'
echo $CMD
eval $CMD
