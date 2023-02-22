
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push
git status
git add .
git commit -m "Aula 37. Services - Loadbalancer. pt1"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# # 37. Services - Loadbalancer - Conceitos do serviço LoadBalancer - GKE

<https://cloud.google.com/kubernetes-engine/docs/concepts/service-load-balancer>

Nesta página, apresentamos uma visão geral de como o Google Kubernetes Engine (GKE) cria e gerencia os balanceadores de carga do Google Cloud quando você aplica um manifesto dos serviços do LoadBalancer do Kubernetes. Descreve os diferentes tipos de balanceadores de carga e como configurações como externalTrafficPolicy e subconfiguração do GKE para balanceadores de carga internos L4 determinam como os balanceadores de carga são configurados.

Antes de ler esta página, conheça os conceitos de rede no GKE. Depois de se familiarizar com os conceitos nesta página, consulte os parâmetros de serviço do LoadBalancer do GKE para mais opções de configuração.
Visão geral

Quando você cria um serviço LoadBalancer, o GKE configura um balanceador de carga de passagem do Google Cloud cujas características dependem dos parâmetros do seu manifesto de Serviço. Você escolhe se o balanceador de carga tem um endereço IP interno ou externo, controla como os pacotes são roteados para pods de disponibilização e especifica outros parâmetros do balanceador de carga usando o manifesto do Serviço. Nesta página, fornecemos as informações contextuais necessárias.
Tipos de balanceador de carga

Ao criar um serviço LoadBalancer no GKE, você especifica se o balanceador de carga tem um endereço interno ou externo usando uma anotação no manifesto do serviço:

    Para criar um serviço LoadBalancer interno, coloque uma das seguintes anotações no metadata.annotations[] do manifesto do serviço:
        networking.gke.io/load-balancer-type: "Internal" (GKE 1.17 e mais recente)
        cloud.google.com/load-balancer-type: "Internal" (versões anteriores a 1.17)

    Os serviços LoadBalancer internos são alimentados por balanceadores de carga TCP/UDP internos que o GKE cria na rede de nuvem privada virtual (VPC) do cluster. Os clientes localizados na mesma rede VPC ou em uma rede conectada à rede VPC do cluster podem acessar o serviço usando o endereço IP do balanceador de carga.

    Para criar um serviço LoadBalancer externo, omita as duas anotações listadas no ponto anterior. Os serviços LoadBalancer externos são alimentados por dois tipos de balanceadores de carga de rede externos, que podem ser acessados na Internet. Você controla o tipo de balanceador de carga de rede externo incluindo ou omitindo uma anotação:

        Para criar um balanceador de carga de rede baseado em serviço de back-end, coloque o seguinte em metadata.annotations[] do manifesto: cloud.google.com/l4-rbs: "enabled"

        Para criar um balanceador de carga de rede baseado em pool de destino, omita a anotação cloud.google.com/l4-rbs: "enabled".

Subconfiguração do GKE

A opção de configuração do subagrupamento do GKE para balanceadores de carga internos L4, ou subconfiguração do GKE, melhora a escalonabilidade dos balanceadores de carga TCP/UDP internos ao agrupar com mais eficiência os endpoints do nó para os back-ends do balanceador de carga. Se o cluster tiver mais de 250 nós e você precisar criar serviços LoadBalancer internos, ative a subconfiguração do GKE.

O diagrama a seguir mostra dois serviços em um cluster zonal com três nós e subconfiguração do GKE ativado. Cada serviço tem dois pods. O GKE cria um grupo de endpoints de rede GCE_VM_IP (NEG, na sigla em inglês) para cada serviço. Os endpoints em cada NEG são os nós com os pods de exibição para o respectivo serviço.

É possível ativar a subconfiguração do GKE ao criar ou editar um cluster. Depois de ativado, não será possível desativar a subconfiguração do GKE. Para mais informações, consulte subconfiguração do GKE.

A subconfiguração do GKE requer:

    GKE versão 1.18.19-gke.1400 ou posterior e
    O complemento HttpLoadBalancing ativado para o cluster. Esse complemento é ativado por padrão. Ele permite que o cluster gerencie balanceadores de carga que usam serviços de back-end.

