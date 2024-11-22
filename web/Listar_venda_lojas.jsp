<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%> 
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Listar Vendas</title>
    <link rel="stylesheet" href="vedas.css">
</head>
<body>
<%
    String jdbcUrl = "jdbc:mysql://yacsu.mysql.database.azure.com:3306/controle_estoque?zeroDateTimeBehavior=CONVERT_TO_NULL";
    String jdbcUser = "Yacsu77";
    String jdbcPassword = "pedro123@";

    Connection conecta = null;
    PreparedStatement st = null;
    ResultSet resultado = null;

    try {
        // Obter o parâmetro Cod e verificar se é válido
        int Cod = Integer.parseInt(request.getParameter("loja"));


        // Conectar ao banco de dados
        Class.forName("com.mysql.cj.jdbc.Driver");
        conecta = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);

        // Query para somar os valores
        String querySum = "SELECT SUM(Valor) AS total_valor FROM pagementos WHERE cod_loja = ?";
        st = conecta.prepareStatement(querySum);
        st.setInt(1, Cod);
        resultado = st.executeQuery();

        // Exibir o valor total
        if (resultado.next()) {
            double totalValor = resultado.getDouble("total_valor");
            out.print("<table>");
            out.print("<tr><td>Faturamento total:</td><td>" + totalValor + " R$</td></tr>");
            out.print("</table>");
        } else {
            out.print("Nenhum registro encontrado para o código de loja " + Cod);
        }

        // Fechar o ResultSet antes de reutilizá-lo
        resultado.close();
        st.close();

        // Query para listar as vendas
        String queryList = "SELECT id, Valor FROM pagementos WHERE cod_loja = ?";
        st = conecta.prepareStatement(queryList);
        st.setInt(1, Cod);
        resultado = st.executeQuery();

        // Exibir a tabela de vendas
        out.print("<table>");
        out.print("<caption>Vendas Feitas</caption>");
        out.print("<tr><th>Venda</th><th>Valor</th></tr>");
        while (resultado.next()) {
            out.print("<tr><td>" + resultado.getInt("id") + "</td><td>" + resultado.getDouble("Valor") + " R$</td></tr>");
        }
        out.print("</table>");
    } catch (Exception e) {
        out.print("Erro: " + e.getMessage());
    } finally {
        // Fechar recursos
        if (resultado != null) try { resultado.close(); } catch (Exception e) {}
        if (st != null) try { st.close(); } catch (Exception e) {}
        if (conecta != null) try { conecta.close(); } catch (Exception e) {}
    }
%>
</body>
</html>
