<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%> 
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista de Produtos</title>
        <link rel="stylesheet" href="tabelas.css">
    </head>
    <body>
        <%
        int Cod = Integer.parseInt(request.getParameter("Cod"));

        String jdbcUrl = "jdbc:mysql://yacsu.mysql.database.azure.com:3306/controle_estoque?zeroDateTimeBehavior=CONVERT_TO_NULL";
        String jdbcUser = "Yacsu77";
        String jdbcPassword = "pedro123@";

        Connection conecta = null;
        PreparedStatement st = null;
        ResultSet resultado = null;

        try {
            // Conectar com o banco de dados
            Class.forName("com.mysql.cj.jdbc.Driver");
            conecta = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);

            // Consulta com INNER JOIN usando DISTINCT
            String sql = "SELECT DISTINCT p.nome_produto, v.valor, v.id " +
                         "FROM venda v " +
                         "INNER JOIN estoque e ON v.Produto = e.Cod_Produto " +
                         "INNER JOIN produto p ON e.Cod_Produto = p.id " +
                         "WHERE v.secao_caixa = ?";

            st = conecta.prepareStatement(sql);
            st.setInt(1, Cod);
            resultado = st.executeQuery();

            // Exibir os dados na tabela
            out.print("<table>");
            out.print("<tr><th>Produto</th><th>Valor</th><th>Exclusão</th></tr>");
            while (resultado.next()) {
                out.print("<tr>");
                out.print("<td>" + resultado.getString("nome_produto") + "</td>");
                out.print("<td>" + resultado.getString("valor") + "</td>");
                out.print("<td><a href='Escluir_produto_da_venda.jsp?id=" + resultado.getString("id") + "&secao=" + Cod + "'>Excluir</a></td>");
                out.print("</tr>");
            }
            out.print("</table>");
        } catch (Exception e) {
            out.print("<p>Erro: " + e.getMessage() + "</p>");
        } finally {
            // Fechar conexões
            if (resultado != null) try { resultado.close(); } catch (Exception ignore) {}
            if (st != null) try { st.close(); } catch (Exception ignore) {}
            if (conecta != null) try { conecta.close(); } catch (Exception ignore) {}
        }
        %>
    </body>
</html>
