---
title: "Hiding output of command"
date: 2021-1-5T10:50:20+06:00
#hero: /images/posts/writing-posts/git.svg
menu:
  sidebar:
    name: Hiding output of command
    identifier: linux-hiding-output
    parent: Linux
    weight: 10
---

To hide the output of any command usually the stdout and stderr are redirected to `/dev/null`.

```
command > /dev/null 2>&1
```

**Explanation:**

1. `command > /dev/null`: redirects the output of `command`(stdout) to `/dev/null`
2. `2>&1`: redirects `stderr` to `stdout`, so errors (if any) also goes to `/dev/null`

**Note:**

`&>/dev/null`: redirects both stdout and stderr to `/dev/null`. one can use it as an alternate of /dev/null 2>&1
