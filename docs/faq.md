### **How to run Jupyter notebooks remotely on EDI?**

Assuming <code>jupyter</code> is running on <code>edi07</code> (port <code>8889</code>) it is possible
to tunnel the ssh conection as follows:
```sh
ssh -L 8889:localhost:8889 your_username@lbs.cent.uw.edu.pl -t ssh -NL 8889:localhost:8889 your_username@edi07
```

Afterwards you should be able to see the running Jupyter instance via browser at the URL:
<code>http://localhost:8889</code>

### **How to install python packages on EDI?**
<code>python3</code> (3.6.9) and <code>python2</code> (2.7.17) along with the recent <code>pip</code> 
and <code>virtualenv</code> are installed system-wide on each EDI.

You can simply install packages either with <code>pip install --user</code> or use <code>virtualenv</code>
(this will allow to handle multiple projects with possibly conflicting dependencies).

Finally, if you need newer versions of <code>python</code> or want to handle complicated dependencies you can install a
local version of <code>anaconda</code> in your <code>$HOME</code> directory.

### **I want to use program <code>XXX</code> on EDI, can I install it on my own?**

You can install any software you like in your <code>$HOME</code> directory (as long as you have a valid license to use it).

If you need support in setup of some program or want it to be installed system-wide, please contact the administrators.

### **What are the guidelines for <code>/home/nfs/</code> distributed filesystem use?**
 
- Store only the necessary data in your <code>/home/nfs/your_username</code> directory. The space in this filesystem is limited.
    - For example: storing your conda distribution, scripts, inputs for jobs run on the cluster and small outputs
that you'll move to personal space after completion of the calculations is **OK**. 
- Avoid prolonged and heavy I/O operations (like reading and writing large files).
    - For example: Writing output from the MD simulations in <code>amber</code> (successive, small write operations) is **OK**.
Reading a 100 GB file from <code>nfs</code> directory is **not OK**.
