<%@ page import="java.sql.*" %>

<% 
int id = Integer.parseInt(request.getParameter("id"));
%>


<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu do Gerente</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="tela_gerente.css">
</head>
<body>
    <div class="container">
        <div class="sidebar">
            <div class="sidebar-header">
                <h2>Bem vindo <%= request.getParameter("nome_empresa") %></h2>
            </div>
            <ul class="menu">
                <li><a href="Cadastra_loja_form.jsp?id=<%= id %>" target="conteudo"><button class="menu-btn">Loja</button></a></li>
                <li><a href="Cadastar_fornecedor_form.jsp?id=<%= id %>" target="conteudo"><button class="menu-btn">Fornecedor</button></a></li>
                <li><a href="Cadastrar_gerente_form.jsp?id=<%= id %>" target="conteudo"><button class="menu-btn">Gerente</button></a></li>
                <li><a href="Cadastrar_produto_form.jsp?id=<%= id %>" target="conteudo"><button class="menu-btn">Produto</button></a></li>
                <li><a href="Cadastra_funcionario_form.jsp?id=<%= id %>" target="conteudo"><button class="menu-btn">Funcionario</button></a></li>
                <li><a href="Listar_gerente.jsp?Cod=<%= id %>" target="conteudo"><button class="menu-btn">Listar Gerente</button></a></li>
                <li><a href="Listar_funcionario.jsp?Cod=<%= id %>" target="conteudo"><button class="menu-btn">Listar Funcionario</button></a></li>
                <li><a href="Listar_produtos.jsp?Cod=<%= id %>" target="conteudo"><button class="menu-btn">Listar Produto</button></a></li>
                <li><a href="Listar_loja.jsp?Cod=<%= id %>" target="conteudo"><button class="menu-btn">Listar Loja</button></a></li>
                <li><a href="Listar_fornecedor.jsp?Cod=<%= id %>" target="conteudo"><button class="menu-btn">Listar Fornecedor</button></a></li>
                <li><a href="index.html"><button class="menu-btn logout-btn">Sair</button></a></li>
                
            </ul>
        </div>
        <iframe src="Tela_iframe_inicio.html" name="conteudo" class="quadro"></iframe>
    </div>
</body>
</html>
