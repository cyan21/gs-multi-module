#!/bin/bash


# requires : XRAY POLICY (see policy name in watch.json)

usage() {
    echo "$0 -u <JPD_URL> -l <ADMIN_USER> -p <ADMIN_PASS> -e <EDGE_URL> -i <ART_ID> -v <VIRTUAL_REPO>"
}

JPD_URL="http://artifactory-eu-yannc4-0.soleng-emea-staging.jfrog.team"
EDGE1_URL="http://edge-us-yannc4-0.soleng-emea-staging.jfrog.team"
EDGE2_URL="http://edge-apac-yannc4-0.soleng-emea-staging.jfrog.team"

ADMIN_USER="admin"
BUILD_NAMES="backapp_mvn,backapp_mvn_docker"  #list with comma as a separator

while getopts "u:l:e:p:i:v:" option; do
    case "${option}" in
        u) JPD_URL=${OPTARG} ;;
        l) ADMIN_USER=${OPTARG} ;;
        p) ADMIN_PASS=${OPTARG} ;;
        e) EDGE1_URL=${OPTARG} ;;
        i) ART_ID=${OPTARG} ;;
        v) VIRTUAL_REPO=${OPTARG} ;;
        *) usage && exit 1;;
    esac
done

if [ -z "$ADMIN_PASS" ]; then
    echo "[ERROR] missing ADMIN PASSWORD"
    exit 1
fi
creds="-u$ADMIN_USER:$ADMIN_PASS"

# create repo
echo "[ARTIFACTORY] creating repositories on Artifactory..."
curl -XPATCH $creds \
    -H "Content-Type: application/yaml" -T repo.yaml \
    $JPD_URL/artifactory/api/system/configuration 

echo "[ARTIFACTORY-EDGE-1] creating repositories on Edge ..."
curl -XPATCH $creds \
    -H "Content-Type: application/yaml" -T repo_edge.yaml \
    $EDGE1_URL/artifactory/api/system/configuration 

# echo "[ARTIFACTORY-EDGE-2] creating repositories on Edge ..."
# curl -XPATCH $creds \
#     -H "Content-Type: application/yaml" -T repo_edge.yaml \
#     $EDGE2_URL/artifactory/api/system/configuration 

# index build
echo -e "\n[XRAY] indexing builds ... "
curl -XPOST $creds \
    -H "Content-Type: application/json" -d "{\"names\":[\"`echo $BUILD_NAMES | sed 's/,/","/g'`\"]}" \
    $JPD_URL/xray/api/v1/binMgr/builds

# create watch
echo -e "\n[XRAY] creating watch ... !"
curl -XPOST $creds \
    -H "Content-Type: application/json" -d @watch.json \
    $JPD_URL/xray/api/v2/watches

# generate mvn config for JFrog CLI
sed -i "s/ART_ID/$ART_ID/g" ../mvn-art-config
sed -i "s/VIRTUAL_REPO/$VIRTUAL_REPO/g" ../mvn-art-config

cat ../mvn-art-config


