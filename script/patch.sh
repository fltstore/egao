git clone --depth=1 git@github.com:fltstore/egao_database.git

# copy with local
# cp -rf ../../egao_database/* ../assets/database

cp -rf egao_database ../assets/database
cd ../assets/database
rm -rf .git
rm -rf generate.mjs