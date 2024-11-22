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
    <title>Cadastro de Empresa</title>
    <link rel="stylesheet" href="cadastro_empesa.css"> <!-- Se houver um CSS para estilizar -->
</head>
<body>
    <h2>Cadastro de Empresa</h2>
    <form action="Alterar_gerente.jsp?Cod=<%= id %>&Id_pro=<%= Cod %>" method="post">
        
        <label for="Gerente">Gerente:</label>
        <input type="text" id="Gerente" name="Gerente" required>

        <label for="CPF">CPF</label>
        <input type="text" id="CPF" name="CPF" required>
        
        <label for="Senha">Senha</label>
        <input type="password" id="Senha" name="Senha" required>

        <button type="submit">Cadastrar Gerente</button>
    </form>
</body>
</html>
