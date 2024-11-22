<%@ page import="java.sql.*" %>


<%
    int id = Integer.parseInt(request.getParameter("id"));
%>




<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro de Empresa</title>
    <link rel="stylesheet" href="cadastro_empesa.css"> <!-- Se houver um CSS para estilizar -->
</head>
<body>
    <h2>Cadastro de Empresa</h2>
    <form action="Cadastrar_fornecedor.jsp?id=<%= id %>" method="post">
        
        <label for="Fornecedor">Nome da Fornecedor:</label>
        <input type="text" id="Fornecedor" name="Fornecedor" required>

        <label for="cnpj">CNPJ:</label>
        <input type="text" id="cnpj" name="cnpj" required>

        <button type="submit">Cadastrar Fornecedor</button>
    </form>
</body>
</html>
