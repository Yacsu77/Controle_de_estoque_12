<%@ page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="tabelas.css">
    </head>
    <body>


<%
    int Cod = Integer.parseInt(request.getParameter("Cod"));

    String jdbcUrl = "jdbc:mysql://yacsu.mysql.database.azure.com:3306/controle_estoque?zeroDateTimeBehavior=CONVERT_TO_NULL";
    String jdbcUser = "Yacsu77";
    String jdbcPassword = "pedro123@";

    Connection conecta;
    PreparedStatement st;
    ResultSet resultado;

    Class.forName("com.mysql.cj.jdbc.Driver");
    conecta = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);

    // Consulta que faz o JOIN entre as tabelas `loja` e `gerente`
    st = conecta.prepareStatement(
        "SELECT loja.id, loja.nome_loja, gerente.nome_gerente " +
        "FROM loja " +
        "JOIN gerente ON loja.gerente = gerente.id " +
        "WHERE loja.cod_empresa = ?"
    );
    st.setInt(1, Cod);
    resultado = st.executeQuery();

    out.print("<table>");
    out.print("<caption>Gerentes Cadastrados</caption>");
    out.print("<tr><th>ID</th><th>Filial</th><th>Gerente Responsável</th><th>Exclusão</th><th>Alteração</th></tr>");
    
    while (resultado.next()) {
        out.print("<tr><td>" + resultado.getString("id") + "</td><td>" + resultado.getString("nome_loja") + "</td><td>" + resultado.getString("nome_gerente") + "</td>");
        out.print("<td> <a href=Escluir_loja.jsp?id=" + resultado.getString("id") + "&Cod=" + Cod + "> Excluir </a> </td>");
        out.print("<td><a href='Alterar_loja_form.jsp?id=" + resultado.getString("id") + "&Cod=" + Cod + "'>Alterar</a></td></tr>");
    }
    out.print("</table>");

    resultado.close();
    st.close();
    conecta.close();
%>
