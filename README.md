## terraform_cidrhost

## Why was this needed
This repo contains the code that I have used to apply static IP's to a couple of domain controllers in a terraform project I am working on.  I had the issue where I wanted to create two Domain controllers and as we all know a DC likes to have a static IP in fact on promotion an din fact will point out the fact the server being promoted does not have a static IP. I know in Azure that setting an IP static means that the IP is just reservation on the DHCP server but wanted to make sure there was no chance that the server IP would change, giving the nature of the servers roles. I also wanted a way that I could assign the IP I wanted too. So this coupled with the issue that I was using count to build the number of servers I wanted meant I need a neat way to do this.

I found a Terraform function called "CidrHost". This function asks for in its parameters a cidr notation subnet( x.x.x.x/x), then a host number. In the example below the IP configuration shows an instance that uses a variable for the subnet and then adds 10 to the count.index (so if count.index = 1 then the hostnumber is 1 + 10 so the host is 11  making the IP x.x.x.11)

<pre><code>
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.subnet_address_prefix, count.index + 10)

  }
</code></pre>

I found this set the IPs and I could be happy, the IP of the server could be set accordingly knowing it was set in Azure. 

The code in the repo creates
1. Resource Group
2. Virtual Network
3. A subnet
4. Two Interfaces  - to show using the count parameter

The code is set up to be self contained so will run, a look over the variables will be a good idea to make they do not clash with anything named that you already have. I only create two with this variable...but I did try a lot more and it worked as expected.

Pre Reqs to run
1. Terraform 0.12 installed on the local computer
2. An Azure Account where the resources can be built
3. Clone the repo locally

Commands to run,

1. Open a command prompt in the folder containing the downloaded code
2. Change Directory of your command prompt into the cidrhost folder, along side the main.tf
3. run > terraform init
4. run > terraform plan -out="cidrhost.tfplan"
5. run > terraform apply "cidrhost.tfplan"
6. Check the results on line

You could try altering the plus(+) figure from 10n and the re-run the plan and apply, this will change the IP address of the interface accordingly.


## Links

https://www.terraform.io/docs/configuration/functions/cidrhost.html  - the page where I found the definition of the function


