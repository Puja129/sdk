#!/bin/bash

function login(){
    cf login -a ${CF_API} -u ${CF_USR} -p ${CF_PWD} -o ${ORG} -s ${SPACE}
}

function getEnvs(){
    {
      rm values.txt
      echo "removed existing values.txt. continue updating ${ZONE}"
    } || {
      echo "no values.txt found. continue updating ${ZONE}"
    }
    
    echo "***** begin of cf env vars for ${ZONE}"
    #cf env ${ZONE}
    cf env ${ZONE} | tee values.txt
    echo "***** end of cf env vars for ${ZONE}"    
}

function setEnvs(){    
    eval "sed -i -e 's|{{ZONE}}|$(cat values.txt | grep ZONE | cut -d ' ' -f2)|g' ./push/manifest.yml"
    eval "sed -i -e 's|{{ADMIN_PWD}}|$(cat values.txt | grep ADMIN_PWD | cut -d ' ' -f2)|g' ./push/manifest.yml"
    eval "sed -i -e 's|{{ADMIN_TKN}}|$(cat values.txt | grep ADMIN_TKN | cut -d ' ' -f2)|g' ./push/manifest.yml"
    eval "sed -i -e 's|{{ADMIN_USR}}|$(cat values.txt | grep ADMIN_USR | cut -d ' ' -f2)|g' ./push/manifest.yml"
    eval "sed -i -e 's|{{BASE}}|$(cat values.txt | grep BASE | cut -d ' ' -f2)|g' ./push/manifest.yml"
    eval "sed -i -e 's|{{CF_API}}|$(cat values.txt | grep CF_API | cut -d ' ' -f2)|g' ./push/manifest.yml"
    eval "sed -i -e 's|{{CF_LOGIN}}|$(cat values.txt | grep CF_LOGIN | cut -d ' ' -f2)|g' ./push/manifest.yml"
    eval "sed -i -e 's|{{CF_PWD}}|$(cat values.txt | grep CF_PWD | cut -d ' ' -f2)|g' ./push/manifest.yml"
    eval "sed -i -e 's|{{CF_USR}}|$(cat values.txt | grep CF_USR | cut -d ' ' -f2)|g' ./push/manifest.yml"
    eval "sed -i -e 's|{{EC_PRVT_PWD}}|$(cat values.txt | grep EC_PRVT_PWD | cut -d ' ' -f2)|g' ./push/manifest.yml"
    eval "sed -i -e 's|{{EC_SETTINGS}}|$(cat values.txt | grep EC_SETTINGS | cut -d ' ' -f2)|g' ./push/manifest.yml"
    eval "sed -i -e 's|{{ENV}}|$(cat values.txt | grep ENV | cut -d ' ' -f2)|g' ./push/manifest.yml"
    eval "sed -i -e 's|{{NR_KEY}}|$(cat values.txt | grep NR_KEY | cut -d ' ' -f2)|g' ./push/manifest.yml"
    eval "sed -i -e 's|{{NUREGO_API_KEY}}|$(cat values.txt | grep NUREGO_API_KEY | cut -d ' ' -f2)|g' ./push/manifest.yml"
    eval "sed -i -e 's|{{NUREGO_ENDPOINT}}|$(cat values.txt | grep NUREGO_ENDPOINT | cut -d ' ' -f2)|g' ./push/manifest.yml"
    eval "sed -i -e 's|{{NUREGO_FEATURE_ID}}|$(cat values.txt | grep NUREGO_FEATURE_ID | cut -d ' ' -f2)|g' ./push/manifest.yml"
    eval "sed -i -e 's|{{NUREGO_TKN_INS}}|$(cat values.txt | grep NUREGO_TKN_INS | cut -d ' ' -f2)|g' ./push/manifest.yml"
    eval "sed -i -e 's|{{NUREGO_TKN_PWD}}|$(cat values.txt | grep NUREGO_TKN_PWD | cut -d ' ' -f2)|g' ./push/manifest.yml"
    eval "sed -i -e 's|{{NUREGO_TKN_URL}}|$(cat values.txt | grep NUREGO_TKN_URL | cut -d ' ' -f2)|g' ./push/manifest.yml"
    eval "sed -i -e 's|{{NUREGO_TKN_USR}}|$(cat values.txt | grep NUREGO_TKN_USR | cut -d ' ' -f2)|g' ./push/manifest.yml"
    eval "sed -i -e 's|{{NUREGO_USAGE_FEATURE_ID}}|$(cat values.txt | grep NUREGO_USAGE_FEATURE_ID | cut -d ' ' -f2)|g' ./push/manifest.yml"
    eval "sed -i -e 's|{{PLAN_ID}}|$(cat values.txt | grep PLAN_ID | cut -d ' ' -f2)|g' ./push/manifest.yml"
    eval "sed -i -e 's|{{PLAN_NAME}}|$(cat values.txt | grep PLAN_NAME | cut -d ' ' -f2)|g' ./push/manifest.yml"
    eval "sed -i -e 's|{{ZAC_CLIENT_ID}}|$(cat values.txt | grep ZAC_CLIENT_ID | cut -d ' ' -f2)|g' ./push/manifest.yml"
    eval "sed -i -e 's|{{ZAC_CLIENT_SECRET}}|$(cat values.txt | grep ZAC_CLIENT_SECRET | cut -d ' ' -f2)|g' ./push/manifest.yml"
    eval "sed -i -e 's|{{ZAC_SERVICE_ID}}|$(cat values.txt | grep ZAC_SERVICE_ID | cut -d ' ' -f2)|g' ./push/manifest.yml"
    eval "sed -i -e 's|{{ZAC_UAA}}|$(cat values.txt | grep ZAC_UAA | cut -d ' ' -f2)|g' ./push/manifest.yml"
    eval "sed -i -e 's|{{ZAC_URL}}|$(cat values.txt | grep ZAC_URL | cut -d ' ' -f2)|g' ./push/manifest.yml"
    eval "sed -i -e 's|{{DOCKER_USERNAME}}|$DOCKER_USERNAME|g' ./push/manifest.yml"
    eval "sed -i -e 's|{{GITHUB_TOKEN}}|$GITHUB_TOKEN|g' ./push/manifest.yml"    
    
    eval "sed -i -e 's|{{MISSION}}|$MISSION|g' ./push/manifest.yml"    
    #eval "sed -i -e 's|{{DOCKER_PASSWORD}}|$CF_DOCKER_PASSWORD|g' ./push/manifest.yml"
    #if [[ ! -z "$(cat values.txt | grep EC_PRVT_ADM | cut -d ' ' -f2)" ]]; then
    #    eval "sed -i -e 's|{{EC_PRVT_ADM}}|$(cat values.txt | grep EC_PRVT_ADM | cut -d ' ' -f2)|g' ./push/manifest.yml"
    #else
    #    eval "sed -i -e 's|{{EC_PRVT_ADM}}|${EC_PRVT_ADM}|g' ./push/manifest.yml"
    #fi
    eval "sed -i -e 's|{{IMAGE_TAG}}|$IMAGE_TAG|g' ./push/manifest.yml"
}