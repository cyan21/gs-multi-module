# PRE REQUISITES

JFrog platform enabling Artifactory, Xray, Pipelines

| Service | Type | Name | Description | 
| ----------- | ----------- |----------- | ----------- |
| Artifactory | Maven virtual repo | ninja-dev-mvn | aggregate maven dev local and remote | 
| Artifactory | Maven local repo   | ninja-dev-mvn-local | | 
| Artifactory | Maven local repo   | ninja-rc-mvn-local | for mvn promotion | 
| Artifactory | Maven remote repo  | ninja-jcenter-remote | | 
| Artifactory | Docker virtual repo | ninja-dev-docker | aggregate docker dev local and remote | 
| Artifactory | Docker local repo   | ninja-dev-docker-local | | 
| Artifactory | Docker local repo   | ninja-rc-docker-local | for mvn promotion | 
| Artifactory | Docker remote repo  | ninja-dockerhub-remote | | 
| Pipelines   | Github Integration | yann_github | pointing to https://github.com/cyan21 |
| Pipelines   | Artifactory Integration | artifactory_eu | |

## Repository creation

````
curl -uadmin:chaysinh -X PATCH "http://localhost:8081/artifactory/api/system/configuration" -H "Content-Type: application/yaml" -T repo.yml
````

if you change the repo names, make sure to edit : 
* the mvn-art-config
* repo name in the pipelines.steps.yaml (pipeline variables)


## Integration creation

integrations have to be created manually for now JFrog pipelines




