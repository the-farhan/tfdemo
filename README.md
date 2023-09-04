### Few Important Links

 - [HashiCorp Infrastructure Automation Certification](https://www.hashicorp.com/certification/terraform-associate)
 - [Udemy Course Link](https://www.udemy.com/course/terraform-beginner-to-advanced/)
 - [Download & Install Terraform](https://developer.hashicorp.com/terraform/downloads)
 - [Terraform Built-in Functions](https://developer.hashicorp.com/terraform/language/functions)
 - [Terraform Registry](https://registry.terraform.io/?product_intent=terraform)
 - [Terraform Providers](https://registry.terraform.io/browse/providers)
 - [Terraform Provisioners](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)
	- [Remote Exec](https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec)
	- [Local Exec](https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec)
 - [Terraform Modules](https://registry.terraform.io/browse/modules)
 - [Terraform .gitignore](https://github.com/github/gitignore/blob/main/Terraform.gitignore)
 - [Terraform Available Backends](https://developer.hashicorp.com/terraform/language/settings/backends/local)
 - [S3 State Locking Using DynamoDB](https://developer.hashicorp.com/terraform/language/settings/backends/s3#dynamodb-state-locking)
 - [Terraform Fetch Data From Remote State](https://developer.hashicorp.com/terraform/language/state/remote-state-data#example-usage-remote-backend)
 - [Terraform Import](https://developer.hashicorp.com/terraform/cli/import)
 - [Hashicorp Vault & Installation](https://developer.hashicorp.com/vault/docs/install)
	- [Download Valut](https://developer.hashicorp.com/vault/downloads)
 - [Create Free Terraform Cloud Account](https://app.terraform.io/public/signup/account)


### Important Commands
- To init/connect to the provider  `> terraform init`
- To see the terraform plan `> terraform plan`
- To apply the terraform plan subject to approval `> terraform apply`
- To apply the terraform plan with auto approval `> terraform apply -auto-approve`
- To destroy all the resources subject to approval `> terraform destroy`
- To destroy all the resources with auto approval `> terraform destroy -auto-approve`
- To test out the terraform built in function using terraform console `> terraform console`
- To indent the code or to format the code for better visibility/readability `> terraform fmt`
- To destroy and recreate a source. This is needed when someone manually messed up the resource so this command will destroy that resource and recreate it `> terraform apply -replace="<resource_type>.<local-name>"`
- To get a graph of the current terraform resources. Extension should be ***.dot***. Search an online tool to open the ***.dot*** file(textbase file) into the visual `> terraform graph > <filename>.dot`
- To save a terraform plan to a file `> terraform plan -out=path`. Later, this plan can be used in order to apply the changes shown in this terraform plan. For instance: `terraform plan -out=/home/farhan/ec2-plan`
- To apply the changes saved in an existing terraform plan file `> terraform apply <FILE-PATH>`. For instance: `> terraform plan /home/farhan/ec2-plan`
- To stop terraform freshing state `> terraform plan -refresh=false`. This is generally used on a very large terraform configurations where we want to change a tiny small piece of code and avoid to refresh all the resources' states to speed up the process. You can also specify the resource which should only be applied/planned. For instance: `> terraform plan -target=<RESOURCE-NAME.LOCAL-NAME>`
- To see the full logs on console
	- First step is to set the ***TF_LOG*** env variable. Verbosity could be any of these (*TRACE, DEBUG, INFO, ERROR*). For example `> SET TF_LOG=TRACE`
	- Once the env variable is set when you run `> terraoform apply` it'll show the the detailed terraform logs for that specific plan.
- To save the logs in a file
	- If the ***TF_LOG*** env variable is set, you then need to set another env variable ***TF_LOG_PATH*** and need to suuply the file path. For example: `> TF_LOG_PATH=persistent-log.txt`
- Terraform Workspace
	- To list down all the worksapces `> terraform workspace list`
	- To check the currnet selected workspace `> terraform workspace show`
	- To switch the existing workspace `> terraform workspace select <WORKSPACE-NAME>`
	- To create and switch to the new workspace `> terraform workspace new <WORKSPACE-NAME>`
- Terraform Backend
	- To list down all the folder from s3 root using aws cli `aws s3 ls`
	- To list down all the folder/files from any specific bucket/folder `aws s3 ls <bucket-name>/<folder-name>/`
- Terraform State Management
	- To list down the resources within a state file `> terraform state list`
	- To move item with terraform state `> terraform state mv <source-resource.local_name> <target-resource.local_name>`
	- To manually download and out the state from remote state `> terraform state pull`
	- To manually upload the local state file to remote state `> terraform state push` ***BE CAUTIOUS WHILE RUNNING THIS COMMAND; THIS SHOULDN'T BE RUN FREQUENTLY***
	- To show the attribute of a single resource in a state file `> terraform state show <resource.local_name>`
- Terraform Import
	- To import the existing resources which are not created using terraform can be imported using this command `terraform plan --generate-config-out=<filename.tf>`. This will generate the terraform code for the existing resources which were created manually. Remember that this command will only generate the terraform code and not the state file, To generate the state file, run the `terraform apply` after the earlier command. To use the terraform import feature you must have terraform verion > 1.5.x

### Points to Ponder
- **ALWASY ALWAYS ALWAYS DESTROY YOUR RESOURCE(S) ONCE YOU ARE DONE OTHERWISE IT'LL COST YOU TOO HIGH**
- **NEVER EVER STORE THE ACCESS/SECRET KEY, PASSWORDS OR ANY OTHER IMPORTANT INFORMATION IN THE GIT REPOSITORY**
	- One way to store the password/access/secret key is to store them in a file outside the git repository and just use the terraform `file` function.
	- The other is to use the environment variables.
	- Use the Hashicorp vault instead
- The good approach is to use smaller configuration rather than larger ones. For example, if you want to up the large infrastructure which includes 10 ec2, 5 s3-buckets, 100 security group rules, a vpc set-up etc. So alwasy prefer to create a separate folder for each type of resource which can be applied independently. This would allow you to manage the resources more effectively and quickly. 
- `count` parameter is usefull in such cases where the resources are almost identical. If distinct values are needed in the arguments, usage of `for_each` with `toset` function is recommended.
- While working with provisioners sometime you need to pass the keyfile in order to access the remote machine from your local machine. If you get an error while passing the keyfile `It is required that your private key files are not accessible to others` follow these steps
	- Window: Right click on the .pem file -> Properties -> Security -> ***Advance*** -> Disable Inheritance -> Convert inherited permissions into explicit permissions on this object. Once these steps are done, from the ***Advance*** screen remove all the users except the one you are logged in with.
	Linux: chmod 400 <file-path>
- Whenever you create a EC2 instance the default user is `ec2-user` and you can access the instance from your local machine via ssh like `ssh -i terraform-key.pem ec2-user@<public-ip-address>`
- Provisioners
	- local-exec is used to run any command/script on the host machine.
	- remote-exec is used to run any command/script on the remote machine.
- Sensitive Parameter:
	- You can set `sensitive = true` in terraform configuration to not allow the terraform to print the values on CLI. Like if you output the database password to be used in some other tf files you can set that output block to sensitive. Terraform will not show the database password in CLI.
