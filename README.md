<h1>Azure-Terraform-Infrastructure-Provision</h1>

 

<h2>Description</h2>
Create a reproducible dev environment within Azure that I can deploy anytime I want, use for whatever I need, commit to a code repository or destroy whenever with Terraform
<br />


<h2>Languages and Utilities Used</h2>
 
- <b>Terraform</b>
- <b>Bash</b>

<h2>Environments Used </h2>

- <b>Azure</b> 
- <b>Vscode</b>

<h2>Program walk-through:</h2>

** (This Walk through I created starts at the point where VScode and the Terraform extensions have already been installed)
 
 1. Open the Terminal in VScode. Run "az login" follow prompts to get signed in. You can evalute you succesffuly logged in by running "az account show"
 2. Create a new folder where you will begin to work from in this project. Ex. "Terraform-Azure"

 3. Created a "main.tf" file
 
 
 4. Azure Provider: <br/>
 ![image](https://github.com/Corey-Solomon/Azure-Terraform-Infrastructure-Provision/assets/117605112/33846668-fd59-4b73-95fa-870117ddb3ed) <br/>
Inserted in the Azure provider. What the Azure provider does is allows Terraform to communicate with the Azure API. That's how Terraform Knows how to deploy resources. I am administrating this procedure using the Azure CLI.


5. terraform init: <br/>
![image](https://github.com/Corey-Solomon/Azure-Terraform-Infrastructure-Provision/assets/117605112/c22bf242-b71b-49f2-8855-56ba0a3489b7) <br/>
ran the "terraform init" command to initialized the backend. The backend is a local backend which meants that my terraform state where everything is stored will be stored here.



6. Deploying a reosurce group: <br/>
![image](https://github.com/Corey-Solomon/Azure-Terraform-Infrastructure-Provision/assets/117605112/cbed0c57-1a9c-4317-9e4c-1f9dffd2476e) <br/>
Learned how to use “Terraform plan” to view changes made before I use “terraform apply”. In the figure above, I am deploying a resource group called “terraform-rg” into Azure in the East Us region. 



7. Deployed a virtual network into a pre existing resource group via Terraform: <br/>
 ![image](https://github.com/Corey-Solomon/Azure-Terraform-Infrastructure-Provision/assets/117605112/ea32e116-5d50-445c-a247-44f20bdd486e) <br/>
 Specifed resource group name and location. Assigned an address space. I did not declare subnets inline.
 
 
8. Deploying a subnet in Azure with Terraform to a pre existing virtual network: <br/>
 ![image](https://github.com/Corey-Solomon/Azure-Terraform-Infrastructure-Provision/assets/117605112/a3f25c25-d24a-435d-a140-4ee2bbf8378b) <br/>
 
 
 9. Creating an Azure Security Group with Terraform: <br/>
  ![image](https://github.com/Corey-Solomon/Azure-Terraform-Infrastructure-Provision/assets/117605112/292e204e-5908-4e16-a61e-ba6b9290c87f) <br/>
  I am deploying my Azure security group resource separate from the Azure security group rule. It makes it more simple to modify/ make certain changes going   forward. This will make things a lot cleaner and easier to manage.
  
  
 10. Creating Public IP with Terraform: <br/>
   ![image](https://github.com/Corey-Solomon/Azure-Terraform-Infrastructure-Provision/assets/117605112/cafa5cea-2bf4-4a1c-8d96-750d148d862a) <br/>
   ![image](https://github.com/Corey-Solomon/Azure-Terraform-Infrastructure-Provision/assets/117605112/4d602c97-dd38-4db2-830f-a69bfa368e9f) <br/>
   NOTE: Ip_address is labeled known after apply but even after it is applied, it will not be known until it can attach to something like a vm. When the public ip is set to “Dynamic” it will not show up until it is attached to something and is used.


  



 11. Creating a Network Interface in Azure with Terraform: <br/>
     ![image](https://github.com/Corey-Solomon/Azure-Terraform-Infrastructure-Provision/assets/117605112/9db16954-0e0b-434e-967e-5695426d176b) <br/>
     The NIC will receive it’s public ip address from the ip address I just created earlier.
     
     
 12. Building a Linux Virtual Machine: <br/>
     ![image](https://github.com/Corey-Solomon/Azure-Terraform-Infrastructure-Provision/assets/117605112/6d03add5-3eaa-4129-a002-1e530d8ee9e1) <br/>
     For the size of the vm, we select “Standard_B1s” because that is what is recommended in the free tier.


     
  13. Creating an SSH key pair <br/>

      Before this VM is created we still need to create our SSH key pair and add our configuration scripts <br/>
      
      Start out with a “ssh-keygen -t rsa” command to generate a key. You want to put it in the same folder you’re working from. <br/>
      ![image](https://github.com/Corey-Solomon/Azure-Terraform-Infrastructure-Provision/assets/117605112/45c59b46-9139-490f-97e6-fa340431816c) <br/>
      ![image](https://github.com/Corey-Solomon/Azure-Terraform-Infrastructure-Provision/assets/117605112/b84b7278-6fa6-4bae-950b-5469a68e8045) <br/>
      You can list the home directory /.ssh to find the keys available. <br/>
      
      Now you want to add the azure key block to the main.tf file. Make sure it’s within the Azurerm_linux_virtual_machine block.

![image](https://github.com/Corey-Solomon/Azure-Terraform-Infrastructure-Provision/assets/117605112/3a1d7b4d-9f0f-4c1b-8bf4-da29a03c5279) <br/>
You want to utilize the “File” function and pass the terraformazurekey.pub direct directory through it to pull from it <br/>




*** Virtual Machine has offically been created <br/>

![image](https://github.com/Corey-Solomon/Azure-Terraform-Infrastructure-Provision/assets/117605112/545cb0c9-6a9b-4800-bf04-0a87f7f5a467) <br/>




      




















<!--
 ```diff
- text in red
+ text in green
! text in orange
# text in gray
@@ text in purple (and bold)@@
```
--!>
