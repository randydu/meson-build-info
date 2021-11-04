# Build-Info

Auto-generate build version and timestamp from local GIT repository.


## Output:

meson.project_build_dir()/build.h



Example:

```c
// ${build_dir}/subprojects/build-info/build.h

#define BUILD_DESC "master-8-g99129ba0-dirty"
#define BUILD_DATE "2021-01-05 17:20:40 -0800"
```

## Usage


* Step 1: copy "build-info.wrap" to the "subprojects" folder of your main project;

* Step 2: in the main project's meson.build:

```
# import

buildinfo_dep = dependency('build-info')

# use
srcs = ['main.c', ...]

executable('test', srcs, dependencies: [buildinfo_dep, ...])
```

in main.c:

```c
#include <build.h>

printf("version: %s, build on %s\n", BUILD_DESC, BUILD_DATE);
```

