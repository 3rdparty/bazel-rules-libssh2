"""Dependency specific initialization."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@rules_foreign_cc//foreign_cc:repositories.bzl", "rules_foreign_cc_dependencies")
load("@com_github_3rdparty_bazel_rules_openssl//bazel:deps.bzl", openssl_deps="deps")

def deps(repo_mapping = {}):
    rules_foreign_cc_dependencies()

    openssl_deps(
        repo_mapping = repo_mapping,
    )

    maybe(
        http_archive,
        name = "com_github_libssh2_libssh2",
        urls = [
            "https://github.com/libssh2/libssh2/releases/download/libssh2-1.9.0/libssh2-1.9.0.tar.gz",
        ],
        type = "tar.gz",
        sha256 = "d5fb8bd563305fd1074dda90bd053fb2d29fc4bce048d182f96eaa466dfadafd",
        strip_prefix = "libssh2-1.9.0",
        build_file = "@com_github_3rdparty_bazel_rules_libssh2//:BUILD.bazel",
        repo_mapping = repo_mapping,
    )

    maybe(
        git_repository,
        name = "boringssl",
        commit = "fc44652a42b396e1645d5e72aba053349992136a",
        remote = "https://boringssl.googlesource.com/boringssl",
        shallow_since = "1627579704 +0000",
        repo_mapping = repo_mapping,
    )
