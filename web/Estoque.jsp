<%@ page import="java.sql.*" %>

<% 
int id = Integer.parseInt(request.getParameter("id"));
%>


<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Estoque</title>
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
                
        <li><a href="Interir_produto_estoque_form.jsp?id=<%= id %>" target="conteudo"><button class="menu-btn">Entrada produto</button></a></li>
        <li><a href="Escolher_loja_estoque.jsp?id=<%= id %>" target="conteudo"><button class="menu-btn">Visualizar Estoque</button></a></li>
        <li><a href="Escolher_loja_escluir.jsp?id=<%= id %>" target="conteudo"><button class="menu-btn">Perca</button></a></li>
        <li><a href="index.html"><button class="menu-btn logout-btn">Sair</button></a></li>
                
                
               
            </ul>
        </div>
       <iframe src="Tela_iframe_inicio.html" name="conteudo" class="quadro"></iframe>
    </div>
</body>
</html>
