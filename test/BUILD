load("@io_bazel_rules_docker//docker/util:run.bzl", "container_run_and_commit_layer")
load("@io_bazel_rules_docker//container:container.bzl", "container_image", "container_push")


container_run_and_commit_layer(
  name = "install_deps",
  image = "@python//image",
  commands = [
        "curl -Lo /usr/local/bin/tini https://github.com/krallin/tini/releases/download/v0.19.0/tini-amd64",
        "chmod +x /usr/local/bin/tini",
        "apt-get update",
        "apt-get install --reinstall coreutils",
        "apt-get install -y openssh-server",
        "mkdir -p /var/run/sshd",
        "curl -Lo /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/v12.9.0/binaries/gitlab-runner-linux-amd64",
        "chmod +x /usr/local/bin/gitlab-runner",
        "curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash",
        "apt-get install git-lfs",
        "git lfs install --skip-repo",
    ],
)

container_image(
    name = "myapp_image",
    base = "@python//image",
    layers = [":install_deps"],
    directory = "/usr/local/bin",
    files = [ "docker-entrypoint.sh"],
    cmd = ["/usr/local/bin/tini", "--", "/usr/local/bin/docker-entrypoint.sh"],
    entrypoint = [],
    ports = ["22"],
)

container_push(
    name = "push_myapp_image",
    image = ":myapp_image",
    format = "Docker",
    registry = "index.docker.io",
    repository = "zyfu90/test",
    tag = "latest",
)
