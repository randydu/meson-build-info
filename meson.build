project('build-info')

prj_dir = meson.project_source_root()
message('prj_dir =' + prj_dir)

if host_machine.system() == 'windows'
    cmd = 'genbuild.cmd'
else
    cmd = 'genbuild.sh'
endif

custom_target('build.h',
    output: 'build.h',
    command: [files(cmd), join_paths(meson.project_build_root(), 'build.h'), meson.source_root()],
    build_always_stale: true,
    build_by_default: true,
    )

buildinfo_dep = declare_dependency(
    include_directories: '.',
)