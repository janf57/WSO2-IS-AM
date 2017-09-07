#!/bin/bash

groupId=$1
artifactId=$2
version=$3
extension=$4
classifier=$5
repositoryId=public

if [ $# -lt 3 ]
  then
    echo "Faltan argumentos de entrada"
else
  wget -O result.xml http://nexus.elcorteingles.int/service/local/artifact/maven/resolve?r=${repositoryId}\&g=${groupId}\&a=${artifactId}\&v=${version}\&e=${extension}\&c=${classifier}
  if [ $? -eq 8 ]
    then
      echo "No existe el artefacto solicitado en Nexus"
  else
    repositoryPath=$(grep repositoryPath result.xml|awk -F">" '{print $2}'|awk -F"<" '{print $1}')
    # echo "repositoryPath: ${repositoryPath}"
    wget http://nexus.elcorteingles.int/content/groups/public/${repositoryPath}
    echo "Se ha descargado el artefacto: ${artifactId}, version ${version}"
  fi
  rm -f result.xml
fi
