#!/bin/bash

##################################################################################################################
# Script para criar novo usuario e adicionar em grupo todos a partir de uma lista.                               #
														 #	
# Utilizacao do script:												 #
#./seuscript.sh nomedalistaextraida										 #
														 #	
# Exemplo:													 #
#./users.sh lista_de_usuarios											 #
														 #
# OBS: E preciso utilizar um arquivo com: (nomedousuario, senha) para criar user e adiconar em grupo		 #
# Na opcao Grupo, temos que mudar o nome do grupo que deseja ser adicionado a partir da lista.			 #
														 #
##################################################################################################################

# Exibição do Menu
clear
echo "Escolha uma Opção:"
echo
echo "1 - Criar usuários"
echo "2 - Adicionar usuários em  grupo"
echo "q - sair"
echo
read -p "Opção: " opcao
echo



# Rotinas das Opções
case "$opcao" in
   1)
        echo -e "\nOpcao 1 selecionada\n"
              sleep 2               


# Contador de linhas
CONTADOR=$(wc -l <$1)


# Separador definido para caracter em linhas
IFS=$'\n'

# Ler as linhas do arquivo csv
read -d '' -ra dadosuser <$1

	echo "Lendo arquivo $1"
	sleep 3
	echo -e "\n$CONTADOR usuarios foram carregador"

IFS=','

for dadosuser in "${dadosuser[@]}"
do
	# Dividir as credenciais  duas (usuario e senha)
	read iuser ipasswd <<< "$dadosuser"

	# Criar usuario
	sudo useradd -m $iuser >/dev/null 2>&1

	# Definicao da senha
	echo "$ipasswd"$'\n'"$ipasswd" | passwd $iuser >/dev/null 2>&1

done
	sleep 3
	echo -e "\nCriando usuarios...."
	sleep 3
	echo -e "\n$CONTADOR usuarios foram criados com sucesso\n"
	sleep 1
;;


	2)
        	echo -e "\nOpcao 2 selecionada"
       

CONTADOR=$(wc -l <$1)


IFS=$'\n'

# Ler as linhas do arquivo csv
read -d '' -ra nomeusuario <$1

	echo -e  "\nLendo arquivo $1"
	sleep 3
	echo -e "\n$CONTADOR usuarios foram carregador"

IFS=','

for nomeusuario  in "${nomeusuario[@]}"
do
        read iuser ipasswd <<< "$nomeusuario"

	# Adicionar no grupo    #Mudar(Financeiro para o grupo desejado)
	sudo gpasswd -a $iuser Financeiro 	
done
	

	echo -e "\n$CONTADOR usuarios foram adicionado no grupo\n"
	sleep 3
        ;;
esac
