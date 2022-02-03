### **Setting up an account**
In order to create your an account on EDI cluster please reach out to Janek and / or Staszek via Slack.

**You will get a set of two credentials in different e-mail messages.**

- First password allows to login to the entry node (jumphost) at <code>lbs.cent.uw.edu.pl</code>. 
This password needs to be changed after first login and subsequently in 90 days intervals.
- Second password allows to login to the compute [nodes](resources.md) <code>edi0[0-8]</code>.

!!! Information
    **Please note that for now password changes on each of the compute nodes and the entry node are not
    synced.**
    
    The centralized authentication system will be introduced in near future.

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
ssh tunnel to send / fetch files directly.

!!! Information
    This example will forward a port **22** on the **edi00** node to local port **7777** :
    ```sh
    ssh -NL 7777:edi00:22 your_username@lbs.cent.uw.edu.pl
    ```
    After setting up a tunnel you can directly fetch or send files:

    - Download "file.txt" from edi00
    ```sh
    scp -P 7777 your_username@localhost:file.txt .
    ```
    - Send "file2" txt to edi00
    ```sh
    scp -P 22 file2.txt your_username@localhost:
    ```

### **Next steps**
Once the basics are set up you should be able to start running calculations. Follow the next chapter for more details.