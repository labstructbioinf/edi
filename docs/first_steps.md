### **Setting up an account**
In order to create your an account on EDI cluster please send an e-mail to <code>placeholder@domain.com</code> with CC to 
<code>placholder_staszek@domain.com</code>. 

The credentials will be sent in a separate message through a private note.
!!! Information
    **It is a good practice to change the initially obtained password!**

    The credentials are managed through a central LDAP system which means that any password change done on
    one of the cluster nodes is automatically propagated to other nodes.

### **Connecting via SSH**
Connections to the EDI cluster are handled via SSH protocol.
```sh
ssh your_username@XX.YYY.ZZZ.AA
```
This will bring you to the **entry host**, afterwards you can connect to any of the **compute nodes** 
([click here](resources.md) for a complete list of available resources), for example:
```sh
ssh your_username@edi07
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
The recommended options to send or fetch files from EDI storage are either <code>scp</code> or <code>rsync</code>.

The storage on the entry host <code>lbs.cent.uw.edu.pl</code> is limited therefore it could be more convenient to setup
ssh tunnel to send / fetch files directly.

!!! Information
    This example will forward a port **22** on the **edi00** node to local port **7777** :
    ```sh
    ssh -NL 7777:edi00:22 your_username@XX.YYY.ZZZ.AA
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