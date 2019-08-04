# Red          0;31
# Light Red     1;31
# Green        0;32
# Light Green   1;32
# Brown/Orange 0;33
# Yellow        1;33
# Blue         0;34
# Light Blue    1;34
# Purple       0;35
# Light Purple  1;35
# Cyan         0;36
# Light Cyan    1;36
# Light Gray   0;37
# White         1;37

RED='\033[0;31m'
LGREEN='\033[1;32m'
LBLUE='\033[1;34m'
NC='\033[0m' # No Color
BOLD='\033[1m'


echo "\n${LBLUE}${BOLD}*************************************************${NC}\n"
echo "${LBLUE}${BOLD}| Making October CMS better for you development |${NC}\n"
echo "${LBLUE}${BOLD}*************************************************${NC}\n"

# 1. Update .gitignore
echo "\n${LGREEN}Updating .gitignore ...${NC}"
cp -iv ./.gitignore.dev ./.gitignore;

# 2. Update or remove .md files 
echo "\n${LGREEN}Making some cleaning and updating README...${NC}"
rm README.md;
rm LICENSE;
rm CONTRIBUTING.md;
rm ISSUE_TEMPLATE.md;
rm CHANGELOG.md;
cp -fv ./README.md.dev ./README.md;

# 3. Switch to dev dependencies
# Note that this version is modified to work with OC-BOOTSTRAPPER
echo "\n${LGREEN}Updating composer.json to the DEV branch of ${LBLUE}October CMS${NC}"
cp -fv ./composer.json.dev ./composer.json;

# 4. Update october
# Composer command prefixed by land because I use a lando DevStack
echo "\n${LGREEN}Updating October CMS ${LBLUE}to the DEV branch${NC}\n"
lando composer update;

# 5. Remove demo theme & plugin
echo "\n${LGREEN}Removing DEMO theme${NC}"
lando php artisan october:fresh;

# 6. Generate public folder symlinks
# Remove and regenerate the symlinked public directory for whitelist approach to clean out 
# any references that may have been removed and add any new ones that may have been added
echo "\n${LGREEN}Generate public folder ${LBLUE}symlinks${NC}\n"
echo "${LGREEN}Removing the old symlinked public directory...${NC}"
rm -rf public;
echo "${LBLUE}Done ;-)${NC}\n"
echo "\n${LBLUE}Regenerate the symlinked public directory...${NC}"
php artisan october:mirror public --relative;
echo "${LBLUE}Done ;-)${NC}\n"

# 7. Init a new git repo for my development
# Remove the old git repo ant initiate a new one
echo "\n${RED}${BOLD}**********************************************************${NC} \n"
echo "${RED}${BOLD}Do you want to initialize a new GIT REPO${NC} \n"
echo "${RED}${BOLD}BE careful, this can not be undone, do it if you are sure${NC} \n"
echo "${RED}${BOLD}**********************************************************${NC} \n"

read -p "Continue (yes/no)?" CONT
if [ "$CONT" = "yes" ]; then
    echo "\n${RED}${BOLD}Initializing new repo ...${NC}";
    rm -rf .git;
    git init;
else
  echo "${LGREEN}No change made to the repo";
fi