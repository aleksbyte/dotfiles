#
/opt/homebrew/bin/bash-language-server
/opt/homebrew/bin/pyright
    https://github.com/microsoft/pyright
    npm install -g pyright
/opt/homebrew/bin/gopls
    https://github.com/golang/tools/tree/master/gopls
    GO111MODULE=on go get golang.org/x/tools/gopls@latest

/opt/homebrew/bin/ansible-language-server
/opt/homebrew/bin/terraform-ls


Linters:
Shell Lint:     https://www.shellcheck.net/
    /opt/homebrew/bin/shellcheck
Python Lint: https://realpython.com/python-code-quality/
flake8, pylint, mypy
      /opt/homebrew/bin/flake8
      /opt/homebrew/bin/pylint
      /opt/homebrew/bin/mypy
Go Lint:   https://golangci-lint.run/
   /opt/homebrew/bin/golangci-lint
Ansible Lint:   https://ansible-lint.readthedocs.io/en/latest/
   /opt/homebrew/bin/ansible-lint
Terraform lint: https://github.com/terraform-linters/tflint/
   /opt/homebrew/bin/tflint
YAML Linter:
  /opt/homebrew/bin/yamllint
