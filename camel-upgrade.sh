###install camel-k client on the linux pc from where to run the  kamel upgrade commands

#As an Example, I download camek-k client version 1.6.0 below since I am going to update camel to v1.6.0
#1.download the binary from https://camel.apache.org/releases/k-1.6.0/
wget https://archive.apache.org/dist/camel/camel-k/1.6.0/camel-k-client-1.6.0-linux-64bit.tar.gz 

#uncompress the archive. 
tar -zxvf camel-k-client-1.6.0-linux-64bit.tar.gz

#The archive downloaded contains a small binary file named kamel that you should put into your system path. 
#For example, if you’re using Linux -ubuntu/debian, you can put kamel in /usr/bin; 
#Anyhow, to find out where the kamel is on your client PC, run which kamel command
which kamel

#copy the binary files to 
sudo cp kamel* /home/linuxbrew/.linuxbrew/bin/

#confirm version of kamel client
kamel -version

#now you are ready to run the camel upgrade...
#1. install cluster-wide resources in a namespce called 'camel' or whichever namespace you choose to use for camel
kamel install --cluster-setup -n camel

#2. run upgrade #Ensure you point to your respective container registry; In my case i'm using Azure Container Registry
kamel install -n camel --force   --registry maukutech.azurecr.io --registry-auth-username maukutech --registry-auth-password X=0gHfCT2qt78ROhHVAT16u0+qCTHg!D
