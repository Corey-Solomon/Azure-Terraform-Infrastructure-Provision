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
 
 
 4. 
Azure Provider: <br/>
 ![image](https://github.com/Corey-Solomon/Azure-Terraform-Infrastructure-Provision/assets/117605112/33846668-fd59-4b73-95fa-870117ddb3ed) <br/>
Inserted in the Azure provider. What the Azure provider does is allows Terraform to communicate with the Azure API. That's how Terraform Knows how to deploy resources. I am administrating this procedure using the Azure CLI.


<!--
 ```diff
- text in red
+ text in green
! text in orange
# text in gray
@@ text in purple (and bold)@@
```
--!>
