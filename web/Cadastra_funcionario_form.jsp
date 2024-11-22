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
    <form action="Cadastrar_funcionario.jsp?id=<%= id %>" method="post">
        
        <label for="Funcionario">Funcionario:</label>
        <input type="text" id="Funcionario" name="Funcionario" required>

        <label for="CPF">CPF</label>
        <input type="text" id="CPF" name="CPF" required>
        
        <label for="Senha">Senha</label>
        <input type="password" id="Senha" name="Senha" required>

        <button type="submit">Cadastrar Funcionario</button>
    </form>
</body>
</html>
