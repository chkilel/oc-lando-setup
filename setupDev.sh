# 1. Update .gitignore
cp ../ocm-lando-setup/.gitignore ./.gitignore;

# 2. Update or remove .md files 
rm README.md;
rm LICENSE;
rm CONTRIBUTING.md;
rm ISSUE_TEMPLATE.md;
rm CHANGELOG.md;
cp ../oc-lando-setup/README.md ./README.md;

# 3. Switch to dev dependencies
# Note that this version is modified to work with OC-BOOTSTRAPPER
cp -f ../oc-lando-setup/dev.composer.json ./composer.json;

# 4. Update october
# Composer command prefixed by land because I use a lando DevStack
lando composer update;

# 5. Remove demo theme & plugin
lando php artisan october:fresh;

# 6. Generate public folder symlinks
# Remove and regenerate the symlinked public directory for whitelist approach to clean out 
# any references that may have been removed and add any new ones that may have been added
rm -rf public;
php artisan october:mirror public --relative;

