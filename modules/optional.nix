{ pkgs, ... }: {
  # Uncomment packages as needed
  home.packages = with pkgs; [
    # AWS
    awscli2
    nodePackages.aws-cdk
    aws-sam-cli
    # amazon-q-developer-cli  # If available

    # Java
    # jdk
    # maven

    # PHP
    # php

    # C++
    # vcpkg
  ];
}
