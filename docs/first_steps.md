### **Setting up an account**
In order to create your an account on EDI cluster please reach out to Kamil and / or Staszek via Slack or e-mail.

** After the account is approved you will receive credentials via e-mail from the <code> it @ cent.uw.edu.pl </code> address.**


The obtained password will allow to login to the entry node (jumphost) at <code>lbs.cent.uw.edu.pl</code> and compute [nodes](resources.md) <code>edi0[0-8]</code>.

** Please familiarize yourself with the general rules of cluster usage before proceeding
further - [LINK](rules.md) **

!!! Warning
    **Important:** in case of lost password or other technical difficulties related to the **entry node** 
    (not compute nodes) please reach out to the IT department at CeNT UW - address: <code>it @ cent.uw.edu.pl</code>.
    
    Include the <code>[sih-61]</code> prefix in the message title and add cluster administrators @Kamil and @Staszek in CC.

!!! Information
    **Please note that password changes on each of the compute nodes and the entry node are synced. It is advised to change your initially obtained password after first login.**

### **Connecting via SSH**
Connections to the EDI cluster are handled via SSH protocol. See the figure below
for a brief introduction of the network organization:
![Screenshot](img/scheme1.png)

In order to login to the entry node you can issue the following command:

```sh
ssh your_username@lbs.cent.uw.edu.pl
```
This will bring you to the **entry node (jumphost)**, afterwards you can connect to any of the **compute nodes** 
([click here](resources.md) for a complete list of available resources), for example:
```sh
ssh your_username@edi01
```

**In order to simplify file copying, every day work with e.g. Jupyter notebooks the suggested way of connecting
to individual <code>edi</code> nodes is to use [sshuttle](https://github.com/sshuttle/sshuttle). This allows to
bypass the login node and work almost the same way as being connected via VPN to the local network.**

!!! Example
    Assuming <code>sshuttle</code> was installed according to the [guide](https://sshuttle.readthedocs.io/en/stable/installation.html)
    you can connect as follows:
    ```sh
    sshuttle --dns -NHr your_username@lbs.cent.uw.edu.pl 10.10.61.1/24
    ```
    Once connection is established you can directly login to any <code>edi</code> node:
    ```sh
    ssh edi05
    ```
    
!!! Information
    Additionally, depending on your computer and network settings, you may have to connect to <code>edi</code> nodes 
    once without <code>sshuttle</code> so that SSH connections are properly configured.

To avoid putting password during each login you can set up authorization via a certificate - additional information
is available [here](certificates.md)

### **Work environment**
Each user has access to two personal directories:

- <code>/home/users/your_username</code>
- <code>/home/nfs/your_username</code>
!!! Warning
    **The contents of the default directory <code>/home/users/your_username</code> are unique to each compute node and 
    they are not available on other nodes.** 
    
    In order to use distributed file system please <code>/home/nfs/your_username</code> network mount 
    (please follow the [guidelines](faq.md#what-are-the-guidelines-for-homenfs-distributed-filesystem-use)).

### **Transferring files**
The recommended options to send or fetch files from EDI cluster are either <code>scp</code> or <code>rsync</code>.

The storage on the entry host <code>lbs.cent.uw.edu.pl</code> is **very** limited therefore it is recommended to setup
**sshuttle** to send / fetch files directly.

!!! Information
    Assuming you established a connection with <code>sshuttle</code> you can directly send files or
    directories to any <code>edi</code> node:
    ```sh
    scp file.txt your_username@edi05:
    ```


### Jupyter setup
#### add entry to ssh config file
With below entry you can login directly into edi cluster eg. `ssh user@ediXX` without specification of the jumphost.
add the following entry to your `~/.ssh/config` if the file does not exsits create it.
REPLACE `USER` with your user name and `ediXX` with appropraite node in below command.
```bash
Host jumphost
User USER
Hostname lbs.cent.uw.edu.pl
Host ediXX
User USER
ProxyJump jumphost
```

#### start jupyter instance
now login into desired node activate appropriate python environemnt.
REPLACE `port` with you port typically in the range of 8000.
```bash
jupyter-lab --no-browser --port [port]
```

#### forward port

REPLACE `[port]` with the port value from above command and `ediXX` with destination node.
```bash
ssh -NL [port]:localhost:[port] ediXX
```





### **Next steps**
Once the basics are set up you should be able to start running calculations. Follow the next chapter for more details.
