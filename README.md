clutch-chef
===========

> An AWS OpsWorks Chef cookbook for Clutch: An Open-ended Developer SDK for Prismic.io.


<img style="width:100%;" src="https://static1.squarespace.com/static/5925b6cb03596e075b56bfe2/5d059cfabc404e0001103362/5d059ef873542100013b0b53/1562516926893/Kitajchuk_ProperJS_Coverimage.jpg?format=2500w" />



### About
This Chef cookbook will configure an EC2 instance to run `nginx` and `node` for a [clutch](https://github.com/kitajchuk/clutch) project. Presently installing `node@v10.16.3` and `npm@latest`.



### Clutch Stack
This section will walk through setting up the `Clutch Stack` on [AWS OpsWorks](https://aws.amazon.com/opsworks).

#### Create the `clutch` security group
1. Navigate to Services > Compute > EC2 > Network & Security > Security Groups.
2. Make a new security group called `clutch`.
3. Add default Inbound rules for `HTTP`, `HTTPS` and `SSH`.

#### Create the `clutch` key pair
1. Navigate to Services > Compute > EC2 > Network & Security > Key Pairs.
2. Make a new key pair called `clutch` and download the PEM file.
3. Move the `clutch.pem` file to your `~/.ssh` directory.
4. Run `chmod 400 ~/.ssh/clutch.pem`. PEM file is needed only for initial dev SSH access.
5. Note that we'll be configuring SSH users on our EC2 instances later and the PEM file will no longer be needed for dev SSH access.

#### Create the Stack
1. Navigate to Services > Management & Governance > OpsWorks.
2. Start fresh and add your first Stack.
3. Choose the **Chef 12 Stack** and name it **Clutch**.
4. Choose your default **VPC**.
5. Use **Amazon Linux 2018.03**.
6. Choose your SSH key pair `clutch`.
7. Turn on custom Chef cookbooks.
8. Leave repository type as Git.
9. Use this repository URL - `https://github.com/kitajchuk/clutch-chef.git`.
10. Pick a color for your Stack.
11. Click Advanced settings and turn off "Use OpsWorks security groups" since this Stack will use the `clutch` security group.
12. Click the Add Stack button.

#### Add the Clutch Server Layer
1. Add a new Layer called **Clutch Server** with short name **clutch-server**.
2. Select to use the `clutch` security group.
3. Click add then under the recipes tab add the `clutch::setup` command to the Setup lifecycle.
4. Click Save.

#### Add the Clutch Chef App
1. Add an App called **Clutch Chef**.
2. Leave repository type as Git.
3. Use this repository URL - `https://github.com/kitajchuk/clutch-chef.git`.
4. Click the Add App button.

#### Add the Instance Environments
Do the following for `development` and `production` instances:

1. Add an instance to the `clutch` stack.
2. Label the hostname `{app}-{env}` — example: `clutch-dev`.
3. Pick a tier size.
4. Your Stack settings should be set under Advanced.
5. Set a volume size.
5. Click the Add Instance button.
6. Create a new Elastic IP.
7. Register the EIP with the instance.



#### Next Steps
That's it. Checkout the [clutch](https://github.com/kitajchuk/clutch) project for complete info on developing with the SDK.
