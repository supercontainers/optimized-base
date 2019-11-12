#!/bin/bash

source /.bashrc-addon

echo 
echo "###############################################################################"
echo "Current Size $(du -sh /opt/spack/opt/spack)"
du -sh /opt/spack/opt/spack

# Delete static libraries
echo "Removing static libraries..."
find /opt/spack/opt/spack/*/*/ -type f -name \*.a | xargs rm -f

# Does not work atm, need a more fine-grained way or this should be dropped entirely
#echo "Removing /.spack..."
#find /opt/spack/opt/spack/*/*/ -name .spack -type d | xargs rm -rfo "Removing /share..."

echo "Removing man pages"
find /opt/spack/opt/spack/*/*/ -name '*man' -type d | grep /share/ | xargs rm -rf

echo "Removing doc directories"
find /opt/spack/opt/spack/*/*/ -name '*doc' -type d | grep /share/ | xargs rm -rf

# static lib: application/x-archive; charset=binary
# shared lib: application/x-sharedlib; charset=binary
# symlink     inode/symlink; charset=binary
# script      text/x-shellscript; charset=us-ascii
# binary      application/x-executable; charset=binary

# Identify (using file utility) then strip every binary file that is either an
# executable, static library, or static binary
echo "Striping binaries..."
find /opt/spack/opt/spack/*/*/ -type f -exec file -i '{}' \; | \
        grep 'charset=binary' | \
        grep 'x-executable\|x-archive\|x-sharedlib' | \
        awk -F: '{print $1}' | xargs strip

echo "New Size   $(du -sh /opt/spack/opt/spack)"
echo "###############################################################################"
echo
