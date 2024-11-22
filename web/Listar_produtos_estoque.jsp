<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%> 
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listagem de Produtos</title>
        <link rel="stylesheet" href="tabelas.css">
    </head>
    <body>
        <%
            int Cod = Integer.parseInt(request.getParameter("Cod"));
            int loja = Integer.parseInt(request.getParameter("loja"));

            String jdbcUrl = "jdbc:mysql://yacsu.mysql.database.azure.com:3306/controle_estoque?zeroDateTimeBehavior=CONVERT_TO_NULL";
            String jdbcUser = "Yacsu77";
            String jdbcPassword = "pedro123@";

            Connection conecta;
            PreparedStatement st;
            ResultSet resultado;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conecta = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);

                // Consulta para unir Estoque, Produto e Loja pelo código do produto e da loja
                st = conecta.prepareStatement(
                    "SELECT p.nome_produto, COUNT(e.Cod_Produto) as Quantidade, e.Data_fabricação, e.Data_validade, l.nome_loja " +
                    "FROM Estoque e " +
                    "JOIN Produto p ON e.Cod_Produto = p.id " +
                    "JOIN loja l ON e.Cod_loja = l.id " +
                    "WHERE e.Cod_loja = ? " +
                    "GROUP BY p.nome_produto, e.Data_fabricação, e.Data_validade, l.nome_loja"
                );
                st.setInt(1, loja);

                resultado = st.executeQuery();

                out.print("<table>");
                out.print("<caption>Produtos em Estoque</caption>");
                out.print("<tr><th>Produto</th><th>Quantidade</th><th>Fabricação</th><th>Validade</th><th>Loja</th></tr>");

                while(resultado.next()) {
                    out.print("<tr>");
                    out.print("<td>" + resultado.getString("nome_produto") + "</td>");
                    out.print("<td>" + resultado.getInt("Quantidade") + "</td>");
                    out.print("<td>" + resultado.getString("Data_fabricação") + "</td>");
                    out.print("<td>" + resultado.getString("Data_validade") + "</td>");
                    out.print("<td>" + resultado.getString("nome_loja") + "</td>");
                    out.print("</tr>");
                }

                out.print("</table>");

                resultado.close();
                st.close();
                conecta.close();
            } catch (Exception e) {
                out.print("<p>Erro: " + e.getMessage() + "</p>");
            }
        %>
    </body>
</html>
