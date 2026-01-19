*** Keywords ***
Abrir Aplicacao E Logar
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Input Text      id:email    ${EMAIL}
    Input Text      id:senha    ${SENHA}
    Click Button    //button[@type='submit']
    Wait Until Element Is Visible    link:Contas    timeout=10s


Ir Para Cadastro De Contas
    Click Link    Contas
    Click Link    Adicionar

Inserir Conta
    [Arguments]    ${nome_conta}
    Input Text    id:nome    ${nome_conta}
    Click Button  //button[@type='submit']

Validar Mensagem
    [Arguments]    ${mensagem_esperada}
    # Captura screenshot para debug (sempre bom deixar comentado ou ativar quando falhar)
    # Capture Page Screenshot    debug_${mensagem_esperada.replace(' ', '_')}.png

    # Opção 1 - Mais robusta: espera até 12s e continua mesmo se sumir depois
    Wait Until Page Contains    ${mensagem_esperada}    timeout=12s

    # Opção 2 - Ainda melhor: valida presença em elemento específico da mensagem (barra verde)
    # Wait Until Element Is Visible    css:.alert-success    timeout=8s
    # Element Should Contain           css:.alert-success    ${mensagem_esperada}
