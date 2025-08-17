#!/usr/bin/env fish

# go to flake repo
pushd ~/dotfiles/nixos >/dev/null

# ensure alejandra exists
if not type -q alejandra
    echo "✖ alejandra not found (add it to home.packages or systemPackages)"
    popd >/dev/null
    exit 1
end

# 1) format
echo "▶ Formatting nix files with alejandra..."
if not alejandra .
    echo "✖ Alejandra formatting failed"
    popd >/dev/null
    exit 1
end

# 2) show diff & commit pre-rebuild (only if there are changes)
set dirty_count (git status --porcelain | wc -l)
if test $dirty_count -gt 0
    set ts (date "+%Y-%m-%d %H:%M:%S")
    echo "▶ Git diff (before commit):"
    git --no-pager diff
    git add -A
    git commit -m "nixos (pre-rebuild): $ts"
else
    echo "✔ No changes to commit (pre-rebuild)"
end

# 3) rebuild with clean error output
echo "▶ NixOS Rebuilding..."
if not sudo nixos-rebuild switch --flake /etc/nixos#nixos &>nixos-switch.log
    echo "✖ Rebuild failed. Relevant errors:"
    # show only lines with 'error' (case-insensitive); if none, show last 50 lines
    if not grep -i --color=always error nixos-switch.log
        echo "— no explicit 'error' lines found; last 50 lines —"
        tail -n 50 nixos-switch.log
    end
    popd >/dev/null
    exit 1
end

# 4) commit generation info (only if something actually changed post-rebuild)
set gen (nixos-rebuild list-generations | grep current)
if not git diff --quiet
    git commit -am "$gen"
end

popd >/dev/null
