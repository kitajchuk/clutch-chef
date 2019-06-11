clutch-chef
===========

> An AWS OpsWorks Chef cookbook for clutch.



### About
This Chef cookbook will configure an EC2 instance to run `nginx` and `node` for a [clutch](https://github.com/kitajchuk/clutch) project. Presently installing `node@v6.11.0` and `npm@v5.1.x`.



### Clutch Stack
This section will walk through setting up the `Clutch Stack` on [AWS OpsWorks](https://aws.amazon.com/opsworks).

#### Create the security group
1. Make a new security group called `clutch`
2. Add default Inbound rules for `HTTP` and `SSH`

#### Create the key pair
1. Make a new key pair called `clutch` and download the pem file
2. Move the `clutch.pem` file to your `~/.ssh` directory
3. Run `chmod 400 ~/.ssh/clutch.pem`

#### Create the Stack
1. Choose the **Chef 12 Stack**
2. Give the stack a name, how about **Clutch**
3. Choose your default **VPC**
4. Use **Amazon Linux 2**
5. Choose your SSH key pair `clutch`
6. Turn on custom Chef cookbooks
7. Leave repository type as Git
8. Use this repository URL - `https://github.com/kitajchuk/clutch-chef.git`
9. Pick a color for your Stack
10. Click Advanced settings and turn off "Use OpsWorks security groups" since this Stack will use the `clutch` security group
11. Click the Add Stack button

#### Add the Clutch Server Layer
1. Add a new Layer called **Clutch Server**
2. Under recipes add `clutch::setup` to the Setup lifecycle

#### Add the Clutch Chef App
1. Add an app called **Clutch Chef**
2. Leave repository type as Git
3. Use this repository URL - `https://github.com/kitajchuk/clutch-chef.git`
4. Click the Add App button

#### Add the Instance Environments
Do the following for `staging` and `production` instances:

1. Add an instance to the `clutch` stack
2. Label the hostname `{project}-{environment}` — example: `kitajchuk-www-staging`
3. Pick a tier size
4. Your Stack settings should be set under Advanced
5. Click the Add Instance button
6. Create a new Elastic IP
7. Register the EIP with the instance



### Next Steps
Refer back to the Clutch SDK to finish the [AWS setup](https://github.com/kitajchuk/clutch#aws-setup).
