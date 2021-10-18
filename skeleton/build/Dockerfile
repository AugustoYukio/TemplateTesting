FROM ubuntu:latest

# Prepare environment
ENV DEBIAN_FRONTEND=noninteractive

#======================================================#
# Cria diretorio de configuração da AWS se não existir #
#======================================================#
RUN mkdir -p ~/.aws

# Install common programs and tools
#==================================#
# Atualização da base de programas #
#==================================#
RUN apt-get -qq update; \
    apt-get install -qqy \
      apt-utils \
      curl \
      wget \
      software-properties-common \
      python3 \
      python3-pip \
      awscli \
      ansible \
      unzip \
      git

#==============================================#
# Instalação das Collections do Ansible        #
#==============================================#
RUN ansible-galaxy collection install community.kubernetes && \
    ansible-galaxy collection install community.general

#=====================================#
# Instalação dos pacotes do pip       #
#=====================================#
RUN pip3 install openshift && \
    pip3 install jinja2-cli


# Install kubernetes toosl
#=======================#
# Instalação do kubectl #
#=======================#
RUN until type kubectl; do \
      releaseVer=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt); \
      if curl -LO "https://storage.googleapis.com/kubernetes-release/release/$releaseVer/bin/linux/amd64/kubectl"; \
      then \
        chmod +x ./kubectl; \
        mv ./kubectl /usr/local/bin/kubectl; \
      fi; \
    done && echo "Instalação do kubectl concluída!"

#====================#
# Instalação do helm #
#====================#
RUN until type helm; do \
      rm -f helm-v3.5.0-linux-amd64.tar.gz; \
      rm -f linux-amd64/helm; \
      rm -f /usr/local/bin/helm; \
      if wget -q https://get.helm.sh/helm-v3.5.0-linux-amd64.tar.gz; \
      then \
        tar zxvf helm-v3.5.0-linux-amd64.tar.gz; \
        mv linux-amd64/helm /usr/local/bin/helm; \
      fi; \
    done && echo "Instalação do helm concluído!"

#========================#
# Instalação do istioctl #
#========================#
RUN until type istioctl; \
    do \
      if curl -sL https://istio.io/downloadIstioctl | sh -; \
      then \
          export PATH=$PATH:$HOME/.istioctl/bin; \
          echo -e "\n# Configuração do istioctl\n" >> ~/.profile; \
          echo -e "export PATH=$PATH:$HOME/.istioctl/bin\n" >> ~/.profile; \
      fi; \
    done && echo "Instalação do istioctl concluída!"

#=========================#
# Instalação do Terraform #
#=========================#
RUN until type terraform; \
    do \
      if wget --quiet https://releases.hashicorp.com/terraform/0.14.4/terraform_0.14.4_linux_amd64.zip; \
      then \
          unzip terraform_0.14.4_linux_amd64.zip -d /usr/bin; \
          rm terraform_0.14.4_linux_amd64.zip; \
      else \
          echo "Falha - Nova tentativa de instalação do terraform..."; \
          rm -f terraform_0.14.4_linux_amd64.zip; \
          rm -f/usr/bin/terraform; \
      fi; \
    done && echo "Instalação do Terrform concluída!"

# Install ArgoCD
#======================#
# Instalação do argocd #
#======================#
RUN until type argocd; \
    do \
      ARGOCD_CLI_VERSION=$(curl --silent "https://api.github.com/repos/argoproj/argo-cd/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/'); \
      if curl -sSL -o /usr/local/bin/argocd "https://github.com/argoproj/argo-cd/releases/download/${ARGOCD_CLI_VERSION}/argocd-linux-amd64"; \
      then \
          chmod +x /usr/local/bin/argocd; \
          export ARGOCD_OPTS='--port-forward-namespace argocd'; \
          echo -e "\n# Configuração do ArgoCD\n" >> ~/.profile; \
          echo -e "export ARGOCD_OPTS='--port-forward-namespace argocd'\n" >> ~/.profile; \
      fi \
    done && echo "Instalação do Argocd concluída!"

# Install Vault
#=====================#
# Instalação do Vault #
#=====================#
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
    apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
    apt-get update -qqy && apt-get install -qqy vault

# Install YQ
#==================#
# Instalação do YQ #
#==================#
RUN python3 -m pip install yq && \
    apt-get update && apt-get install -qqy jq

# System upgrade
#===============================#
# Atualização de todo o sistema #
#===============================#
RUN apt-get -qqy upgrade && \
    apt-get -qqy autoclean && \
    apt-get -qqy autoremove

COPY entrypoint.sh /entrypoint.sh

EXPOSE 9200
