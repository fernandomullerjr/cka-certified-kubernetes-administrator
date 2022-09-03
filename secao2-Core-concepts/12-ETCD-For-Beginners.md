

# ETCD

ETCD is a distributed reliable key value store that is Simple, Secure & Fast.


# key value store
Key         Value
Name        John Doe
Age         45
Location    New York
Salary      5000


- Exemplo
{
    "name": "John,"age": 45,
    "location": "New York",
    "salary": 5000
}




# Install ETCD
1. Download Binaries
2. Extract
3. Run ETCD Service
curl -L https://github.com/etcd-io/etcd/releases/download/v3.3.11/etcd-v3.3.11-linux-amd64.tar.gz -o etcd-v3.3.11-linux-amd64.tar.gz
tar xzvf etcd-v3.3.11-linux-amd64.tar.gz
 cd etcd-v3.3.11-linux-amd64/
./etcd




# Operate ETCD
3. Run ETCD Service
./etcd
./etcdctl set key1 value1
./etcdctl get key1
value1
./etcdctl


- Testando os comandos:

~~~~bash
fernando@debian10x64:/tmp/etcd-v3.3.11-linux-amd64$ ./etcdctl get --sort
Error:  key required
fernando@debian10x64:/tmp/etcd-v3.3.11-linux-amd64$ ./etcdctl get chave --sort
Error:  100: Key not found (/chave) [3]
fernando@debian10x64:/tmp/etcd-v3.3.11-linux-amd64$ ./etcdctl set key1 value1
value1
fernando@debian10x64:/tmp/etcd-v3.3.11-linux-amd64$ ./etcdctl get key1
value1
fernando@debian10x64:/tmp/etcd-v3.3.11-linux-amd64$
~~~~



- Saída do comando etcdctl sem parametros:

~~~~bash
fernando@debian10x64:/tmp/etcd-v3.3.11-linux-amd64$ ./etcdctl
NAME:
   etcdctl - A simple command line client for etcd.

WARNING:
   Environment variable ETCDCTL_API is not set; defaults to etcdctl v2.
   Set environment variable ETCDCTL_API=3 to use v3 API or ETCDCTL_API=2 to use v2 API.

USAGE:
   etcdctl [global options] command [command options] [arguments...]

VERSION:
   3.3.11

COMMANDS:
     backup          backup an etcd directory
     cluster-health  check the health of the etcd cluster
     mk              make a new key with a given value
     mkdir           make a new directory
     rm              remove a key or a directory
     rmdir           removes the key if it is an empty directory or a key-value pair
     get             retrieve the value of a key
     ls              retrieve a directory
     set             set the value of a key
     setdir          create a new directory or update an existing directory TTL
     update          update an existing key with a given value
     updatedir       update an existing directory
     watch           watch a key for changes
     exec-watch      watch a key for changes and exec an executable
     member          member add, remove and list subcommands
     user            user add, grant and revoke subcommands
     role            role add, grant and revoke subcommands
     auth            overall auth controls
     help, h         Shows a list of commands or help for one command

GLOBAL OPTIONS:
   --debug                          output cURL commands which can be used to reproduce the request
   --no-sync                        don t synchronize cluster information before sending request
   --output simple, -o simple       output response in the given format (simple, `extended` or `json`) (default: "simple")
   --discovery-srv value, -D value  domain name to query for SRV records describing cluster endpoints
   --insecure-discovery             accept insecure SRV records describing cluster endpoints
   --peers value, -C value          DEPRECATED - "--endpoints" should be used instead
   --endpoint value                 DEPRECATED - "--endpoints" should be used instead
   --endpoints value                a comma-delimited list of machine addresses in the cluster (default: "http://127.0.0.1:2379,http://127.0.0.1:4001")
   --cert-file value                identify HTTPS client using this SSL certificate file
   --key-file value                 identify HTTPS client using this SSL key file
   --ca-file value                  verify certificates of HTTPS-enabled servers using this CA bundle
   --username value, -u value       provide username[:password] and prompt if password is not supplied.
   --timeout value                  connection timeout per request (default: 2s)
   --total-timeout value            timeout for the command execution (except watch) (default: 5s)
   --help, -h                       show help
   --version, -v                    print the version

fernando@debian10x64:/tmp/etcd-v3.3.11-linux-amd64$ ^C
fernando@debian10x64:/tmp/etcd-v3.3.11-linux-amd64$
~~~~