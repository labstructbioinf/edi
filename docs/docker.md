### **rootless docker**

Docker service is running in rootless mode which is described in detail here:
https://docs.docker.com/engine/security/rootless/

### **installation**

1. make sure your user is present in files: `/etc/subuid` and `/etc/subgid`. Contact administrator to get entry here
2. run `sh /home/nfs/teaching/rootless`.
3. add appropraite entries to `.bashrc`:
 ```
 export PATH=/home/users/[YOURUSER]/bin:$PATH
 # To get your user id type `id -u`.
 export DOCKER_HOST=unix:///run/user/[YOUR UID]/docker.sock 
 ```
 reload `source .bashrc` or relogin
3. [Optional] If docker is not available after reloging enable it on startup 
```bash
systemctl --user enable docker
```
4. verify installation
```bash
docker run -p 8080:80 nginx:alpine
```