<%@ page import="java.sql.*" %>


<%
    int id = Integer.parseInt(request.getParameter("id"));
    int Cod = Integer.parseInt(request.getParameter("Cod"));

%>




<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alterar de Empresa</title>
    <link rel="stylesheet" href="cadastro_empesa.css"> <!-- Se houver um CSS para estilizar -->
</head>
<body>
    <h2>Alterar Fornecedor</h2>
    <form action="Alterar_fornecedor.jsp?Cod=<%= id %>&Id_pro=<%= Cod %>" method="post">
        
        <label for="Fornecedor">Nome da Fornecedor:</label>
        <input type="text" id="Fornecedor" name="Fornecedor" required>

        <label for="cnpj">CNPJ:</label>
        <input type="text" id="cnpj" name="cnpj" required>

        <button type="submit">Alterar Fornecedor</button>
    </form>
</body>
</html>
