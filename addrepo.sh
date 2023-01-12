curl -s --compressed "https://lrdsnow.github.io/lrdsnows-repo/key.gpg" | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/lrdsnows-repo.gpg >/dev/null
sudo curl -s --compressed -o /etc/apt/sources.list.d/repo.list "https://lrdsnow.github.io/lrdsnows-repo/repo.list"
sudo apt update
