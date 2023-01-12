# Packages & Packages.gz
dpkg-scanpackages --multiversion . > Packages
gzip -k -f Packages

# Release, Release.gpg & InRelease
apt-ftparchive release . > Release
gpg --default-key "Lrdsnow101@gmail.com" -abs -o - Release > Release.gpg
gpg --default-key "Lrdsnow101@gmail.com" --clearsign -o - Release > InRelease