Observação: o subagrupamento do GKE é diferente do subagrupamento de back-end do balanceamento de carga TCP/UDP interno do Google Cloud. Os balanceadores de carga TCP/UDP internos criados pelo GKE nunca estão configurados para usar a subconfiguração de back-end de balanceamento de carga TCP/UDP interno.
Agrupamento de nós

As anotações do manifesto do serviço e o status da subconfiguração do GKE determinam o balanceador de carga do Google Cloud resultante e o tipo de back-end. Os back-ends dos balanceadores de carga de passagem do Google Cloud identificam a interface de rede (NIC, na sigla em inglês) do nó do GKE, não um nó específico ou endereço IP do pod. O tipo de balanceador de carga e back-ends determinam como os nós são agrupados em NEGs GCE_VM_IP, grupos de instâncias ou pools de destino.
Serviço LoadBalancer do GKE 	Balanceador de carga do Google Cloud resultante 	Método de agrupamento de nós
Serviço interno LoadBalancer criado em um cluster com a subconfiguração do GKE ativada1 	Um balanceador de carga TCP/UDP interno com um serviço de back-end que usa back-ends de grupo de endpoints de rede (NEG, na sigla em inglês) GCE_VM_IP 	

As VMs de nós são agrupadas por zona em NEGs de GCE_VM_IP por serviço de acordo com o externalTrafficPolicy do serviço e o número de nós no cluster.

O externalTrafficPolicy do serviço também controla quais nós passam na verificação de integridade do balanceador de carga e no processamento de pacotes.
Serviço interno LoadBalancer criado em um cluster com a subconfiguração do GKE desativada 	Um balanceador de carga TCP/UDP interno com um serviço de back-end que usa back-ends de grupos de instâncias não gerenciadas zonais 	

Todas as VMs de nós são colocadas em grupos de instâncias não gerenciadas zonais que o GKE usa como back-ends para o serviço de back-end do balanceador de carga TCP/UDP interno.

O externalTrafficPolicy do serviço controla quais nós passam na verificação de integridade do balanceador de carga e no processamento de pacotes.

Os mesmos grupos de instâncias não gerenciadas são usados para outros serviços de back-end do balanceador de carga criados no cluster devido à limitação do grupo de instâncias com balanceamento de carga único.
Serviço LoadBalancer externo com a anotação cloud.google.com/l4-rbs: "enabled"2 	Um balanceador de carga de rede baseado em serviço de back-end com um serviço de back-end que usa back-ends zonais de grupos de instâncias não gerenciadas . 	

Todas as VMs de nós são colocadas em grupos de instâncias não gerenciadas zonais que o GKE usa como back-ends para o serviço de back-end do balanceador de carga da rede.

O externalTrafficPolicy do serviço controla quais nós passam na verificação de integridade do balanceador de carga e no processamento de pacotes.

Os mesmos grupos de instâncias não gerenciadas são usados para outros serviços de back-end do balanceador de carga criados no cluster devido à limitação do grupo de instâncias com balanceamento de carga único.
Serviço externo do LoadBalancer sem a anotação cloud.google.com/l4-rbs: "enabled"3 	Um balanceador de carga de rede baseado em pool de destino em que o pool de destino contém todos os nós do cluster 	

O pool de destino é uma API legada que não depende de grupos de instâncias. Todos os nós têm associação direta no pool de destino.

O externalTrafficPolicy do serviço controla quais nós passam na verificação de integridade do balanceador de carga e no processamento de pacotes.

1 Somente os balanceadores de carga TCP/UDP internos criados após a ativação da subconfiguração do GKE usam GCE_VM_IP NEGs. Todos os serviços LoadBalancer internos criados antes de ativar a subconfiguração do GKE continuam usando back-ends de grupos de instâncias não gerenciadas. Para exemplos e orientações de configuração, consulte Como criar serviços internos do LoadBalancer.

