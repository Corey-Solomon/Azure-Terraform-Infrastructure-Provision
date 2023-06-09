<h1>Azure-Terraform-Infrastructure-Provision</h1>

 

<h2>Description</h2>


This project aims to deploy an Azure infrastructure using Terraform, a powerful infrastructure-as-code tool. I will carefully plan the infrastructure requirements, including virtual machines, storage accounts, networking components, and more. Using Terraform's declarative configuration language, I will define the desired state of my Azure resources. Then I'll configure the Azure provider within Terraform, providing the necessary authentication details. After initializing the environment, I'll deploy the infrastructure using the terraform apply command, which will provision the resources and manage their dependencies. Throughout the process, Terraform will maintain a state file to track the infrastructure's current state. I'll conduct thorough testing and validation to ensure the infrastructure's functionality and performance. Additionally, I'll leverage Terraform's capabilities for continuous deployment, updates, and monitoring, enabling the ability to make changes to my infrastructure configuration while maintaining consistency and reliability. This project will provide an efficient and scalable approach to provisioning and managing an Azure infrastructure.
<br />


<h2>Languages and Utilities Used</h2>
 
- <b>Terraform</b>
- <b>Bash</b>

<h2>Environments Used </h2>

- <b>Azure</b> 
- <b>Vscode</b>




<h2>Infrastructure Procedure</h2>
 
- Resource group 
- Virtual Network 
- Subnet 
- Security group 
- Security rule (for security group)
- Azure Public IP 
- NIC 
- Virtual Machine 
- SSH key pair
 
 
 
 
<h2>Program walk-through:</h2>

** (This walk-through I created starts at the point where VScode and the Terraform extensions have already been installed)
 
 1. Open the Terminal in VScode. Run "az login" and follow prompts to get signed in. You can validate you successfully logged in by running "az account show"
 2. Create a new folder where you will begin to work from in this project. Ex. "Terraform-Azure"

 3. Create a "main.tf" file
 
 
 ### 4. Azure Provider: <br/>
![Alt Text](images/example1.png) <br/>
Inserted in the Azure provider. What the Azure provider does is allows Terraform to communicate with the Azure API. That's how Terraform knows how to deploy resources. I am administrating this procedure using the Azure CLI.


### 5. Terraform init: <br/>
![Alt Text](images/example2.png) <br/>
Ran the "terraform init" command to initialize the backend. The backend is a local backend which means that my terraform state where everything is stored will be stored here.



### 6. Deploying a resource group: <br/>
![Alt Text](images/example3.png) <br/>
Learned how to use “Terraform plan” to view changes made before I use “terraform apply”. In the figure above, I am deploying a resource group called “terraform-rg” into Azure in the East US region. 



### 7. Deploying a virtual network into a pre existing resource group via Terraform: <br/>
 ![Alt Text](images/example4.png) <br/>
 Specifed resource group name and location. Assigned an address space. I did not declare subnets inline.
 
 
### 8. Deploying a subnet in Azure with Terraform to a pre existing virtual network: <br/>
 ![Alt Text](images/example5.png) <br/>
 
 
### 9. Creating an Azure Security Group with Terraform: <br/>
 ![Alt Text](images/example6.png) <br/>
 ![Alt Text](images/example7.png) <br/>
  I am deploying my Azure security group resource separate from the Azure security group rule. It makes it more simple to modify/ make certain changes going   forward. This will make infrastrcuture more efficient and easier to manage.
  
  
 ### 10. Creating Public IP with Terraform: <br/>
  ![Alt Text](images/example8.png) <br/>
  ![Alt Text](images/example9.png) <br/>
   NOTE: Ip_address is labeled known after apply but even after it is applied, it will not be known until it can attach to something like a vm. When the public ip is set to “Dynamic” it will not show up until it is attached to something and is used.


  



