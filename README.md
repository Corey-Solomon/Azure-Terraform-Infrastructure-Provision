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





















<!--
 ```diff
- text in red
+ text in green
! text in orange
# text in gray
@@ text in purple (and bold)@@
```
--!>
