#/!bin/bash

cur_vers=1.0.0
new_vers=1.1.0
new_msg="I am watching a cooking show on TV"

# '' is for mac OS ...
sed -i '' "s/<version>${cur_vers}<\/version>/<version>${new_vers}<\/version>/" "../application/pom.xml"
sed -i '' "s/<version>${cur_vers}<\/version>/<version>${new_vers}<\/version>/" "../pom.xml"
sed -i '' "s/<version>${cur_vers}<\/version>/<version>${new_vers}<\/version>/" "../library/pom.xml"
sed -i '' "s/myDemoVersion: ${cur_vers}/myDemoVersion: ${new_vers}/" "jfrog/pipelines.steps.mvn.yaml"

echo "service.message=$new_msg" > ../application/src/main/resources/application.properties