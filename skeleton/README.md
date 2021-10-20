# Infraestrutura base

Repositório de código de infraestrutura básica para network utilizado na estrutura do ${{values.project_name}}.

Inclue itens como:
* VPC
* Subnets
  * Pública
  * Privada
* Internet Gateway
* NAT Gateway
* Route tables

## Distribuição dos IPs
* ${{values.cidr_qa}} - VPC da conta ${{values.project_name | lower | replace(" ", "-") }}-sandbox (${{values.region}})
* ${{values.cidr_prod}} - VPC da conta ${{values.project_name | lower | replace(" ", "-") }}-production (${{values.region}})

## Variaveis GitLab-CI:

    - ${{values.project_name | upper | replace(" ", "_") }}_CLUSTER_REGION_1
        - Region para a AWS

    - ${{values.project_name | upper | replace(" ", "_") }}_SERVICEACCOUNT_PROD
        - Profile da conta de produção (${{values.project_name | lower | replace(" ", "-") }}-production - 849197578363)

    - ${{values.project_name | upper | replace(" ", "_") }}_SERVICEACCOUNT_QA
        - Profile da conta de sandbox (${{values.project_name | lower | replace(" ", "-") }}-sandbox - 774504999002)
