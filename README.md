# local-dev-docker-compose

Local Integration testing with docker!

Assumptions: 

* linux
* HOME is located in the `/home/`
* projects git repos pulled into `/home/${USER}/projects/next/`
  * TODO in `iex --sname baz --remsh foo@HOST` the  `foo@HOST` is known: ${UID} and `hostname: ` of the container like `hostname: profile`
  so its `io@profile`
    * TODO apparently permissions, running in the container
    ```
    io@test:~$ iex --sname baz --remsh io@profile
2020-10-30 02:46:34.633634 
    args: []
    format: "Failed to create cookie file '/home/io/.erlang.cookie': eacces"
    label: {error_logger,error_msg}
    ...
    ```
  _the reason is `io:io` has no permissions in the container file system _
  
  Hence: *HUGE TODO* -> run as `root:root`
  
  
  
  

*TL;DR*

* Build 
  - riak with leveldb storage backend
  - rabbit with auth
  - elixir + tools 

```bash
docker build . -f riak-leveldb.docker -t riak-leveldb
docker build . -f rabbit-next.docker -t rabbit-next
docker build . -f demo-image.docker -t demo
```

* start all:

```bash
U_ID=$UID docker-compose up --remove-orphans
```

or 

```bash
U_ID=$UID docker-compose up -d

```

## Bonus - run mix in the container

```bash
alias mix='docker run -it -v ~/.cache/:/home/`id -un`/.cache/ -v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro  -u `id -u`:`id -g` -v `pwd`:`pwd` -w `pwd` -v ~/.ssh/:/home/`id -un`/.ssh/ -v ~/.mix:/home/`id -un`/.mix -v ~/.hex:/home/`id -un`/.hex  elixir mix'
```
See useful aliases and bash functions

* [.bash_aliases](.bash_aliases)
* [.docker_aliases](.docker_aliases)

## force rebuild

comment out start
uncomment rebuild

```
sed -i '~s~command: ./start-in-docker~#command: ./start-in-docker~g' docker-compose.yml
sed -i '~s~#command: ./rebuild_start_in_docker.sh~command: ./rebuild_start_in_docker.sh~g' docker-compose.yml
```

## back to start

uncomment out start
comment rebuild

```
sed -i '~s~#command: ./start-in-docker~command: ./start-in-docker~g' docker-compose.yml
sed -i '~s~command: ./rebuild_start_in_docker.sh~#command: ./rebuild_start_in_docker.sh~g' docker-compose.yml
```
