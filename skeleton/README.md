# Infraestrutura base

Repositório de código de infraestrutura básica para network utilizado na estrutura do iFood Lite.

Inclue itens como:
* VPC
* Subnets
  * Pública
  * Privada
* Internet Gateway
* NAT Gateway
* Route tables
* Transit Gateway

## Distribuição dos IPs
* 10.33.0.0/16 - VPC da conta ifood-internal-services-sandbox (us-east-1)
* 10.198.0.0/16 - VPC da conta ifood-dev (sa-east-1)

* 10.34.0.0/16 - VPC da conta ifood-lite-sandbox (us-east-1)
* 10.133.0.0/16 - VPC da conta ifood-lite-production (us-east-1)

## Variaveis GitLab-CI:

    - IFOOD_LITE_CLUSTER_REGION_1
        - Region para a AWS

    - IFOOD_LITE_SERVICEACCOUNT_PROD
        - - Profile da conta de produção (ifood-lite-production - 849197578363)

    - IFOOD_LITE_SERVICEACCOUNT_QA
        - Profile da conta de sandbox (ifood-lite-sandbox - 774504999002)
