# Script to clone specific files for setup of infrastructure Ubuntu Server X86-64 VM
# running a minimal Ubuntu server image

# Create a directory, so Git doesn't get messy, and enter it
mkdir infrastructurevm && cd infrastructurevm

# Start a Git repository
git init

# Squelch annoying message
git config pull.rebase false  # merge (the default strategy)

# Track repository, do not enter subdirectory
git remote add -f origin https://github.com/jhu-information-security-institute/NwSec.git

# Enable the tree check feature
git config core.sparseCheckout true

# Create a file in the path: .git/info/sparse-checkout
# That is inside the hidden .git directory that was created
# by running the command: git init
# And inside it enter the name of the specific files (or subdirectory) you only want to clone
echo 'config/UbuntuServerX86-64/.project' >> .git/info/sparse-checkout
echo 'config/UbuntuServerX86-64/infrastructureREADME.md' >> .git/info/sparse-checkout
echo 'config/UbuntuServerX86-64/infrastructurevm_install.sh' >> .git/info/sparse-checkout
echo 'config/UbuntuServerX86-64/remove.sh' >> .git/info/sparse-checkout
echo 'config/UbuntuServerX86-64/warmstart_netplan.sh' >> .git/info/sparse-checkout
echo 'config/UbuntuServerX86-64/prepshutdown_netplan.sh' >> .git/info/sparse-checkout
echo 'config/UbuntuServerX86-64/etc_netplan_99_config.yaml' >> .git/info/sparse-checkout
echo 'config/UbuntuServerX86-64/etc_netplan_100_config.yaml' >> .git/info/sparse-checkout

## Download with pull, not clone
git pull origin master

echo 'cd into infrastructurevm/config/UbuntuServerX86-64 and view details in infrastructureREADME.md'

# References:
#   https://terminalroot.com/how-to-clone-only-a-subdirectory-with-git-or-svn