2O GKE não migra automaticamente os serviços atuais do LoadBalancer de balanceadores de carga de rede baseados em pool de destino para balanceadores de carga de rede baseados em serviço de back-end. Para criar um serviço LoadBalancer externo com a tecnologia de um balanceador de carga de rede baseado em serviço de back-end, inclua a anotação cloud.google.com/l4-rbs: "enabled" no manifesto do serviço no momento da criação.

3Remover a anotação cloud.google.com/l4-rbs: "enabled" de um serviço LoadBalancer externo alimentado por um balanceador de carga de rede baseado em serviço de back-end não faz com que o GKE crie um pool de destino com base no balanceador de carga da rede. Para criar um serviço LoadBalancer externo com a tecnologia de um balanceador de carga de rede baseado em pool de destino, omita a anotação cloud.google.com/l4-rbs: "enabled" do manifesto do serviço no momento da criação.
Assinatura de nós em GCE_VM_IP back-ends NEG

Quando a subconfiguração do GKE está ativada em um cluster, o GKE cria um NEG GCE_VM_IP em cada zona para cada serviço LoadBalancer interno. Ao contrário dos grupos de instâncias, os nós podem ser membros de mais de um NEG GCE_VM_IP com balanceamento de carga. O externalTrafficPolicy do serviço e o número de nós no cluster determinam quais nós são adicionados como endpoints aos NEGs GCE_VM_IP do serviço.
Observação: o NEG GCE_VM_IP é diferente do tipo GCE_VM_IP_PORT de NEG zonal usado para balanceamento de carga de entrada nativo de contêiner. GCE_VM_IP NEGs identificam as interfaces de rede de VMs de nós pelo endereço IP do nó. No entanto, os pacotes têm destinos que correspondem ao endereço IP da regra de encaminhamento do balanceador de carga e a uma das portas configuradas para a regra de encaminhamento.

O plano de controle do cluster adiciona nós como endpoints aos NEGs GCE_VM_IP de acordo com o valor de externalTrafficPolicy do Serviço e com o número de nós no cluster, conforme resumido na tabela a seguir.
externalTrafficPolicy 	Número de nós no cluster 	Associação de endpoint
Cluster 	1 a 25 nodes 	O GKE usa todos os nós do cluster como endpoints para os NEGs do serviço, mesmo que um nó não contenha um pod de exibição para o serviço.
Cluster 	Mais de 25 nós 	O GKE usa um subconjunto aleatório de 25 nós como endpoints para os NEGs do serviço, mesmo que um nó não contenha um pod de exibição para o serviço.
Local 	qualquer número de nós1 	O GKE usa apenas nós que têm pelo menos um dos pods de exibição do serviço como endpoints para os NEGs do serviço.

1Limitado a 250 nós com pods de exibição para serviços internos do LoadBalancer. Mais de 250 nós podem estar presentes no cluster, mas os balanceadores de carga TCP/UDP internos só serão distribuídos para 250 VMs de back-end quando a subconfiguração de back-end do balanceamento de carga TCP/UDP interno for desativada. Mesmo com a subconfiguração do GKE ativada, o GKE nunca configura os balanceadores de carga TCP/UDP internos com a subconfiguração de back-end de balanceamento de carga TCP/UDP interno. Para detalhes sobre esse limite, consulte Número máximo de instâncias de VM por serviço de back-end interno.
Limitação única de grupos de instâncias com carga balanceada

A API Compute Engine proíbe VMs de serem membros de mais de um grupo de instâncias com carga balanceada. Os nós do GKE estão sujeitos a essa restrição.

Ao usar back-ends de grupos de instâncias não gerenciadas, o GKE cria ou atualiza grupos de instâncias não gerenciadas com todos os nós de todos os pools de nós em cada zona que o cluster usa. Esses grupos de instâncias não gerenciadas são usados para:

    Balanceadores de carga TCP/UDP criados para serviços LoadBalancer internos quando a subconfiguração do GKE está desativada.
    Balanceadores de carga de rede baseados em serviço de back-end criados para serviços LoadBalancer externos com a anotação cloud.google.com/l4-rbs: "enabled".
    Balanceadores de carga HTTP(S) externos criados para recursos externos de Entrada do GKE, usando o controlador de Entrada do GKE, mas não usando balanceamento de carga nativo de contêiner.