### 11. Creating a Network Interface in Azure with Terraform: <br/>
![Alt Text](images/example10.png) <br/>
 The NIC will receive its public ip address from the ip address I just created earlier.
 
     
     
 ### 12. Building a Linux Virtual Machine: <br/>
   ![Alt Text](images/example11.png) <br/>
     For the size of the vm, we select “Standard_B1s” because that is what is recommended in the free tier.


     
  ### 13. Creating an SSH key pair <br/>

   Before this VM is created we still need to create our SSH key pair and add our configuration scripts <br/>
      
   Start out with a “ssh-keygen -t rsa” command to generate a key. You want to put it in the same folder you’re working from. <br/>
      ![Alt Text](images/example12.png) <br/>
     ![Alt Text](images/example13.png) <br/>
      You can list the home directory /.ssh to find the keys available. <br/>
      
   Now you want to add the azure key block to the main.tf file. Make sure it’s within the Azurerm_linux_virtual_machine block.

![Alt Text](images/example14.png) <br/>
You want to utilize the “File” function and pass the terraformazurekey.pub direct directory through it to pull from it. <br/>




*** Virtual Machine has offically been created <br/>

![Alt Text](images/example15.png) <br/>



![Alt Text](images/example16.png) <br/>
 I then took the public address listed that was created and SSH into the Linux VM I created using
 “ssh -i ~/.ssh/terraformazurekey adminuser@20.163.142.147” 
 
 
![Alt Text](images/example17.png) <br/>
 
 I am currently now logged into the VM I created.
 Ran the command : "lsb_release -a" to confirm what version of Ubuntu I’m running and where I am currently located. 
 
 
 
 
 
 ### 14. Passing Custom Data into the Linux Virtual Machine via Terraform <br/>

  So here I am going to use the custom data argument to bootstrap the instance and install the docker engine. <br/>
  This will allow me to have a Linux VM with Docker ready to go for all my future deployment needs. <br/>

I created a customdata.tpl file (tpl typically stands for template) in the same working directory as Main.TF (Terraform-Azure folder) <br/>
I placed a bash script in the file to install docker to the image upon deployment. <br/>

![Alt Text](images/example18.png) <br/>
After that I went back to the main.tf and added the custom data argument to the Linux Virtual Machine section. <br/>
I used the filebase64 function because “custom_data” in Azure is expecting just that <br/>
![Alt Text](images/example19.png) <br/>
I passed the file “customdata.tpl” through the argument <br/>




![Alt Text](images/example20.png) <br/>
Here are my results from a "terraform plan" afterwards. <br/>
As you can see it says 1 to add and 1 to destroy. <br/>
** Note: it says one to destroy because custom data being added to the virtual machine forces the VM to be redeployed. <br/>



![Alt Text](images/example21.png) <br/>
NOTE: Once redeployed, the public ip has changed <br/>
I then SSH into the newly created VM <br/>
The command input is  “ssh -i ~/.ssh/terraformazurekey adminuser@74.235.9.99” <br/>




![Alt Text](images/example22.png) <br/>
Once successfully in the linux virtual machine, check to see if Docker has been successfully bootstrap to the deployment by running a “docker –version” <br/>
A bootstrap version of Docker to the Linux virtual machine was a success. It will now be ready to be deployed with the virtual machine anytime the VM is deployed. 



<h2>Conclusion</h2>
In conclusion, the successful completion of the Azure infrastructure provisioning project using Terraform has provided a reliable and efficient solution for managing infrastructure as code. By leveraging Terraform's declarative configuration and the power of Azure, I have achieved consistent and reproducible deployments of virtual machines, storage accounts, networking components, and more. The project has demonstrated the importance of careful planning and defining the desired state of our infrastructure, enabling the ability to scale and adapt as needed. Through rigorous testing and validation, I have ensured the functionality and performance of my deployed resources. Additionally, the use of Terraform's continuous deployment and updates feature has allowed me to make changes to the infrastructure configuration in a controlled and systematic manner. Overall, this project has empowered me to provision and manage Azure infrastructure in a scalable, efficient, and maintainable way, laying a strong foundation for future growth and development.
      

















<!--
 ```diff
- text in red
+ text in green
! text in orange
# text in gray
@@ text in purple (and bold)@@
```
--!>
