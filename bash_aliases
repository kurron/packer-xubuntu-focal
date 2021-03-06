alias aws='docker run --rm --interactive --tty --volume ~/.aws:/root/.aws --volume $(pwd):/aws amazon/aws-cli:latest'
alias packer='docker run --rm --interactive --tty --user=$(id -u $(whoami)):$(id -g $(whoami)) --volume $(pwd):$(pwd) --workdir $(pwd) hashicorp/packer:latest'
alias terraform='docker run --rm --interactive --tty --user=$(id -u $(whoami)):$(id -g $(whoami)) --volume $(pwd):$(pwd) --workdir $(pwd) hashicorp/terraform:latest'
alias vault='docker run --rm --interactive --tty --user=$(id -u $(whoami)):$(id -g $(whoami)) --volume $(pwd):$(pwd) --workdir $(pwd) hashicorp/vault:latest'