Como as VMs de nós não podem ser membros de mais de um grupo de instâncias com carga balanceada, o GKE não pode criar e gerenciar balanceadores de carga TCP/UDP internos, balanceadores de carga de rede baseados em serviço de back-end e balanceadores de carga HTTP(S) externos criados para recursos de Entrada do GKE se uma das seguintes condições for verdadeira:

    Fora do GKE, você criou pelo menos um balanceador de carga baseado em serviço de back-end e usou os grupos de instâncias gerenciadas do cluster como back-ends para o serviço de back-end do balanceador de carga.
    Fora do GKE, você cria um grupo personalizado de instâncias não gerenciadas que contém alguns ou todos os nós do cluster e, em seguida, anexa esse grupo personalizado a um serviço de back-end para um balanceador de carga.

Para contornar essa limitação, é possível instruir o GKE a usar back-ends de NEG sempre que possível:

    Ativar o subagrupamento do GKE. Como resultado, os novos serviços internos do LoadBalancer usam NEGs GCE_VM_IP.
    Configure recursos externos do Ingress do GKE para usar o balanceamento de carga nativo do contêiner. Para mais informações, consulte Balanceamento de carga nativo do contêiner do GKE.

Verificações de integridade do balanceador de carga

Todos os serviços do GKE LoadBalancer exigem uma verificação de integridade do balanceador de carga. A verificação de integridade do balanceador de carga é implementada fora do cluster e é diferente de uma sondagem de prontidão ou atividade.

O externalTrafficPolicy do serviço define como a verificação de integridade do balanceador de carga opera. Em todos os casos, as sondagens de verificação de integridade do balanceador de carga enviam pacotes para o software kube-proxy em execução em cada nó. A verificação de integridade do balanceador de carga é um proxy para as informações que o kube-proxy coleta, como se um pod existe, está em execução e passou na sondagem de prontidão. As verificações de integridade para serviços LoadBalancer não podem ser roteadas para pods de disponibilização. A verificação de integridade do balanceador de carga foi projetada para direcionar novas conexões TCP para nós.

A tabela a seguir descreve o comportamento da verificação de integridade:
externalTrafficPolicy 	Quais nós passam na verificação de integridade 	Qual porta é usada
Cluster 	Todos os nós do cluster passam na verificação de integridade, mesmo que ele não esteja executando um pod de disponibilização. 	A porta de verificação de integridade do balanceador de carga precisa ser a porta TCP 10256. Ela não pode ser personalizada.
Local 	

Apenas os nós com pelo menos um pod pronto e em exibição são aprovados na verificação de integridade. Os nós sem um pod de exibição e nós com pods de exibição que ainda não passaram nas sondagens de prontidão falharão na verificação de integridade.

Se o pod de exibição tiver falhado na sondagem de prontidão ou estiver prestes a ser encerrado, um nó ainda poderá passar na verificação de integridade do balanceador de carga, mesmo que não contenha um pod pronto e em veiculação. Essa situação acontece quando a verificação de integridade do balanceador de carga ainda não atingiu o limite de falhas. O modo como o pacote é processado nesta situação depende da versão do GKE. Para mais detalhes, consulte a próxima seção, Processamento de pacotes.
	A porta de verificação de integridade é TCP 10256, a menos que você especifique uma porta de verificação de integridade personalizada.
Processamento de pacotes

As seções a seguir detalham como o balanceador de carga e os nós do cluster trabalham juntos para rotear pacotes recebidos para os serviços LoadBalancer.
Balanceamento de carga de passagem

O balanceador de carga de passagem do Google Cloud roteia pacotes para a interface nic0 dos nós do cluster do GKE. Cada pacote com carga balanceada recebida por um nó tem as seguintes características:

    O endereço IP de destino do pacote corresponde ao endereço IP da regra de encaminhamento do balanceador de carga.
    O protocolo e a porta de destino do pacote correspondem a estes dois protocolos:
        um protocolo e uma porta especificados em spec.ports[] do manifesto do serviço
        um protocolo e uma porta configurados na regra de encaminhamento do balanceador de carga

