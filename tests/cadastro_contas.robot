*** Settings ***
Library     SeleniumLibrary
Library    String
Resource    ../resources/keywords.robot
Resource    ../resources/variables.robot

Test Teardown    Close Browser

*** Test Cases ***
Deve Inserir Conta Com Sucesso
    Abrir Aplicacao E Logar
    Ir Para Cadastro De Contas
    
    ${sufixo}        Generate Random String    6    [NUMBERS]
    ${nome_unico}    Set Variable              Angelica Teste ${sufixo}
    
    Inserir Conta    ${nome_unico}
    
    Wait Until Page Contains    Contas    timeout=10s
    Wait Until Page Contains    ${nome_unico}    timeout=10s
    Page Should Contain    ${nome_unico}

Nao Deve Inserir Conta Sem Nome
    Abrir Aplicacao E Logar
    Ir Para Cadastro De Contas
    Inserir Conta    ${EMPTY}
    Validar Mensagem    Informe o nome da conta

Nao Deve Inserir Conta Com Nome Existente
    Abrir Aplicacao E Logar
    Ir Para Cadastro De Contas

    # Gera um nome único com sufixo aleatório (evita conflito com contas existentes)
    ${sufixo}        Generate Random String    8    [LOWER][NUMBERS]    # ex: "abc123xy"
    ${nome_unico}    Set Variable              Conta Teste ${sufixo}

    # Primeira inserção → deve dar sucesso
    Inserir Conta    ${nome_unico}
    Validar Mensagem    Conta adicionada com sucesso!

    # Volta para a tela de adicionar conta novamente
    Ir Para Cadastro De Contas

    # Segunda inserção com o MESMO nome → deve falhar
    Inserir Conta    ${nome_unico}
    Validar Mensagem    Já existe uma conta com esse nome!

    # Opcional: captura screenshot para debug (muito útil quando falhar)
    Capture Page Screenshot    debug-conta-duplicada.png