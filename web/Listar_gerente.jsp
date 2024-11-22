<%-- 
    Document   : lista_produtos
    Created on : 3 de set. de 2024, 11:11:26
    Author     : evandro.cteruel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%> 
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>

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

            /* Declaração de variáveis */
            Connection conecta;
            PreparedStatement st;
            ResultSet resultado;
            /* Conectar com o banco de dados... */
            Class.forName("com.mysql.cj.jdbc.Driver");
        conecta  = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);
            /*Verificar se o produto com o id informado está na tabela do BD*/
            st = conecta.prepareStatement("SELECT * FROM gerente WHERE cod_empresa = " + Cod);
            resultado = st.executeQuery(); //Executa o Select e armazena os dados do usuário
            /* percorre a variável resultado exibindo cada linha de produto */
            out.print("<table>");
            out.print("<caption>Gerente cadastrados</caption>");
            out.print("<tr><th> ID </th><th> Nome Gerente </th> <th> CPF </th><th>ID Empresa</th> <th>Exclusão</th><th>Alteração</th></tr>");      
            while(resultado.next()){
               out.print("<tr><td>" + resultado.getString("id") + "</td><td>" + resultado.getString("nome_gerente") + "</td><td>" + resultado.getString("cpf") + "</td><td>" + resultado.getString("cod_empresa") + "</td>");
                out.print("<td> <a href=Escluir_gerente.jsp?id=" + resultado.getString("id") + "&Cod=" + Cod + "> Excluir </a> </td>");
               out.print("<td> <a href=Alterar_gerante_form.jsp?id=" + resultado.getString("id") + "&Cod=" + Cod + "> Alterar </a> </td> </tr>");
            }
            out.print("</table>");
        %>
    </body>
</html>