Conversão de endereços de rede de destino nos nós

Depois que o nó recebe o pacote, ele realiza esse processamento extra. Em clusters do GKE sem o GKE Dataplane V2 ativado, os nós usam iptables para processar pacotes com carga balanceada. Em clusters do GKE com o GKE Dataplane V2 ativado, os nós usam eBPF. O processamento de pacotes no nível do nó sempre inclui as seguintes ações:

    O nó executa a conversão de endereços de rede de destino (DNAT, na sigla em inglês) no pacote, definindo o endereço IP de destino como um endereço IP do pod de exibição.
    O nó altera a porta de destino do pacote para targetPort do spec.ports[] do serviço correspondente.

Conversão de endereços de rede de origem em nós

O externalTrafficPolicy determina se o processamento de pacotes no nível do nó também executa a conversão de endereços de rede de origem (SNAT), bem como o caminho que o pacote leva do nó ao pod:
externalTrafficPolicy 	Comportamento de SNAT do nó 	Comportamento de roteamento
Cluster 	O nó altera o endereço IP de origem dos pacotes com carga balanceada para corresponder ao endereço IP do nó que o recebeu do balanceador de carga. 	

O nó roteia pacotes para qualquer pod de exibição. O pod de exibição pode ou não estar no mesmo nó.

Se o nó que recebe os pacotes do balanceador de carga não tiver um pod pronto e em veiculação, o nó encaminhará os pacotes para um nó diferente que contenha um pod pronto e em veiculação. Os pacotes de resposta do pod são roteados do nó de volta para o nó que recebeu os pacotes de solicitação do balanceador de carga. Em seguida, esse primeiro nó envia os pacotes de resposta ao cliente original usando o retorno direto do servidor.
Local 	O nó não altera o endereço IP de origem dos pacotes com carga balanceada. 	

Na maioria das situações, o nó encaminha o pacote para um pod de veiculação em execução no nó que recebeu o pacote do balanceador de carga. Esse nó envia pacotes de resposta ao cliente original usando o retorno direto do servidor. Essa é a intenção principal desse tipo de política de tráfego.

Em algumas situações, um nó pode receber pacotes do balanceador de carga mesmo que ele não tenha um pod pronto e em veiculação para o serviço. Essa situação pode acontecer quando a verificação de integridade do balanceador de carga ainda não tiver atingido o limite de falha, mas um pod pronto e em veiculação anteriormente não está mais pronto. O modo como os pacotes são processados nesta situação dependem da versão do GKE:

    Kubernetes 1.14 e anteriores: os pacotes são descartados.
    Nas versões 1.15 e posteriores, o GKE encaminha os pacotes para um nó diferente com um pod pronto e em veiculação.

Preços e cotas

Os preços de rede se aplicam aos pacotes processados por um balanceador de carga. Para mais informações, consulte Preços do Cloud Load Balancing e de regras de encaminhamento. Também é possível estimar as cobranças de faturamento usando a calculadora de preços do Google Cloud.

O número de regras de encaminhamento que você pode criar é controlado por cotas do balanceador de carga:

    O balanceamento de carga TCP/UDP interno usa a quota de serviços de back-end por projeto, a quota de verificações de integridade por projeto e as regras de encaminhamento do balanceador de carga de TCP/UDP interno por quota de rede da nuvem privada virtual.
    Os balanceadores de carga de rede baseados em serviço de back-end usam a cota de serviços de back-end por projeto, a cota de verificações de integridade por projeto e a cota de regra de encaminhamento de balanceamento de carga de rede TCP/UDP externo.
    Os balanceadores de carga de rede baseados em pool de destino usam a quota de pools de destino por projeto, a cota de verificações de integridade por projeto e a quota de Rede TCP/UDP externa por projeto de regras de encaminhamento de balanceamento de carga.
