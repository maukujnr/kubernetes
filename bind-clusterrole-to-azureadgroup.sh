#!/bin/bash
IFS='
'
#Improvement: upload to github, make all values in dat folder variables in a release pipeline

#read -p "Enter the Namespace to grant Access to: " namespace
#read -p "Enter the AD Group Name to grant Access to: " groupname
#take in AD-GROUP-NAME and Namespace as inputs
#<<comment
if [ "$#" -ne 3 ]; then
    printf "Illegal number of parameters; Provide cluster role as 1st Argument, ADgroup name as 2nd Argument and namespace as 3rd argument"
	#printf "Illegal number of parameters; Provide AD GroupName"
    exit 1
fi
#comment
#assign variables from inputs provided on script run
role=$1
groupname=$2
namespaces=$3

printf " Input values are:\n AD GroupName: '$groupname'\n Namespace: '$namespaces'\n Cluster Role: '$role'\n\n"

#get AD group ObjectID from provided AD Group Name
adgroupid=`az ad group show --group $groupname --query objectId -o tsv`
printf "\n"
printf ">>AD Group ObjectID is: '$adgroupid' \n"

printf "\n ClusterRole to be bound is : '$role' ...\n"

for namespace in $namespaces
do
printf "\n Namespace the role binding will be configured to is: '$namespace' ...\n"

	sed  "s/VARroleVAR/$role/g; s/VARadgroupnameVAR/$groupname/g; s/VARnamespaceVAR/$namespace/g; s/VARadgroupidVAR/$adgroupid/g" rolebindings/templates/adgroups-clusterviewRB-template.dat > command

filename=${namespace}_${groupname}.yaml
	
printf "\n Applying the RoleBinding definition file '$filename' ....\n\n" 

	kubectl apply -f command #--dry-run=client

	if [ $? -eq 0 ]
	then
		printf "\n '$role' bound successfully to ADGroup '$groupname' for the namespace '$namespace' \n\n"
		
		mv command rolebindings/output/$filename	

	else
		printf "Error binding $role for $groupname" 

	fi
	
    #rm -f command

done
