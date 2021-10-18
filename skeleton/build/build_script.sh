#!/bin/bash

f_prepare() {
    echo "#======================================================#"
    echo "# Cria diretorio de configuração da AWS se não existir #"
    echo "#======================================================#"
    echo
    mkdir -p ~/.aws
    echo
}

f_aptSoft() {
    echo "#==================================#"
    echo "# Atualização da base de programas #"
    echo "#==================================#"
    echo
    apt-get -qq update &>/dev/null
    echo

    declare -a programsToInstall=("apt-utils" "curl" "wget" "software-properties-common" "python3" "python3-pip" "awscli" "ansible" "unzip" "git")

    for val in "${programsToInstall[@]}"; do
        echo "#=================================="
        echo "# Instalando $val"
        echo "#=================================="
        echo
        apt-get -qq install -y "${val}" &>/dev/null
        echo
    done
}

f_pipInstall() {
    echo "#=====================================#"
    echo "# Instalação dos pacotes do pip       #"
    echo "#=====================================#"
    echo
    pip3 install openshift &>/dev/null
    pip3 install jinja2-cli &>/dev/null
    echo
}

f_AnsibleCollectionInstall() {
    echo "#==============================================#"
    echo "# Instalação das Collections do Ansible        #"
    echo "#==============================================#"
    echo
    ansible-galaxy collection install community.kubernetes &>/dev/null
    ansible-galaxy collection install community.general &>/dev/null
    echo
}

f_aptHard() {
    echo "#===============================#"
    echo "# Atualização de todo o sistema #"
    echo "#===============================#"
    echo
    apt-get -qq -y upgrade &>/dev/null
    echo
    apt-get -qq -y autoclean &>/dev/null
    echo
    apt-get -qq -y autoremove &>/dev/null
    echo
}

f_kubectlIntall() {
    echo "#=======================#"
    echo "# Instalação do kubectl #"
    echo "#=======================#"
    echo
    until [ "$(type kubectl &>/dev/null; echo $?)" -eq 0 ]; do
        f_kubectlInstallation
    done && echo "Instalação do kubectl concluída!"
    echo
}

f_kubectlInstallation() {
    releaseVer=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
    if curl -LO "https://storage.googleapis.com/kubernetes-release/release/$releaseVer/bin/linux/amd64/kubectl";
    then
        echo "Falha - Nova tentativa de instalação do kubectl..."
        echo
    else
        chmod +x ./kubectl
        mv ./kubectl /usr/local/bin/kubectl
    fi
}

f_helmInstall() {
    echo "#====================#"
    echo "# Instalação do helm #"
    echo "#====================#"
    echo
    until [ "$(type helm &>/dev/null; echo $?)" -eq 0 ]; do
        f_helmInstallation
    done && echo "Instalação do helm concluído!"
    echo
}

f_helmInstallation() {
    rm -f helm-v3.5.0-linux-amd64.tar.gz
    rm -f linux-amd64/helm
    rm -f /usr/local/bin/helm

    # wget -q https://get.helm.sh/helm-v3.5.0-linux-amd64.tar.gz
    if wget -q https://get.helm.sh/helm-v3.5.0-linux-amd64.tar.gz;
    then

        echo "Falha - Nova tentativa de instalação do helm..."
        echo
    else
        tar zxvf helm-v3.5.0-linux-amd64.tar.gz
        mv linux-amd64/helm /usr/local/bin/helm
    fi
}

f_istioCLIInstall() {
    echo "#========================#"
    echo "# Instalação do istioctl #"
    echo "#========================#"
    echo
    until [ "$(type istioctl &>/dev/null; echo $?)" -eq 0 ];
    do
        f_istioCLIInstallation
    done && echo "Instalação do istioctl concluída!"
    echo
}

f_istioCLIInstallation() {
    if curl -sL https://istio.io/downloadIstioctl | sh -;
    # if [ $? -eq 0 ]
    then
        export PATH=$PATH:$HOME/.istioctl/bin
        echo -e "\n# Configuração do istioctl\n"          >> ~/.profile
        echo -e "export PATH=$PATH:$HOME/.istioctl/bin\n" >> ~/.profile
    else
        echo "Falha - Nova tentativa de instalação do istioctl..."
        echo
    fi
}

f_argoInstall() {
    echo "#======================#"
    echo "# Instalação do argocd #"
    echo "#======================#"
    echo
    until [ "$(type argocd &>/dev/null; echo $?)" -eq 0 ];
    do
        f_argoInstallation
    done && echo "Instalação do Argocd concluída!"
    echo
}

f_argoInstallation() {
    ARGOCD_CLI_VERSION=$(curl --silent "https://api.github.com/repos/argoproj/argo-cd/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')
    if curl -sSL -o /usr/local/bin/argocd "https://github.com/argoproj/argo-cd/releases/download/${ARGOCD_CLI_VERSION}/argocd-linux-amd64";
    # if [ $? -eq 0 ];
    then
        chmod +x /usr/local/bin/argocd
        export ARGOCD_OPTS='--port-forward-namespace argocd'
        echo -e "\n# Configuração do ArgoCD\n"                           >> ~/.profile
        echo -e "export ARGOCD_OPTS='--port-forward-namespace argocd'\n" >> ~/.profile
    else
        echo "Falha - Nova tentativa de instalação do argocd..."
        echo
    fi
}

f_terraformInstall() {
    echo "#=========================#"
    echo "# Instalação do Terraform #"
    echo "#=========================#"
    echo
    until [ "$(type terraform &>/dev/null; echo $?)" -eq 0 ];
    do
        f_terraformInstallation
    done && echo "Instalação do Terrform concluída!"
    echo
}

f_terraformInstallation() {
    if wget --quiet https://releases.hashicorp.com/terraform/0.14.4/terraform_0.14.4_linux_amd64.zip;
    # if [ $? -eq 0 ];
    then
        unzip terraform_0.14.4_linux_amd64.zip -d /usr/bin
        rm terraform_0.14.4_linux_amd64.zip
    else
        echo "Falha - Nova tentativa de instalação do terraform..."
        rm -f terraform_0.14.4_linux_amd64.zip
        rm -f/usr/bin/terraform
        echo
    fi

}

main() {

    # Prepare environment
    f_prepare

    # Install common programs and tools
    f_aptSoft
    f_AnsibleCollectionInstall
    f_pipInstall

    # Install kubernetes toosl
    f_kubectlIntall
    f_helmInstall
    f_istioCLIInstall
    f_terraformInstall

    # Install ArgoCD
    f_argoInstall

    # System upgrade
    f_aptHard

}

main
