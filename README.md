# AWS EC2 AUTOSCALING PROJECT WITH TERRAFORM

## PROJECT TASK
- Set up 2 EC2 instances on AWS(use the free tier instances).
- Deploy an Nginx web server on these instances(you are free to use Ansible)
- Set up an ALB(Application Load balancer) to route requests to your EC2 instances
- Make sure that each server displays its own Hostname or IP address. You can use any programming language of your choice to display this.


### NOTE
- Access must be only via the load balancer
- You should define a logical network on the cloud for your servers.
- Your EC2 instances must be launched in a private network.
- Your Instances should not be assigned public IP addresses.
- set up auto scaling
- You must submit a custom domain name(from a domain provider e.g. Route53) or the ALB’s domain name.


**TO SEE A BREAKDOWN OF THE PROJECT SOLUTION** [CLICK HERE](https://github.com/Zenitugo/terraform-ec2-autoscaling-project/blob/master/Documentation.md)
