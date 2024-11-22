<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%> 
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Valor Total</title>
        <link rel="stylesheet" href="tabelas.css">
        <style>
            /* Estilo da tabela */
            table {
                margin: 20px auto;
                border-collapse: collapse;
                width: 50%;
                font-family: Arial, sans-serif;
            }

            table, th, td {
                border: 1px solid #ccc;
                text-align: left;
                padding: 10px;
            }

            /* Estilo do botão */
            .payment-button {
                display: block;
                margin: 20px auto;
                padding: 15px 30px;
                font-size: 18px;
                font-weight: bold;
                color: white;
                background: linear-gradient(45deg, #6a11cb, #2575fc);
                border: none;
                border-radius: 25px;
                cursor: pointer;
                transition: transform 0.3s ease, background 0.3s ease;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            .payment-button:hover {
                transform: scale(1.05);
                background: linear-gradient(45deg, #2575fc, #6a11cb);
            }

            .payment-button:active {
                transform: scale(0.95);
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            }
        </style>
    </head>
    <body>
        <%
            int Loja = Integer.parseInt(request.getParameter("Loja"));
            int Cod = Integer.parseInt(request.getParameter("Cod"));



            String jdbcUrl = "jdbc:mysql://yacsu.mysql.database.azure.com:3306/controle_estoque?zeroDateTimeBehavior=CONVERT_TO_NULL";
            String jdbcUser = "Yacsu77";
            String jdbcPassword = "pedro123@";

            Connection conecta = null;
            PreparedStatement st = null;
            ResultSet resultado = null;
            double totalValor = 0.0; // Variável inicializada fora do bloco try

            try {
                /* Conectar com o banco de dados */
                Class.forName("com.mysql.cj.jdbc.Driver");
                conecta = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);

                /* Query para somar os valores */
                String query = "SELECT SUM(valor) AS total_valor FROM venda WHERE secao_caixa = ?";
                st = conecta.prepareStatement(query);
                st.setInt(1, Cod);
                resultado = st.executeQuery();

                /* Exibir o valor total */
                if (resultado.next()) {
                    totalValor = resultado.getDouble("total_valor");
                    out.print("<table>");
                    out.print("<tr><td>Valor Total a Pagar:</td><td>" + totalValor + " R$</td></tr>");
                    out.print("</table>");
                } else {
                    out.print("Nenhum registro encontrado para a seção caixa " + Cod);
                }
            } catch (Exception e) {
                out.print("Erro: " + e.getMessage());
            } finally {
                if (resultado != null) try { resultado.close(); } catch (Exception ignore) {}
                if (st != null) try { st.close(); } catch (Exception ignore) {}
                if (conecta != null) try { conecta.close(); } catch (Exception ignore) {}
            }
        %>

        <%
    out.print("<a href=\"sucesso.jsp\">" +
              "<button class='payment-button'> Finalizar Pagamento </button>" +
              "</a>");
%>

    </body>
</html>
