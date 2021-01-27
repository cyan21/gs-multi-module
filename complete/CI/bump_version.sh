#/!bin/bash

cur_vers=1.1.0
new_vers=1.3.0
new_msg="it's a raining day ..."

# '' is for mac OS ...
sed -i '' "s/<version>${cur_vers}<\/version>/<version>${new_vers}<\/version>/" "../application/pom.xml"
sed -i '' "s/<version>${cur_vers}<\/version>/<version>${new_vers}<\/version>/" "../pom.xml"
sed -i '' "s/<version>${cur_vers}<\/version>/<version>${new_vers}<\/version>/" "../library/pom.xml"

echo "service.message=$new_msg" > ../application/src/main/resources/application.properties